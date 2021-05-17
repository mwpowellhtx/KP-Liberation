/*
    KPLIB_fnc_common_onPreInit

    File: fn_common_onPreInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-04
    Last Update: 2021-03-20 15:29:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Color
        https://community.bistudio.com/wiki/sideEmpty
        https://community.bistudio.com/wiki/createGroup
        https://www.w3schools.com/colors/colors_picker.asp
*/

if (isServer) then {
    ["[fn_common_onPreInit] Initializing...", "PRE] [COMMON", true] call KPLIB_fnc_common_log;
};

[] call KPLIB_fnc_common_settings;

// Cache for getIcon function
KPLIB_common_iconCache = [] call CBA_fnc_createNamespace;

// Useful when evaluating player proximity to points of interest sectors.
KPLIB_sectorInfo_default = ["", KPLIB_sectorType_nil, ""];

KPLIB_preset_common_intelPath   = "\A3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa";
// was a bit too cyan: [0.2, 0.4, 1, 1]
KPLIB_preset_common_intelColor  = [0, 0.435, 0.922, 1];

KPLIB_preset_common_colorRgbaF  = [0, 0, 0.85, 1];
KPLIB_preset_common_colorRgbaE  = [0.85, 0, 0, 1];
KPLIB_preset_common_colorRgbaC  = [0.85, 0.85, 0, 1];

if (isServer) then {
    ["[fn_common_onPreInit] Initialized", "PRE] [COMMON", true] call KPLIB_fnc_common_log;
};

true;
