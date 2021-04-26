#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onIdle

    File: fn_sectorsSM_onIdle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-24 14:07:28
    Last Update: 2021-04-24 14:07:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        IDLE state event handler.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onIdle_debug)
    || (_namespace getVariable [QMVAR(_onIdle_debug), false]);

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onIdle] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// Must evaluate REFRESH 
[MVAR(_refresh), [_namespace]] call CBA_fnc_serverEvent;

if (_debug) then {
    [format ["[fn_sectorsSM_onIdle] Fini: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
