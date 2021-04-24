#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_getSectorsList

    File: fn_sectorsSM_getSectorsList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 21:09:35
    Last Update: 2021-04-24 11:17:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the next set of CBA SECTOR namespaces approaching a next round
        of CBA statemachine processing.

    Parameter(s):
        NONE

    Returns:
        An ARRAY containing the active CBA SECTOR namespaces [ARRAY]
 */

private _debug = MPARAMSM(_onGetContextList_debug);

if (!KPLIB_campaignRunning) exitWith {
    [];
};

// TODO: TBD: actually, the question needs to be broader than that...
// TODO: TBD: counts for both OPFOR as well as BLUFOR, for reasons:
// TODO: TBD: i.e. sector BLUFOR, CIVREP sufficiently negative, may spawn IEDs, insurgents, etc
// TODO: TBD: i.e. there may be OPFOR nearby, sector may be garrisoned, defended, etc
// TODO: TBD: i.e.
// TODO: TBD: i.e.
// TODO: TBD: i.e.

// Refresh the OPFOR SECTORS, will be useful during the SECTOR REFRESH
[] call MFUNC(_getOpforSectors);

// ACTIVE SECTORS are literally any sector with a STATUS better than STANDBY
private _active = MVAR(_activeNamespaces) select {
    private _status = _x getVariable [QMVAR(_status), MSTATUS(_standby)];
    _status > MSTATUS(_standby);
};

if (_debug) then {
    [format ["[fn_sectorsSM_getSectorsList] Deactivated: [count _active, count MVAR(_activeNamespaces)]: %1"
        , str [count _active, count MVAR(_activeNamespaces)]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    {
        private _namespace = _x;
        private _markerName = _namespace getVariable [QMVAR(_markerName), ""];
        private _markerText = markerText _markerName;
        private _statusReport = [_x] call MFUNC(_getStatusReport);
        [format ["[fn_sectorsSM_getSectorsList] Before activating: [_markerName, _markerText, _statusReport]: %1"
            , str [_markerName, _markerText, _statusReport]], "SECTORS", true] call KPLIB_fnc_common_log;
    } forEach _active;
};

private _activating = [] call MFUNC(_getActivatingNamespaces);

// Unset the DEACTIVATING conditions on the way back in just in case we got stuck there
{
    [_x, MSTATUS(_deactivatingDeactivated), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetVar;
} forEach _activating;

// Relay the still active appended namespaces to the module variable
MVAR(_activeNamespaces) = _active + _activating;

if (_debug) then {
    {
        private _namespace = _x;
        private _markerName = _namespace getVariable [QMVAR(_markerName), ""];
        private _markerText = markerText _markerName;
        private _statusReport = [_x] call MFUNC(_getStatusReport);
        [format ["[fn_sectorsSM_getSectorsList] After activating: [_markerName, _markerText, _statusReport]: %1"
            , str [_markerName, _markerText, _statusReport]], "SECTORS", true] call KPLIB_fnc_common_log;
    } forEach (_active + _activating);
};

// And extrapolate the ACTIVE SECTORS array based on what we now know
MVAR(_active) = MVAR(_activeNamespaces) apply { _x getVariable [QMVAR(_markerName), ""]; };
MVAR(_inactive) = MVAR(_all) - MVAR(_active);
MVAR(_opfor) = MVAR(_all) - MVAR(_blufor);

{ [MVAR(_activating), [_x]] call CBA_fnc_serverEvent; } forEach MVAR(_activeNamespaces);

// Then UPDATE MARKERS once we have identified ACTIVE SECTORS
[Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent;

if (_debug) then {
    [format ["[fn_sectorsSM_getSectorsList] Fini: [count MVAR(_activeNamespaces), count MVAR(_active), count MVAR(_inactive)]: %1"
        , str [count MVAR(_activeNamespaces), count MVAR(_active), count MVAR(_inactive)]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// For use with the CBA state machine list attribute
MVAR(_activeNamespaces);
