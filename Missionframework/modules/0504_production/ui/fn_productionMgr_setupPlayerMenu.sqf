#include "defines.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_productionMgr_setupPlayerMenu

    File: fn_productionMgr_setupPlayerMenu.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:36:06
    Last Update: 2021-05-24 10:30:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for module oriented player action menus.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://www.w3schools.com/colors/colors_picker.asp
 */

[
    [
        "STR_KPLIB_ACTION_MANAGE_PRODUCTION"
        , { _this call KPLIB_fnc_productionMgr_openDialog; }
        , []
        // TODO: TBD: visit the priority definitions...
        , KPLIB_ACTION_PRIORITY_MANAGE_PRODUCTION
        , false
        , true
        , ""
        , "
            _target isEqualTo _originalTarget
        "
        , -1
    ]
    , [["_color", "#ff8000"], ["_varName", "KPLIB_production_manageProductionID"]]
] call KPLIB_fnc_common_addPlayerAction;

true;
