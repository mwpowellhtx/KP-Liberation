#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onVehicleCreated

    File: fn_fobs_onVehicleCreated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 22:18:43
    Last Update: 2021-05-24 15:42:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Vehicle created event handler.

    Parameter(s):
        _vehicle - a VEHICLE object that was created [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

private _debug = MPARAM(_onVehicleCreated_debug)
    || (_object getVariable [QMVAR(_onVehicleCreated_debug), false])
    ;

if (_debug) then {
    [format ["[fn_fobs_onVehicleCreated] Entering: [isNull _object, typeOf _object]: %1"
        , str [isNull _object, typeOf _object]], "FOBS", true] call KPLIB_fnc_common_log;
};

switch (typeOf _object) do {

    case KPLIB_preset_fobBoxF;
    case KPLIB_preset_fobTruckF: {

        [_object] remoteExecCall [QMFUNC(_setupDeployActions), 0, _object];

        /* Verify the STARTING BOX|TRUCK, when there are no other of these vehicles,
         * plus no other FOB BUILDINGS, then respawn the BOX|TRUCK. */

        _object addMPEventHandler ["MPKilled", { _this call MFUNC(_onVerifyStartingBoxOrTruck); }];
    };

    // TODO: TBD: actually yes want to add tear down action here on the building itself...
    case KPLIB_preset_fobBuildingF: {
        // // TODO: TBD: there may be triggers etc we can install here...
        // // TODO: TBD: however anything else, resequence, etc, do not do that here...
        // [_object] remoteExecCall [QMFUNC(_setupPackActions), 0, _object];
    };

    case KPLIB_preset_respawnTruckF: {
        [_object] remoteExecCall [QMFUNC(_setupRespawnActions), 0, _object];
    };
};

if (_debug) then {
    ["[fn_fobs_onVehicleCreated] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
