#include "script_component.hpp"
/*
    KPLIB_fnc_soldiers_onPreInit

    File: fn_soldiers_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 11:40:37
    Last Update: 2021-05-17 15:05:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_soldiers_onPreInit] Initializing...", "PRE] [SOLDIERS", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

// Process CBA Settings, must be processed first
[] call MFUNC(_settings);

if (isServer) then {
// Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_soldiers_onPreInit] Initialized", "PRE] [SOLDIERS", true] call KPLIB_fnc_common_log;
};

true;
