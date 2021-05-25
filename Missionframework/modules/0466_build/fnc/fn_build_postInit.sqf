/*
    KPLIB_fnc_build_postInit

    File: fn_build_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-08-31
    Last Update: 2021-05-20 12:18:54
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
    ["Module initializing...", "POST] [BUILD", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Build menu permissions
    // Build
    [
        "Build",
        {},
        false,
        "GroupBuildMenu"
    ] call KPLIB_fnc_permission_addPermissionHandler;
};

if (hasInterface) then {

    [KPLIB_preset_fobBoxE, localize "STR_KPLIB_BUILD_ITEM_FOB_BOX"] call KPLIB_fnc_build_registerClassDisplayName;
    [KPLIB_preset_fobBoxF, localize "STR_KPLIB_BUILD_ITEM_FOB_BOX"] call KPLIB_fnc_build_registerClassDisplayName;

    [KPLIB_preset_fobTruckE, localize "STR_KPLIB_BUILD_ITEM_FOB_TRUCK"] call KPLIB_fnc_build_registerClassDisplayName;
    [KPLIB_preset_fobTruckF, localize "STR_KPLIB_BUILD_ITEM_FOB_TRUCK"] call KPLIB_fnc_build_registerClassDisplayName;
};

if (isServer) then {
    ["Module initialized", "POST] [BUILD", true] call KPLIB_fnc_common_log;
};

true;
