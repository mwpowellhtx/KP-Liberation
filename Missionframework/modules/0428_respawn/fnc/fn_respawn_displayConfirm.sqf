#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_respawn_displayConfirm

    File: fn_respawn_displayConfirm.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-12
    Last Update: 2021-01-27 13:55:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles respawn confirmation

    Parameter(s):
        _display - Respawn display [DISPLAY, default: nil]

    Returns:
        Function reached the end [BOOL]
*/
params [
    ["_display", nil, [displayNull]]
];

["KPLIB_selRespawn", "KPLIB_selLoadout"] apply {_display getVariable _x} params [
    "_selection"
    , "_loadout"
];

// Now the action argument just "is" a position
private _pos = _selection select 1;

// Spawn the player at selected position
[_pos, _loadout] call KPLIB_fnc_respawn_spawnPlayer;

true
