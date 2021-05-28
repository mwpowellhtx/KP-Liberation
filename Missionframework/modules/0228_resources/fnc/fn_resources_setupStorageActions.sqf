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
private _storageColor = "#ffff00";
private _storageRange = 10;

// TODO: TBD: should have better conditions indicating whether object actually has resource kinds attached...
{
    [
        _object
        , [
            "STR_KPLIB_ACTION_UNLOAD_ONE_RESOURCE"
            , { [(_this#0), (_this#3)] call KPLIB_fnc_resources_unstoreCrate; }
            , _x
            , (-500 - _forEachIndex)
            , false
            , true
            , ""
            , ""
            , _storageRange
        ]
        , [
            [Q(_varName), format ["KPLIB_resources_unload%1CrateID", _x]]
            , [Q(_color), _storageColor]
            , [Q(_formatArgs), [toUpper _x]]
        ]
    ] call KPLIB_fnc_common_addAction;

} forEach MPRESET(_resourceKinds);

[
    _object
    , [
        "STR_KPLIB_ACTION_STACKNSORT"
        , { [(_this#0)] call KPLIB_fnc_resources_stackNsort; }
        , []
        , (-500 - (count MPRESET(_resourceKinds)))
        , false
        , false
        , ""
        , ""
        , _storageRange
    ]
    , [
        [Q(_varName), format ["KPLIB_resources_stackNSortID", _x]]
        , [Q(_color), _storageColor]
    ]
] call KPLIB_fnc_common_addAction;

true;
