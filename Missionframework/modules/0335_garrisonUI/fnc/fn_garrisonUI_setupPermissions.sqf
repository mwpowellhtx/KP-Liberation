#include "script_component.hpp"
/*
    KPLIB_fnc_garrisonUI_setupPermissions

    File: fn_garrisonUI_setupPermissions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 15:03:05
    Last Update: 2021-04-16 15:03:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up the player actions.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {
    ["[fn_garrisonUI_setupPermissions] Entering...", "GARRISON", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section

    // Add Garrison Dialog access permission
    MFUNCUI(_onGarrisonDialogAccess) = { /* ... */ };
    [Q(GarrisonDialogAccess), MFUNCUI(_onGarrisonDialogAccess)] call KPLIB_fnc_permission_addPermissionHandler;
};

if (isServer) then {
    ["[fn_garrisonUI_setupPermissions] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
