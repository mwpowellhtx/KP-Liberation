#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onCapturedUpdateArrays

    File: fn_sectors_onCapturedUpdateArrays.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 21:37:34
    Last Update: 2021-06-14 16:51:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Updates the SECTOR arrays when a sector has been captured, one way or the
        other, to which ever side just did the capturing.

    Parameters:
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onCapturedUpdateArrays_debug)
    || (_sector getVariable [QMVAR(_onCapturedUpdateArrays_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];
private _captured = _sector getVariable [Q(KPLIB_captured), false];

if (_debug) then {
    [format ["[fn_sectors_onCapturedUpdateArrays] Entering: [_markerName, markerText _markerName, _captured]: %1"
        , str [_markerName, markerText _markerName, _captured]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Bottom line we record the SECTOR MARKER in the BLUFOR vector
if (_captured) then {
    MVAR(_blufor) pushBackUnique _markerName;
} else {
    // Assumes sector was BLUFOR
    MVAR(_blufor) = MVAR(_blufor) - [_markerName];
};

publicVariable QMVAR(_blufor);

private _opforSectors = [] call MFUNC(_getOpforSectors);

if (_debug) then {
    [format ["[fn_sectors_onCapturedUpdateArrays] Fini: [count %1, count _opforSectors]: %2"
        , QMVAR(_blufor), str [count MVAR(_blufor), count _opforSectors]]
        , "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
