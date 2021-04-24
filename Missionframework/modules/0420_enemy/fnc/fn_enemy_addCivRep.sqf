#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_addCivRep

    File: fn_enemy_addCivRep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 16:19:31
    Last Update: 2021-04-23 16:19:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds CIVILIAN REPUTATION along with an optional message.

    Parameter(s):
        _delta - a positive or negative change [SCALAR, default: 0]
        _message - an optional message to report [STRING, default: ""]
        _markerName - an optional MARKER NAME for use to furnish an icon [STRING, default: ""]

    Returns:
        The function has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/remoteExec
 */

private _debug = MPARAM(_addCivRep_debug);

params [
    [Q(_delta), 0, [0]]
    , [Q(_message), "", [""]]
    , [Q(_markerName), "", [""]]
];

MVAR(_civRep) = MVAR(_civRep) + _delta;

if (count _message > 0) then {
    private _sectorIcon = [_markerName] call KPLIB_fnc_sectors_getSectorIcon;
    private _args = ["KP LIBERATION - ENEMY", _sectorIcon, _message];
    [Q(KPLIB_notification_civilian), _args, allPlayers] spawn KPLIB_fnc_notification_show;
};

[] spawn KPLIB_fnc_init_save;

MVAR(_civRep);
