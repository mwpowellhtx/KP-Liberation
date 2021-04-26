#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_getSectorsList

    File: fn_sectorsSM_getSectorsList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-04-25 15:10:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the next set of CBA SECTOR namespaces approaching a next round of
        CBA statemachine processing. Primarily the function evaluates candidate sectors
        that are ACTIVATING and raises the ACTIVE Flag. Once active, sectors fall off the
        set of active sectors naturally from within the running state machine.

    Parameter(s):
        NONE

    Returns:
        The complete set of CBA SECTOR namespaces [ARRAY]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
        https://community.bistudio.com/wiki/Category:Command_Group:_Triggers
 */

// TODO: TBD: might we consider actual A3 'triggers' for purposes of activating/deactivating sectors (?)
// TODO: TBD: seems like it might be a natural fit, possibly...

private _debug = MPARAMSM(_onGetContextList_debug);

if (!KPLIB_campaignRunning) exitWith {
    [];
};

private _namespaces = MVAR(_namespaces);

private _activeNamespaces = _namespaces select {
    [_x, MSTATUS(_active), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus;
};

private _inactiveNamespaces = _namespaces - _activeNamespaces;

if (_debug) then {
    [format ["[fn_sectorsSM_getSectorsList] Entering: [count _activeNamespaces, count _inactiveNamespaces, count _namespaces]: %1"
        , str [count _activeNamespaces, count _inactiveNamespaces, count _namespaces]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: we may want to adjust for: proximity BLUFOR activating OPFOR, proximity OPFOR activating BLUFOR
// Which should be updated during REFRESH
private _triggeredNamespaces = [
    _inactiveNamespaces select { _x getVariable [QMVAR(_triggerMinRange), -1] >= 0; }
    , []
    , { _x getVariable [QMVAR(_triggerMinRange), 0]; }
    , Q(ascend)
] call BIS_fnc_sortBy;

// May be able to cover the spread, but we may also not be able to, so guard the count
private _activatingNamespaces = [_triggeredNamespaces, MPARAM(_maxAct) - (count _activeNamespaces)] call {
    params [
        [Q(_namespaces), [], [[]]]
        , [Q(_count), 0, [0]]
    ];
    if (_namespaces isEqualTo []) exitWith { []; };
    _namespaces select [0, (count _namespaces) min _count];
};

if (_debug) then {
    private _validActivatingNamespaces = _activatingNamespaces apply { _x in _namespaces; };
    [format ["[fn_sectorsSM_getSectorsList] Activating: [count _triggeredNamespaces, count _activatingNamespaces, _validActivatingNamespaces]: %1"
        , str [count _triggeredNamespaces, count _activatingNamespaces, _validActivatingNamespaces]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// Flag the ACTIVATING sectors as such
{
    [_x, MSTATUS(_active), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
    [MVAR(_activating), [_x]] call CBA_fnc_serverEvent;
} forEach _activatingNamespaces;

// Shuffle to help with perceived monotony
private _shuffledNamespaces = _namespaces call BIS_fnc_arrayShuffle;

// Returns the ACTIVE SECTOR markers, plus calculating INACTIVE SECTOR markers
[] call MFUNC(_getActiveSectors);

[Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent;

if (_debug) then {

    private _activeCount = ({
        [_x, MSTATUS(_active), QMVAR(_status)] call KPLIB_fnc_namespace_checkStatus;
    } count _namespaces);

    [format ["[fn_sectorsSM_getSectorsList] Fini: [_activeCount, count _shuffledNamespaces]: %1"
        , str [_activeCount, count _shuffledNamespaces]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// For use with the CBA state machine list attribute
_shuffledNamespaces;
