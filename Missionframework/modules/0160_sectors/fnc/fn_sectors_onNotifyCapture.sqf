#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onNotifyCapture

    File: fn_sectors_onNotifyCapture.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-07 21:29:40
    Last Update: 2021-04-07 21:29:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sector capture notification event handler.

    Parameter(s):
        _markerName - the sector marker being captured [STRING, default: ""]
        _toPlayerSide - whether the capture occurred by BLUFOR [BOOL, default: true]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onNotifyCapture_debug);

params [
    [Q(_markerName), "", [""]]
    , [Q(_toPlayerSide), true, [true]]
];

if (isServer) then {
    [format ["[fn_sectors_onNotifyCapture] Entering: [_markerName, _toPlayerSide]: %1"
        , str [_markerName, _toPlayerSide]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Save, update markers, and notify once change is reported
[] call KPLIB_fnc_init_save;

["KPLIB_updateMarkers"] call CBA_fnc_serverEvent;

private _sideText = if (_toPlayerSide) then { "blufor"; } else { "opfor"; };

// TODO: TBD: shift to using the proper notifications, and for the appropriate sector type...
// TODO: TBD: could normalize names, factory suffixes, radio tower prefixes, introduce gridrefs, etc...
[
    format [localize "STR_KPLIB_SETTINGS_SECTOR_SEC_CAP_FORMAT"
        , markerText _markerName, toUpper _sideText]
] remoteExec ["KPLIB_fnc_notification_hint", 0];

if (isServer) then {
    ["[fn_sectors_onNotifyCapture] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
