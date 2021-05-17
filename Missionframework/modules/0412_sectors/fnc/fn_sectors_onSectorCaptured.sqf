#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onSectorCaptured

    File: fn_sectors_onSectorCaptured.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 13:26:43
    Last Update: 2021-05-05 11:12:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to SECTOR CAPTURED event.

    Parameters:
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/allPlayers
        https://community.bistudio.com/wiki/remoteExec
 */

private _debug = MPARAM(_onSectorCaptured_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

[
    _namespace getVariable [QMVAR(_markerName), ""]
    , _namespace getVariable [QMVAR(_sectorIcon), ""]
    , _namespace getVariable [QMVAR(_blufor), false]
    , _namespace getVariable [QMVAR(_opfor), false]
] params [
    Q(_markerName)
    , Q(_sectorIcon)
    , Q(_blufor)
    , Q(_opfor)
];

if (_debug) then {
    [format ["[fn_sectors_onSectorCaptured] Entering: [_markerName, _blufor, _opfor]: %1"
        , str [_markerName, _blufor, _opfor]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Bottom line we record the SECTOR MARKER in the BLUFOR vector
if (_opfor) then {
    MVAR(_blufor) pushBackUnique _markerName;
} else {
    // Assumes sector was BLUFOR
    MVAR(_blufor) = MVAR(_blufor) - [_markerName];
};

[] call {
    [] call MFUNC(_getOpforSectors);

    // Save, update markers, and notify once change is reported
    [] call KPLIB_fnc_init_save;
};

[] call {
    // Update the markers
    [Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent;
};

private _sideText = if (_blufor) then { "opfor"; } else { "blufor"; };

// Now perform the notification
[_markerName, _sectorIcon, _sideText] call {
    params [
        [Q(_markerName), "", [""]]
        , [Q(_sectorIcon), "", [""]]
        , [Q(_sideText), "", [""]]
    ];
    private _players = allPlayers select { !isNull _x; };
    [
        format ["KPLIB_notification_%1", _sideText]
        , [
            "KP LIBERATION - SECTOR"
            , _sectorIcon
            , format [localize "STR_KPLIB_SETTINGS_SECTOR_SEC_CAP_FORMAT", markerText _markerName, toUpper _sideText]
        ]
    ] remoteExec ["KPLIB_fnc_notification_show", _players];
};

if (_debug) then {
    ["[fn_sectors_onSectorCaptured] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
