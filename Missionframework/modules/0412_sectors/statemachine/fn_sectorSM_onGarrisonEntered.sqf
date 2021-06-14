#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onGarrisonEntered

    File: fn_sectorSM_onGarrisonEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 15:03:54
    Last Update: 2021-06-14 16:57:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        GARRISON 'onStateEntered' event handler.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onGarrisonEntered_debug)
    || (_sector getVariable [QMVARSM(_onGarrisonEntered_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorSM_onGarrisonEntered] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

// Raise REGIMENT followed by GARRISON
[QMVAR(_regiment), [_sector]] call CBA_fnc_serverEvent;
[QMVAR(_garrison), [_sector]] call CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_sectorSM_onGarrisonEntered] Fini", "SECTORSM", true] call KPLIB_fnc_common_log;
};

true;
