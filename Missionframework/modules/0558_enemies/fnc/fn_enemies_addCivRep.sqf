#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_addCivRep

    File: fn_enemies_addCivRep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 16:19:31
    Last Update: 2021-05-25 22:29:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds CIVILIAN REPUTATION along with an optional message. Returns the new value.
        This is also a save-worthy moment.

    Parameter(s):
        _delta - a positive or negative change [SCALAR, default: 0]
        _message - an optional message to report [STRING, default: ""]
        _markerName - an optional MARKER NAME for use to furnish an icon [STRING, default: ""]

    Returns:
        The new CIVILIAN REPUTATION value [SCALAR]

    References:
        https://community.bistudio.com/wiki/remoteExec
 */

private _debug = MPARAM(_addCivRep_debug);

params [
    [Q(_delta), 0, [0]]
    , [Q(_message), "", [""]]
    , [Q(_markerName), "", [""]]
];

if (_delta != 0) then {
    // Sets the CIVILIAN REPUTATION bounded by the MIN and the MAX
    MVAR(_civRep) = -MPARAM(_maxCivRep) max ((MVAR(_civRep) + _delta) min MPARAM(_maxCivRep));
    publicVariable MVAR(_civRep);

    if (count _message > 0) then {
        private _sectorIcon = [_markerName] call KPLIB_fnc_eden_getSectorIcon;
        private _args = ["KP LIBERATION - ENEMY", _sectorIcon, _message];
        [Q(KPLIB_notification_civilian), _args, allPlayers] spawn KPLIB_fnc_notification_show;
    };

    [Q(fn_enemies_addCivRep)] spawn KPLIB_fnc_init_save;
};

MVAR(_civRep);
