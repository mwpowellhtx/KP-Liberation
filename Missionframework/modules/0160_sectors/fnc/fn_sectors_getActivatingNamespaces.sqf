#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getActivatingNamespaces

    File: fn_sectors_getActivatingNamespaces.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-07 16:57:12
    Last Update: 2021-04-21 17:28:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the ACTIVATING SECTOR NAMESPACES for consideration by the state machine
        GET SECTOR LIST callback. For now we focus on just those SECTORS potentially being
        activated that are done so by BLUFOR UNITS, but could very easily see this happening
        for OPFOR UNITS as well, i.e. during aspects such as REINFORCE, COUNTERATTACK, etc.

    Parameter(s):
        NONE

    Returns:
        A next set of ACTIVATING CBA SECTOR NAMESPACES [ARRAY]

    References:
        https://community.bistudio.com/wiki/select#Alternative_Syntax_4
        https://community.bistudio.com/wiki/distance2D
        https://community.bistudio.com/wiki/getPos
        https://community.bistudio.com/wiki/getPosATL
        https://community.bistudio.com/wiki/sort
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

private _debug = MPARAM(_getActivatingNamespaces_debug);

if (_debug) then {
    [format ["[fn_sectors_getActivatingNamespaces] Entering: [count MVAR(_activeNamespaces)]: %1"
        , str [count MVAR(_activeNamespaces)]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// The ACTIVATING SECTOR marker names themselves
private _activating = [];

// TODO: TBD: which may also trigger a HUD...
// Already reached maximum sector activation
if (count MVAR(_activeNamespaces) >= MPARAM(_maxAct)) exitWith {
    if (_debug) then {
        ["[fn_sectors_getActivatingNamespaces] Max activated", "SECTORS", true] call KPLIB_fnc_common_log;
    };
    // Which should be empty, but for emphasis we want the NAMESPACES not the MARKER NAMES
    _activating;
};

private _inactive = MVAR(_namespaces) - MVAR(_activeNamespaces);
private _targetActivatingCount = MPARAM(_maxAct) - (count MVAR(_activeNamespaces));

/* Allowing for both ENEMY as well as FRIENDLY units to 'activate' sectors; this will become more important
 * to us when we approach garrisons for BLUFOR sector defense versus counterattack missions and so forth. */
private _getMinimumUnitRange = {
    params [
        [Q(_namespace), locationNull, [locationNull]]
        , [Q(_ascending), true, [true]]
    ];
    private _markerPos = _namespace getVariable [QMVAR(_markerPos), +KPLIB_zeroPos];
    // TODO: TBD: we may want to separate out this question
    // TODO: TBD: i.e. we 'prefer' for player side to activate first...
    // TODO: TBD: but we must also allow for scenarios such as COUNTERATTACK to properly engage sectors...
    private _units = [_markerPos, MPARAM(_actRange), [KPLIB_preset_sideE, KPLIB_preset_sideF]] call KPLIB_fnc_units_getNear;
    // We do not care about the unit itself we just need the range
    private _ranges = _units apply { _x distance2D _markerPos; };
    _ranges sort _ascending;
    _ranges params [
        [Q(_range), -1, [0]]
    ];
    _range;
};

// Identify CBA SECTOR NAMESPACES with UNITS within any range
private _ranges = _inactive apply { [_x, [_x] call _getMinimumUnitRange]; } select { (_x#1) >= 0; };

if (_debug) then {
    [format ["[fn_sectors_getActivatingNamespaces] Activating: [count _ranges, _ranges]: %1"
        , str [count _ranges, _ranges]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Order those SECTORS in ASCENDING order and splice just the first several i.e. to target count
private _sorted = [_ranges, [], { _x#1; }] call BIS_fnc_sortBy;
private _selected = _sorted select [0, (count _sorted) min _targetActivatingCount];

if (_debug) then {
    [format ["[fn_sectors_getActivatingNamespaces] Fini: [_targetActivatingCount, count _selected]: %1"
        , str [_targetActivatingCount, count _selected]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Filter just the ACTIVATING NAMESPACES and relay those SERVER EVENTS
_activating = _selected apply { (_x#0); };

{ [KPLIB_sectors_activating, [_x]] call CBA_fnc_serverEvent;  } forEach _activating;

_activating;
