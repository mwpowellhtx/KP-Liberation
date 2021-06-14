#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_admin_postInit

    File: fn_admin_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2017-08-31
    Last Update: 2021-06-14 16:47:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
 */

["Module initializing...", "POST] [ADMIN", true] call KPLIB_fnc_common_log;

// Player section
if (hasInterface) then {

    // TODO: TBD: these are a really shorthand, short term helper
    KPLIB_fnc_admin_respawnOnFobBox = {
        _obj = vehicles select {typeOf _x isEqualTo KPLIB_preset_fobBoxF} select 0;
        _pos = getPos _obj;
        player setPos [(_pos#0), (_pos#1) + 10, 0.1];
    };

    // // TODO: TBD: may enable this one again...
    // KPLIB_fnc_admin_deleteFobBuildings = {
    //     {
    //         deleteVehicle _x;
    //     } forEach (nearestObjects [player, [], 100] select {
    //         _x isKindOf "Building";
    //     });
    // };

    // KPLIB_fnc_admin_resetFobs = {
    //     {
    //         deleteVehicle _x;
    //     } forEach KPLIB_persistence_objects;
    //     KPLIB_persistence_objects = [];
    //     {
    //         deleteMarker (_x#0);
    //     } forEach KPLIB_sectors_fobs;
    //     KPLIB_sectors_fobs = [];
    //     private _h = ["fn_admin_postInit] spawn KPLIB_fnc_init_save;
    // };

    KPLIB_fnc_admin_onMoveFobBoxToMap = {
        params ["_pos", "_alt", "_shift"];
        systemChat format ["[fn_admin_postInit] Map clicked: [_pos]: %1", str [_pos]];
        private _obj = vehicles select {typeOf _x isEqualTo KPLIB_preset_fobBoxF} select 0;
        _obj setPos [(_pos#0), (_pos#1), 0.1];
        [] spawn {
            openMap false;
        };
        true;
    };

    // TODO: TBD: factor as proper function...
    // TODO: TBD: teleports the PLAYER or the player's VEHICLE
    KPLIB_fnc_admin_onTeleportPlayer = {
        params ["_pos", "_alt", "_shift"];
        systemChat format ["[fn_admin_postInit] Map clicked: [_pos]: %1", str [_pos]];
        vehicle player setPos [(_pos#0), (_pos#1), 0.1];
        [] spawn {
            openMap false;
        };
        true;
    };

    // // TODO: TBD: if we do introduce these more formally...
    // // TODO: TBD: then rework them to leverage the best possible API factoring...
    // KPLIB_fnc_admin_setFactoryStorageMarker = {
    //     params [
    //         ["_target", player, [objNull]]
    //         , ["_range", KPLIB_param_sectors_capRange, [0]]
    //     ];
    //     private _sectors = KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor; };
    //     private _targetMarker = [_target, _range, _sectors] call **refactorme**KPLIB_fnc_common_getTargetMarkerIfInRange;**
    //     // TODO: TBD: once we get the build marker name issue sorted out we will need to consider that case here...
    //     if (!(_targetMarker isEqualTo "")) then {
    //         private _objects = nearestObjects [markerPos _targetMarker, [KPLIB_preset_storageSmallF], _range];
    //         {
    //             _x setVariable ["KPLIB_sectors_markerName", _targetMarker, true];
    //         } forEach _objects;
    //     };
    // };

    // KPLIB_fnc_admin_summarizeStorageContainers = {
    //     params [
    //         ["_target", player, [objNull]]
    //         , ["_range", 50000, [0]]
    //     ];
    //     private _storageContainers = nearestObjects [_target, KPLIB_resources_storageClassesF, _range];
    //     private _sum = _storageContainers apply {[
    //         typeOf _x
    //         , _x getVariable ["KPLIB_asset_isMovable", false]
    //         , _x getVariable ["KPLIB_sectors_markerName", ""]
    //         , _x getVariable ["KPLIB_fobs_fobUuid", ""]
    //         , [_x, KPLIB_param_sectors_capRange, KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor; }] call **refactorme**KPLIB_fnc_common_getTargetMarkerIfInRange**
    //     ]};
    //     [count _sum, _sum];
    // };

    // KPLIB_fnc_admin_deleteStorageContainers = {
    //     params [
    //         ["_target", player, [objNull]]
    //         , ["_range", KPLIB_param_fobs_range, [0]]
    //         , ["_sectors", KPLIB_sectors_fobs apply { (_x#0); }, [[]]]
    //         , ["_classNames", KPLIB_resources_storageClassesF, [[]]]
    //     ];
    //     private _targetMarker = [_target, _range, _sectors] call **refactorme**KPLIB_fnc_common_getTargetMarkerIfInRange;**
    //     // TODO: TBD: once we get the build marker name issue sorted out we will need to consider that case here...
    //     if (!(_targetMarker isEqualTo "")) then {
    //         private _objects = nearestObjects [_target, _classNames, _range];
    //         {
    //             KPLIB_persistence_objects = KPLIB_persistence_objects - [_x];
    //             // TODO: TBD: and any attachments...
    //             deleteVehicle _x;
    //         } forEach _objects;
    //     };
    // };

    [] call KPLIB_fnc_admin_setupPlayerActions;
};

["Module initialized", "POST] [ADMIN", true] call KPLIB_fnc_common_log;

true
