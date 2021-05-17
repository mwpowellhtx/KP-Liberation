#include "script_component.hpp"
/*
    KPLIB_fnc_mission_onNotify

    File: fn_mission_onNotify.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-23 17:42:09
    Last Update: 2021-03-23 17:42:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Targets a MISSION specific set of players, when available. Otherwise,
        notifies ALL players, but not the server.

    Parameter(s):
        _mission - a CBA MISSION namespace [LOCATION, default: locationNull]
        _msg - a message to display [STRING, default: ""]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
    , [Q(_msg), "", [""]]
];

private _players = _mission getVariable [QMVAR1(_players), []];

// Read around ALL PLAYERS one other time
private _playersToNotify = _players select { _x in allPlayers; };

// Just notify each of the players
[_msg] remoteExec ["KPLIB_fnc_notification_hint", _playersToNotify];

true;
