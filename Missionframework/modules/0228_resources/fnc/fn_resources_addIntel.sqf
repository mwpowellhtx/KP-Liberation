#include "script_component.hpp"
/*
    KPLIB_fnc_resources_addIntel

    File: fn_resources_addIntel.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-16
    Last Update: 2021-04-26 14:18:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds the delta to the intel value and returns the new value. Delta may be positive
        or negative.

    Parameter(s):
        _delta - quantity of intel to add [SCALAR, default: 0]
        _message - an optional notification message [STRING, default: ""]
        _markerName - a SECTOR marker about which notification shall occur [STRING, default: ""]

    Returns:
        The new intel value [BOOL]
 */

params [
    [Q(_delta), 0, [0]]
    , [Q(_message), "", [""]]
    , [Q(_markerName), "", [""]]
];

if (_delta != 0) then {
    // Sets the new intel resource value bounded by ZERO and the MAX
    MVAR(_intel) = 0 max ((MVAR(_intel) + _delta) min MPARAM(_maxIntel));

    if (count _message > 0) then {
        private _sectorIcon = [_markerName] call KPLIB_fnc_eden_getSectorIcon;
        private _args = ["KP LIBERATION - RESOURCES", _sectorIcon, _message];
        private _notification = if (_markerName in KPLIB_sectors_blufor) then { "blufor"; } else { "opfor"; };
        private _template = format ["KPLIB_notification_%1", _notification];
        [_template, _args, allPlayers] spawn KPLIB_fnc_notification_show;
    };

    ["fn_resources_addIntel"] spawn KPLIB_fnc_init_save;
};

true;
