#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_resources_setupCrateActions

    File: fn_resources_setupCrateActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 16:51:45
    Last Update: 2021-05-27 17:01:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges actions on the CRATE object upon creation.

    Parameter(s):
        _object - a CRATE object for which to arrange actions [OBJECT, default: objNull]

    Returns:
        The callback has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

// TODO: TBD: may refactor in terms of proper module preset vars...
private _crateColor = "#ffff00";
private _crateRange = 5;

[
    _object
    , [
        "STR_KPLIB_ACTION_CHECKCRATE"
        , { [(_this#0)] call KPLIB_fnc_resources_checkCrate; }
        , []
        , -500
        , false
        , true
        , ""
        , "isNull attachedTo _target"
        , _crateRange
    ]
    , [[Q(_varName), Q(KPLIB_resources_checkCrateID)], [Q(_color), _crateColor]]
] call KPLIB_fnc_common_addAction;

[
    _object
    , [
        "STR_KPLIB_ACTION_PUSHCRATE"
        , { [(_this#0)] call KPLIB_fnc_resources_pushCrate; }
        , []
        , -501
        , false
        , false
        , ""
        , "isNull attachedTo _target"
        , _crateRange
    ]
    , [[Q(_varName), Q(KPLIB_resources_checkCrateID)], [Q(_color), _crateColor]]
] call KPLIB_fnc_common_addAction;

[
    _object
    , [
        "STR_KPLIB_ACTION_STORECRATE"
        , { [(_this#0)] call KPLIB_fnc_resources_storeCrate; }
        , []
        , -502
        , false
        , true
        , ""
        , "isNull attachedTo _target"
        , _crateRange
    ]
    , [[Q(_varName), Q(KPLIB_resources_checkCrateID)], [Q(_color), _crateColor]]
] call KPLIB_fnc_common_addAction;

// TODO: TBD: should also have conditions indicating nearby storage containers or transport vehicles...
// TODO: TBD: but in general, we should also be able to simplify what is a 'storage container' to include vehicles...
// TODO: TBD: an object is an object, with storage positions, and an unload vector...
[
    _object
    , [
        "STR_KPLIB_ACTION_LOADCRATE"
        , { [(_this#0)] call KPLIB_fnc_resources_loadCrate; }
        , []
        , -502
        , false
        , true
        , ""
        , "isNull attachedTo _target"
        , _crateRange
    ]
    , [[Q(_varName), Q(KPLIB_resources_checkCrateID)], [Q(_color), _crateColor]]
] call KPLIB_fnc_common_addAction;

true;
