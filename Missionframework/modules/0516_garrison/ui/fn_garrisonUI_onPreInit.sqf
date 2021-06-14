#include "script_component.hpp"
/*
    KPLIB_fnc_garrisonUI_onPreInit

    File: fn_garrisonUI_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 14:08:22
    Last Update: 2021-06-14 17:14:19
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
    ["[fn_garrisonUI_onPreInit] Initializing...", "PRE] [GARRISON", true] call KPLIB_fnc_common_log;
};

[] call MFUNCUI(_settings);

/*
    ----- Module Globals -----
*/

/*
    ----- Module Initialization -----
*/

if (isServer) then {
};

if (isServer) then {
    ["[fn_garrisonUI_onPreInit] Initialized", "PRE] [GARRISON", true] call KPLIB_fnc_common_log;
};

true;
