#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onCapturedShowNotification

    File: fn_sectors_onCapturedShowNotification.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 21:16:04
    Last Update: 2021-06-14 16:51:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Shows a NOTIFICATION to the PLAYERS when a SECTOR has been CAPTURED. Assumes
        that the SECTOR alignment has actually been adjusted prior to this callback
        happening. Note that this is basically an agnostic function; in other words,
        should work regardless of which ever side just captured the sector.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onCapturedShowNotification_debug)
    || (_sector getVariable [QMVAR(_onCapturedShowNotification_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];
private _blufor = _sector getVariable [QMVAR(_blufor), false];

if (_debug) then {
    [format ["[fn_sectors_onCapturedShowNotification] Entering: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "SECTORS", true] call KPLIB_fnc_common_log;
};

if (isNull _sector) exitWith {
    false;
};

private _sectorIcon = _sector getVariable [QMVAR(_sectorIcon), ""];
private _sideText = if (_blufor) then { "opfor"; } else { "blufor"; };

if (_debug) then {
    [format ["[fn_sectors_onCapturedShowNotification] Notifying: [_sideText, _sectorIcon]: %1"
        , str [_sideText, _sectorIcon]], "SECTORS", true] call KPLIB_fnc_common_log;
};

[
    format ["KPLIB_notification_%1", _sideText]
    , [
        "KP LIBERATION - SECTOR"
        , _sectorIcon
        , format [localize "STR_KPLIB_SETTINGS_SECTOR_SEC_CAP_FORMAT", markerText _markerName, toUpper _sideText]
    ]
    , allPlayers
] call KPLIB_fnc_notification_show;

if (_debug) then {
    ["[fn_sectors_onCapturedShowNotification] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
