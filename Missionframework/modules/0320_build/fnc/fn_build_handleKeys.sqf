#include "script_components.hpp"
/*
    KPLIB_fnc_build_handleKeys

    File: fn_build_handleKeys.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-10-07
    Last Update: 2021-03-11 15:16:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handle display keypresses

    Parameter(s):
        _mode - Display keypress mode                                                                   [STRING, defaults to nil]
        _args - Gives the display or control, the keyboard code and the state of Shift, Ctrl and Alt    [ARRAY, defaults to nil]

    Returns:
        Stop handling key presses [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onKeyDown
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onKeyUp
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onMouseZChanged
        https://community.bistudio.com/wiki/DIK_KeyCodes
*/

params [
    ["_mode", nil, [""]],
    ["_args", nil, [[]]]
];

#define DIK_ESCAPE  1
#define DIK_DELETE  211

switch toLower _mode do {
    case "onkeydown": {
        _args params ["_display","_dik","_shift","_ctrl","_alt"];

        // 'true' meaning the key is 'down'
        if (!LGVAR(shiftKey)) then { LSVAR("shiftKey", _shift); };
        if (!LGVAR(ctrlKey)) then { LSVAR("ctrlKey", _ctrl); };
        if (!LGVAR(altKey)) then { LSVAR("altKey", _alt); };

        if (_dik == DIK_ESCAPE) exitWith {
            // [] call KPLIB_fnc_build_stop;
            // Open debug ESC menu (for debugging)
            [] spawn {
                disableSerialization;
                private _interruptDisplay = (findDisplay 46) createDisplay "RscDisplayInterrupt";
                waitUntil {_interruptDisplay isEqualTo displayNull};
                (findDisplay 46) createDisplay "KPLIB_build";
            };
            true
        };

        switch _dik do {
            case DIK_DELETE: {
                private _queue = LGVAR(buildQueue);
                // Remove items from build queue
                LSVAR("buildQueue", _queue - LGVAR(selection));
                // Delete objects
                {deleteVehicle _x} forEach LGVAR(selection);
                // Clear selection
                LSVAR("selection", [])
            };
        };

        false;
    };

    case "onkeyup": {
        _args params ["_display","_dik","_shift","_ctrl","_alt"];

        // 'true' meaning the key is 'up'
        if (LGVAR(shiftKey)) then { LSVAR("shiftKey", !_shift); };
        if (LGVAR(ctrlKey)) then { LSVAR("ctrlKey", !_ctrl); };
        if (LGVAR(altKey)) then { LSVAR("altKey", !_alt); };

        false;
    };

    default {
        [format ["Incorrect mode passed to handleKeys: %1", _mode], "BUILD"] call KPLIB_fnc_common_log
    };
};
