#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_missionsMgr_setupPlayerActions

    File: fn_missionsMgr_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-05-24 10:35:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions available to players.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

// Actions available LOCALLY to player

// TODO: TBD: may also reconsider, does "admin always have perm" (?)
// TODO: TBD: i.e. no need to expose that from the caller perspective, rather an inherent part of any perm check (?)
// TODO: TBD: i.e. perhaps masked in certain circumstances...

[[
    "STR_KPLIB_ACTION_MISSIONS"
    , { [] call MFUNC(_openDialog); }
    , []
    , KPLIB_ACTION_PRIORITY_MISSIONS
    , false
    , true
    , ""
    , "
        _target isEqualTo _originalTarget && (
            ([] call KPLIB_fnc_permission_hasAdminPermission)
                || ([KPLIB_missionsMgr_permissionName] call KPLIB_fnc_permission_checkPermission)
        )
    "
    , -1
]] call KPLIB_fnc_common_addPlayerAction;

true;
