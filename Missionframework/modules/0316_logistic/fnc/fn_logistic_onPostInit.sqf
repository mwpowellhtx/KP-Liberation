#include "script_component.hpp"
/*
    KPLIB_fnc_logistic_onPostInit

    File: fn_logistic_onPostInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-01-16
    Last Update: 2021-05-17 13:16:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_logistic_onPostInit] Initializing...", "POST] [LOGISTIC", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    //// Logistic station permissions
    //// TODO: TBD: a lot of boilerplate here that could potentially be factored better
    //[
    //    "Logistician"
    //    , {}
    //    , false
    //    , "GroupLogistics"
    //] call KPLIB_fnc_permission_addPermissionHandler;

    // Recycle
    [
        "Recycle",
        {},
        false,
        "GroupLogistics"
    ] call KPLIB_fnc_permission_addPermissionHandler;

    // Resupply
    [
        "Resupply",
        {},
        false,
        "GroupLogistics"
    ] call KPLIB_fnc_permission_addPermissionHandler;

    [
        "Recycle",
        {
            if (["Recycle"] call KPLIB_fnc_permission_checkPermission) then {
                closeDialog 0;
                [] call KPLIB_fnc_logistic_openRecycleDialog;
            } else {
                [
                    ["a3\3den\data\controlsgroups\tutorial\close_ca.paa", 1, [1,0,0]],
                    [localize "STR_KPLIB_HINT_NOPERMISSION"]
                ] call CBA_fnc_notify;
            };
        },
        "STR_KPLIB_LOGISTIC_RECYCLE"
    ] call KPLIB_fnc_logistic_addMenu;

    [
        "Resupply",
        {
            if (["Resupply"] call KPLIB_fnc_permission_checkPermission) then {
                closeDialog 0;
                [] call KPLIB_fnc_logistic_openResupplyDialog;
            } else {
                [
                    ["a3\3den\data\controlsgroups\tutorial\close_ca.paa", 1, [1,0,0]],
                    [localize "STR_KPLIB_HINT_NOPERMISSION"]
                ] call CBA_fnc_notify;
            };
        },
        "STR_KPLIB_LOGISTIC_RESUPPLY"
    ] call KPLIB_fnc_logistic_addMenu;

    private _vehicles = [];
    {
        _vehicles append (missionNamespace getVariable [format ["KPLIB_preset_%1F", _x], ""]);
        _vehicles append (missionNamespace getVariable [format ["KPLIB_preset_%1E", _x], ""]);
    } forEach [
        "vehLightUnarmed",
        "vehLightArmed",
        "vehTrans",
        "boats",
        "vehHeavyApc",
        "vehHeavy",
        "vehAntiAir",
        "vehArty",
        "heliTrans",
        "heliAttack",
        "planeTrans",
        "jets",
        "logistic"
    ];
    LSVAR("Vehicles", _vehicles);
};

if (isServer) then {
    ["[fn_logistic_onPostInit] Initialized", "POST] [LOGISTIC", true] call KPLIB_fnc_common_log;
};

true;
