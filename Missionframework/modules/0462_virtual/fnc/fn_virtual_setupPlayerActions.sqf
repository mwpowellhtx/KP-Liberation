#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_virtual_setupPlayerActions

    File: fn_virtual_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-06 15:40:36
    Last Update: 2021-06-14 17:07:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (hasInterface) then {

    // TODO: TBD: so... this isn't right, I know that...
    // TODO: TBD: not sure why the Y key is not working now...
    // TODO: TBD: should also restrict perhaps to also commander/sub-commander 'slots'

    // Action to open the dialog
    [
        [
            "STR_KPLIB_ACTION_ZEUS_ASSIGN"
            , {
                [_this select 0] remoteExec ["KPLIB_fnc_virtual_addCurator", 2];
            }
            , []
            , KPLIB_ACTION_PRIORITY_ADMIN
            , false
            , true
            , ""
            // TODO: TBD: also "isNull getAssignedCuratorLogic _target" (?)
            , "
                [] call KPLIB_fnc_permission_hasAdminPermission
            "
            , -1
        ]
        , [["_color", "#ff0000"], ["_varName", "KPLIB_virtual_assignZeusID"]]
    ] call KPLIB_fnc_common_addPlayerAction;
};

true;
