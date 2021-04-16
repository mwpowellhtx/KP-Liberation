#include "script_component.hpp"
/*
    KPLIB_fnc_units_onPreInit

    File: fn_units_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-06 11:40:37
    Last Update: 2021-04-06 11:40:40
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
    ["[fn_units_onPreInit] Initializing...", "PRE] [UNITS", true] call KPLIB_fnc_common_log;
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
    ["[fn_units_onPreInit] Initialized", "PRE] [UNITS", true] call KPLIB_fnc_common_log;
};

true;
