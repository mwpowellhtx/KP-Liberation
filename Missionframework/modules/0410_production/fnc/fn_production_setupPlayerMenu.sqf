#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_production_setupPlayerMenu

    File: fn_production_setupPlayerMenu.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 14:03:08
    Last Update: 2021-02-05 00:55:39
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

// Actions avalible LOCALLY to player
if (hasInterface) then {

    //// TODO: TBD: baseline was this:
    // (_target == _originalTarget)
    // && !(_originalTarget getVariable ["KPLIB_fob", ""] in ["", "KPLIB_eden_startbase_marker"])
    // && (["Build"] call KPLIB_fnc_permission_checkPermission)

    /*
        -- BUILD STORAGE --
     */

    // TODO: TBD: 'Build' perms, also 'Logistician' perms ...
    // TODO: TBD: add permissions... i.e. build || logistics
    private _buildStorageCondition = '
        _target == _originalTarget
        && ["Build"] call KPLIB_fnc_permission_checkPermission
        && [_target, KPLIB_param_sectorCapRange
            , KPLIB_fnc_production_callback_onWithoutStorageContainers] call KPLIB_fnc_production_isNearCapturedFactory
    ';

    private _onBuildStorage = {
        //// TODO: TBD: start building storage...
        //// TODO: TBD: closing the gap here, like building FOB, but for storage...
        //private _markerName = [] call KPLIB_fnc_common_getPlayerFob;
        //private _markerPos = getMarkerPos _markerName;
        //[_markerPos, KPLIB_param_fobRange] call KPLIB_fnc_build_start;
    };

    // Build storage actions
    private _buildStorageActionArgs = [
        format ["<t color='#33cc33'>%1</t>", localize "STR_KPLIB_ACTION_BUILD_STORAGE"]
        , _onBuildStorage
        , nil
        , KPLIB_ACTION_PRIORITY_BUILD_STORAGE
        , false
        , true
        , ""
        , _buildStorageCondition
        , -1
    ];

    [_buildStorageActionArgs] call CBA_fnc_addPlayerAction;


    /*
        -- ADD [RESOURCE] CAPABILITY --
     */

    //// TODO: TBD: add bits here...
    //private _addSupplyCapCondition = '
    //';

    //private _addAmmoCapCondition = '
    //';

    //private _addFuelCapCondition = '
    //';

    // TODO: TBD: ditto perms and such...
    private _addCapConditionFormatString = '
        _target == _originalTarget
        && ["Build"] call KPLIB_fnc_permission_checkPermission
        && [_target, KPLIB_param_sectorCapRange
            , KPLIB_fnc_production_callback_onWithoutCapability, [%1]] call KPLIB_fnc_production_isNearCapturedFactory
    ';
    //                                                  1. _cap:  ^^ to be injected via 'format'

    // TODO: TBD: fill in the blanks here, requires that we cross the build fob generalization Rubicon ...
    // https://en.wikipedia.org/wiki/Crossing_the_Rubicon
    private _onAddCap = {

        params [
            ["_target", objNull, [objNull]]
            , ["_caller", objNull, [objNull]]
            , ["_actionId", -1, [0]]
            , ["_args", []]
        ];

        _args params [
            ["_cap", 0, [0]]
        ];
        // ...

        //// TODO: TBD: start building storage...
        //// TODO: TBD: closing the gap here, like building FOB, but for storage...
        //private _markerName = [] call KPLIB_fnc_common_getPlayerFob;
        //private _markerPos = getMarkerPos _markerName;
        //[_markerPos, KPLIB_param_fobRange] call KPLIB_fnc_build_start;
    };

    // TODO: TBD: see about a loop...

    private _capSpecs = [
        "STR_KPLIB_ACTION_ADD_CAPABILITY_SUPPLY"
        , "STR_KPLIB_ACTION_ADD_CAPABILITY_AMMO"
        , "STR_KPLIB_ACTION_ADD_CAPABILITY_FUEL"
    ];

    {
        private _key = _x;
        private _actualCap = _forEachIndex;

        // TODO: TBD: let's aim for a string replace here... rinse and repeat for the resource/cap index...
        private _actualCapCondition = format [_addCapConditionFormatString, str _actualCap];

        // Build capability actions
        private _addCapActionArgs = [
            format ["<t color='#ffff00'>%1</t>", localize _key]
            , _onAddCap
            , [_actualCap]
            , KPLIB_ACTION_PRIORITY_BUILD_CAPABILITY
            , false
            , true
            , ""
            , _actualCapCondition
            , -1
        ];

        [_addCapActionArgs] call CBA_fnc_addPlayerAction;

    } forEach _capSpecs;
};
