/*
    KPLIB_fnc_common_preInit

    File: fn_common_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-04
    Last Update: 2021-03-20 15:29:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The preInit function defines global variables, adds event handlers and set some vital settings which are used in this module.

    Parameters:
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {
    ["Module initializing...", "PRE] [COMMON", true] call KPLIB_fnc_common_log;
};

// Cache for getIcon function
KPLIB_common_iconCache = [] call CBA_fnc_createNamespace;

// Useful when evaluating player proximity to points of interest sectors.
KPLIB_sectorInfo_default = ["", KPLIB_sectorType_nil, ""];

KPLIB_common_intelPath   = "\A3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa";

if (isServer) then {
    ["Module initialized", "PRE] [COMMON", true] call KPLIB_fnc_common_log;
};

true;
