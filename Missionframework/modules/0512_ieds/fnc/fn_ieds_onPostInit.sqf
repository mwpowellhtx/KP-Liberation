#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onPostInit

    File: fn_ieds_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 18:01:59
    Last Update: 2021-06-14 17:09:19
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
    ["[fn_ieds_onPostInit] Initializing...", "POST] [IEDS", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

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
    ["[fn_ieds_onPostInit] Initialized", "POST] [IEDS", true] call KPLIB_fnc_common_log;
};

true;
