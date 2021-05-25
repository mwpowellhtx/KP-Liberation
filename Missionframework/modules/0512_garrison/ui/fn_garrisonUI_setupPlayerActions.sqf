#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_garrisonUI_setupPlayerActions

    File: fn_garrisonUI_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 15:01:44
    Last Update: 2021-05-24 10:33:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up the player actions.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]
 */

private _debug = MPARAM(_setupPlayerActions_debug);

if (_debug) then {
    ["[fn_garrisonUI_setupPlayerActions] Entering...", "GARRISON", true] call KPLIB_fnc_common_log;
};

[[
    "STR_KPLIB_ACTION_GARRISON_MANAGEMENT"
    , { [] call MFUNCUI(_openDialog); }
    , []
    , KPLIB_ACTION_PRIORITY_GARRISON_MANAGEMENT
    , false
    , true
    , ""
    , "
        _target isEqualTo vehicle _target
            && _target isEqualTo _originalTarget
            && !(KPLIB_sectors_blufor isEqualTo [])
            && ['GarrisonDialogAccess'] call KPLIB_fnc_permission_checkPermission
            && !(([_target, KPLIB_sectors_fobs, KPLIB_param_fobs_range] call KPLIB_fnc_common_getNearestMarker) isEqualTo '')
    "
    , -1
]] call KPLIB_fnc_common_addPlayerAction;

if (_debug) then {
    ["[fn_garrisonUI_setupPlayerActions] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
