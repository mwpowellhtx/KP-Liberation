#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_production_setupPlayerMenu

    File: fn_production_setupPlayerMenu.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 14:03:08
    Last Update: 2021-06-25 15:12:49
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

//// TODO: TBD: baseline was this:
// (_target == _originalTarget)
// && !(_originalTarget getVariable ["KPLIB_fob", ""] in ["", "KPLIB_eden_startbase_marker"])
// && (["Build"] call KPLIB_fnc_permission_checkPermission)

/*
    -- BUILD STORAGE --
 */

[
    [
        "STR_KPLIB_ACTION_BUILD_STORAGE"
        // TODO: TBD: build client? really just needs to be a production module function...
        , { _this call KPLIB_fnc_buildClient_onBuildStorageClicked; }
        , []
        , KPLIB_ACTION_PRIORITY_BUILD_STORAGE
        , false
        , true
        , ""
        , "
            [_target] call KPLIB_fnc_build_canBuildStorage
        "
        , -1
    ]
    , [["_color", "#33cc33"]]
] call KPLIB_fnc_common_addPlayerAction;

/*
    -- ADD [RESOURCE] CAPABILITY --
 */

// TODO: TBD: 'KPLIB_fnc_production_callback_onWithoutCapability' need further review, refactoring callbacks and such...
// TODO: TBD: especially in light of simpler comprehension around MARKER NAMES...

// TODO: TBD: ditto perms and such...
private _addCapConditionFormatString = "
    _target isEqualTo _originalTarget
        && ['Build'] call KPLIB_fnc_permission_checkPermission
        && [_target, KPLIB_param_sectors_capRange
            , KPLIB_fnc_production_callback_onWithoutCapability, [%1]] call KPLIB_fnc_production_isNearCapturedFactory
";
//                                                      1. _cap:  ^^ to be injected via 'format'

// TODO: TBD: fill in the blanks here, requires that we cross the build fob generalization Rubicon ...
// https://en.wikipedia.org/wiki/Crossing_the_Rubicon
{
    private _key = _x;
    private _actualCap = _forEachIndex;

    [
        [
            "STR_KPLIB_ACTION_ADD_CAPABILITY"
            , {
                // Prepares for a server side CBA event being raised and get out of the way ASAP
                params [
                    ["_target", objNull, [objNull]]
                    , ["_caller", objNull, [objNull]]
                    , ["_aid", -1, [0]] // Action id
                    , ["_args", []]
                ];

                // The goal here is to delegate and then get out of the way as quickly as possible
                _args params [
                    ["_targetCap", 0, [0]]
                ];

                // TODO: TBD: will see if this works... it may be too naive of an event handler aligning with the action menu request...
                // TODO: TBD: to know definitively we could assume the storage objects are there with an attribute name aligned to the sector...
                // TODO: TBD: but we would also want to revise the action condition itself to be certain...
                // TODO: TBD: so conditions would need to be: nearest factory sector to player within sector cap range NOT having aligned storage...
                private _targetMarker = [KPLIB_param_sectors_capRange, getPos _target, KPLIB_sectors_factory] call KPLIB_fnc_core_getNearestMarker;

                // Raise the event server side adding factory sector production capability
                [KPLIB_productionCO_requestAddCapability, [_targetMarker, _targetCap, clientOwner]] call CBA_fnc_serverEvent;
            }
            , [_actualCap]
            , KPLIB_ACTION_PRIORITY_BUILD_CAPABILITY
            , false
            , true
            , ""
            , format [_addCapConditionFormatString, str _actualCap]
            , -1
        ]
        , [["_color", "#ffff00"], ["_formatArgs", [toUpper (localize _key)]]]
    ] call KPLIB_fnc_common_addPlayerAction;

} forEach [
    "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY"
    , "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO"
    , "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL"
];

true;
