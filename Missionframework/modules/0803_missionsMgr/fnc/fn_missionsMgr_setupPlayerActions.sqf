#include "..\..\KPLIB_actionMenu.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_setupPlayerActions

    File: fn_missionsMgr_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization of actions available to players.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

if (hasInterface) then {
    [] call {
        // Actions available LOCALLY to player

        // TODO: TBD: may also reconsider, does "admin always have perm" (?)
        // TODO: TBD: i.e. no need to expose that from the caller perspective, rather an inherent part of any perm check (?)
        // TODO: TBD: i.e. perhaps masked in certain circumstances...

        // Permission action
        private _condition = '
            _target isEqualTo _originalTarget && (
                ([] call KPLIB_fnc_permission_hasAdminPermission)
                    || {[KPLIB_missionsMgr_permissionName] call KPLIB_fnc_permission_checkPermission}
            )
        ';

        private _actionArgs = [
            localize "STR_KPLIB_ACTION_MISSIONS"
            , {[] call KPLIB_fnc_missionsMgr_openDialog}
            , nil
            , KPLIB_ACTION_PRIORITY_MISSIONS
            , false
            , true
            , ""
            , _condition
            , -1
        ];

        [_actionArgs] call CBA_fnc_addPlayerAction;
    };
};

true;
