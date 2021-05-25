#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_permission_setupPlayerActions

    File: fn_permission_setupPlayerActions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-12-14
    Last Update: 2021-05-24 10:04:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions availible to players.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

[[
    "STR_KPLIB_ACTION_PERMISSIONS"
    , { [] call KPLIB_fnc_permission_openDialog; }
    , []
    , KPLIB_ACTION_PRIORITY_PERMISSIONS
    , false
    , true
    , ""
    , "
        _target isEqualTo _originalTarget && (
            ([] call KPLIB_fnc_permission_hasAdminPermission)
                || (KPLIB_param_permissionCommander && (str player) isEqualTo 'KPLIB_eden_commander')
                || (KPLIB_param_permissionSubCommander && (str player) isEqualTo 'KPLIB_eden_subCommander')
        )
    "
    , -1
]] call KPLIB_fnc_common_addPlayerAction;

true;
