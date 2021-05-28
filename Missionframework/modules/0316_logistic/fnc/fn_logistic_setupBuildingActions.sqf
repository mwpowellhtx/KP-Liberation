/*
    KPLIB_fnc_logistic_setupBuildingActions

    File: fn_logistic_setupBuildingActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 18:41:25
    Last Update: 2021-05-27 18:41:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds module actions to the LOGISTIC BUILDING.

    Parameter(s):
        _object - an OBJECT that was created [OBJECT, defaults to objNull]

    Returns:
        The callback has finished [BOOL]
 */

params [
    ["_object", objNull, [objNull]]
];

// TODO: TBD: refactor better in terms of proper module preset vars...
private _logisticRange = 5;

[
    _object
    , [
        "STR_KPLIB_ACTION_LOGISTIC"
        , { _this call KPLIB_fnc_logistic_openDialog; }
        , []
        , -500
        , false
        , true
        , ""
        , ""
        , _logisticRange
    ]
    , [["_varName", "KPLIB_logistic_openDialogID"]]
] call KPLIB_fnc_common_addAction;

true;
