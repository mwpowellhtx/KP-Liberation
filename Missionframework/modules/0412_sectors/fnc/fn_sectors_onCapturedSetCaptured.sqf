#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onCapturedSetCaptured

    File: fn_sectors_onCapturedSetCaptured.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 21:55:06
    Last Update: 2021-06-14 16:51:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Sets the 'KPLIB_captured' variable on the SECTOR itself, which prohibits the
        SECTOR from being re-captured immediately following capture during the same
        ACTIVATION life cycle.

    Parameters:
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onCapturedSetCaptured_debug)
    || (_sector getVariable [QMVAR(_onCapturedSetCaptured_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_onCapturedSetCaptured] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Which prohibits sector from being captured by lingering OPFOR all over again until it deactivates
{ _sector setVariable _x; } foreach [
    [Q(KPLIB_captured), true]
    , [QMVAR(_timer), nil]
];

if (_debug) then {
    ["[fn_sectors_onCapturedSetCaptured] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
