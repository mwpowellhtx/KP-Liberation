#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_productionMgr_setupPlayerMenu

    File: fn_productionMgr_setupPlayerMenu.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:36:06
    Last Update: 2021-02-06 12:36:08
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
        == MANAGE PRODUCTION ==
     */

    // TODO: TBD: add permissions: i.e. admin | commander | logistics
    // TODO: TBD: also add "within fob" condition...
    // TODO: TBD: work out proximity conditions: i.e. to Eden, to FOB, to Factory sector(s) ...
    //// condition was:
    //    _target == _originalTarget
    //    && [_target, KPLIB_param_sectorCapRange
    //        , KPLIB_fnc_production_callback_onWithoutStorageContainers] call KPLIB_fnc_production_isNearCapturedFactory

    private _manageProductionCondition = '
        _target == _originalTarget
    ';

    // TODO: TBD: visit the string table with required bits...
    // Build storage actions
    private _manageProductionActionArgs = [
        // TODO: TBD: verify colors, etc...
        format ["<t color='#ff8000'>%1</t>", localize "STR_KPLIB_ACTION_MANAGE_PRODUCTION"]
        , KPLIB_fnc_productionMgr_openDialog
        , nil
        // TODO: TBD: visit the priority definitions...
        , KPLIB_ACTION_PRIORITY_MANAGE_PRODUCTION
        , false
        , true
        , ""
        , _manageProductionCondition
        , -1
    ];

    [_manageProductionActionArgs] call CBA_fnc_addPlayerAction;
};
