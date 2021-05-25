#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_logisticsMgr_setupPlayerMenu

    File: fn_logisticsMgr_setupPlayerMenu.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 19:00:27
    Last Update: 2021-05-24 10:32:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up the PLAYER menus in the scope of the module.

    Parameter(s):
        _player - PLAYER for whom actions are arranged [OBJECT, default: player]

    Returns:
        The callback has finished [BOOL]

    References:
        https://www.w3schools.com/colors/colors_picker.asp
 */

/*
    == MANAGE LOGISTICS ==
 */

// TODO: TBD: dialog opens, but then closes, when navigation by keyboard, i.e. Enter, Space, etc...
// TODO: TBD: middle mouse button click, opens, stays open...
// TODO: TBD: question pending, is there a return, ack, etc, we need to provide otherwise (?)

// TODO: TBD: visit the string table with required bits...
// Build storage actions

[
    [
        "STR_KPLIB_ACTION_MANAGE_LOGISTICS"
        , { _this call KPLIB_fnc_logisticsMgr_openDialog; }
        , nil
        // TODO: TBD: visit the priority definitions...
        , KPLIB_ACTION_PRIORITY_MANAGE_LOGISTICS
        , false
        , true
        , ""
        , "
            _target isEqualTo _originalTarget
        "
        // // TODO: TBD: add permissions: i.e. admin | commander | logistics
        // , "
        //     _target isEqualTo _originalTarget
        //         && !(([_target] call KPLIB_fnc_common_getPlayerFob) isEqualTo "")
        // "
        , -1
    ]
    , [["_color", "#ff8000"], ["_varName", "KPLIB_logisticsMgr_manageLogisticsID"]]
] call KPLIB_fnc_common_addPlayerAction;

true;
