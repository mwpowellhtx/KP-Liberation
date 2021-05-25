#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_onVerifyStartingBoxOrTruck

    File: fn_fobs_onVerifyStartingBoxOrTruck.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-09
    Last Update: 2021-05-23 22:08:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates the initlal START BASE FOB BOX|TRUCK, depending on how it was presented.

    Parameter(s):
        _boxOrTruck - the previous FOB BOX|TRUCK, will be deleted [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

// Although we are given the last BOX|TRUCK object, we can just check in all the VEHICLES
params [
    [Q(_boxOrTruck), objNull, [objNull]]
];

private _debug = MPARAM(_onVerifyStartingBoxOrTruck_debug)
    || (_boxOrTruck getVariable [QMVAR(_onVerifyStartingBoxOrTruck_debug), false])
    ;

if (_debug) then {
    [format ["[fn_fobs_onVerifyStartingBoxOrTruck] Entering: [isNull _boxOrTruck]: %1"
        , str [isNull _boxOrTruck]], "FOBS", true] call KPLIB_fnc_common_log;
};

private _verifyBoxOrTruck = { 
    !isNull _this
    && alive _this
    && typeOf _this in [KPLIB_preset_fobBoxF, KPLIB_preset_fobTruckF];
};

[
    { _x call _verifyBoxOrTruck; } count vehicles
    , count MVAR(_allBuildings)
] params [
    Q(_verifiedVehicleCount)
    , Q(_fobBuildingCount)
];

// There is at least one FOB BOX|TRUCK|BUILDING, so we can bypass this event
if ((_verifiedVehicleCount + _fobBuildingCount) > 0) exitWith {
    if (_debug) then {
        [format ["[fn_fobs_onVerifyStartingBoxOrTruck] Fini: [_verifiedVehicleCount, _fobBuildingCount]: %1"
            , str [_verifiedVehicleCount, _fobBuildingCount]], "FOBS", true] call KPLIB_fnc_common_log;
    };
    false;
};

// There are none that are "alive", so clear to delete the BOX|TRUCK
deleteVehicle _boxOrTruck;

_boxOrTruck = [
    KPLIB_eden_boxspawn getVariable [Q(KPLIB_eden_fobBoxOrTruckClassName), KPLIB_preset_fobBoxF]
    , (getPosATL KPLIB_eden_boxspawn) vectorAdd MPRESET(_boxOrTruckVectorOffset)
    , getDir KPLIB_eden_boxspawn
    , true
] call KPLIB_fnc_common_createVehicle;

if (_debug) then {
    [format ["[fn_fobs_onVerifyStartingBoxOrTruck] Fini: [isNull _boxOrTruck, alive _boxOrTruck]: %1"
        , str [isNull _boxOrTruck, alive _boxOrTruck]], "FOBS", true] call KPLIB_fnc_common_log;
};

!isNull _boxOrTruck
    && alive _boxOrTruck
    ;
