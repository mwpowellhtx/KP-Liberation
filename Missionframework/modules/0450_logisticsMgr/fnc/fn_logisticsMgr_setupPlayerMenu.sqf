#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_logisticsMgr_setupPlayerMenu

    File: fn_logisticsMgr_setupPlayerMenu.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 19:00:27
    Last Update: 2021-02-26 19:00:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up the player menus in the scope of the module.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]

    References:
        https://www.w3schools.com/colors/colors_picker.asp
*/

// Actions available LOCALLY to player
if (hasInterface) then {

    /*
        == MANAGE LOGISTICS ==
     */

    // TODO: TBD: add permissions: i.e. admin | commander | logistics

    // Using the production manager as a blueprint...
    private _manageLogisticsCondition = '
        _target == _originalTarget
            && !(([_target] call KPLIB_fnc_common_getPlayerFob) isEqualTo "")
    ';

    // TODO: TBD: dialog opens, but then closes, when navigation by keyboard, i.e. Enter, Space, etc...
    // TODO: TBD: middle mouse button click, opens, stays open...
    // TODO: TBD: question pending, is there a return, ack, etc, we need to provide otherwise (?)
    private _onOpenDialog = {
        _this call KPLIB_fnc_logisticsMgr_openDialog;
    };

    // TODO: TBD: visit the string table with required bits...
    // Build storage actions
    private _manageLogisticsActionArgs = [
        // TODO: TBD: verify colors, etc...
        format ["<t color='#ff8000'>%1</t>", localize "STR_KPLIB_ACTION_MANAGE_LOGISTICS"]
        , _onOpenDialog
        , nil
        // TODO: TBD: visit the priority definitions...
        , KPLIB_ACTION_PRIORITY_MANAGE_LOGISTICS
        , false
        , true
        , ""
        , _manageLogisticsCondition
        , -1
    ];

    [_manageLogisticsActionArgs] call CBA_fnc_addPlayerAction;
};
