#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_respawn_displayUnload

    File: fn_respawn_displayUnload.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-23
    Last Update: 2021-03-30 17:21:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handle respawn dialog unload

    Parameter(s):
        _display - Respawn display [DISPLAY, defaults to nil]

    Returns:
        Function reached the end [BOOL]
*/
params [
    ["_display", nil, [displayNull]]
];

if (alive player) then {
    // Fade out effect
    cutText ["", "BLACK IN", 2];
    // Close camera view
    KPLIB_respawn_camera cameraEffect ["TERMINATE", "BACK"];
};

// See notes for 'onLoad' event handler
player setVariable ["KPLIB_display_open", nil];

true
