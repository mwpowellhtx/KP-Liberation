#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorTearDown

    File: fn_garrison_onSectorTearDown.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 00:44:25
    Last Update: 2021-06-14 17:12:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorTearDown_debug)
    || (_sector getVariable [QMVAR(_onSectorTearDown_debug), false])
    ;

// GARRISON one way or another whether BLUFOR+OPFOR
private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _blufor = _sector getVariable [Q(KPLIB_sectors_blufor), false];

if (_debug) then {
    [format ["[fn_garrison_onSectorTearDown] Entering: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "GARRISON"] call KPLIB_fnc_common_log;
};

// TODO: TBD: ...

if (_debug) then {
    ["[fn_garrison_onSectorTearDown] Fini", "GARRISON"] call KPLIB_fnc_common_log;
};

true;
