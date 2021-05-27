#include "script_component.hpp"
/*
    KPLIB_fnc_hud_presets

    File: fn_hud_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 11:40:56
    Last Update: 2021-05-27 11:40:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module preset variables.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (hasInterface) then {
    ["[fn_hud_presets] Entering...", "HUD", true] call KPLIB_fnc_common_log;
};

if (isServer) then {

    MPRESET_SP(_cutRscEffect,Q(plain));
    MPRESET_SP(_cutRscSpeed,0);
    MPRESET_SP(_cutRscShowInMap,false);

    // TODO: TBD: these could well be defined in a COMMON or CORE module...
    // TODO: TBD: if they are not already in some way shape or form...
    [
        [0.9, 0, 0, 1]
        , [1, 0.6, 0.2, 1]
        , [0.9, 0.9, 0, 1]
        , [0.2, 0.6, 1, 1]
        , [0.2, 0.8, 0.2, 1]
        , [1, 1, 1, 1]
    ] params [
        Q(_redColor)
        , Q(_orangeColor)
        , Q(_yellowColor)
        , Q(_blueColor)
        , Q(_greenColor)
        , Q(_whiteColor)
    ];
    MPRESET_SP(_redColor,_redColor);
    MPRESET_SP(_orangeColor,_orangeColor);
    MPRESET_SP(_yellowColor,_yellowColor);
    MPRESET_SP(_blueColor,_blueColor);
    MPRESET_SP(_greenColor,_greenColor);
    MPRESET_SP(_whiteColor,_whiteColor);
};

if (hasInterface) then {
    ["[fn_hud_presets] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
