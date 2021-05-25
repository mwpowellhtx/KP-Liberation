#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_onBuildItemBuiltLocal

    File: fn_fobs_onBuildItemBuiltLocal.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 09:39:52
    Last Update: 2021-05-19 09:57:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to client side portion when a build item was built. In the case of this
        module, we must do some bookkeeping when objects were built in order to delete
        the object that was the source of the entire sequence.

    Parameter(s):
        _object - the OBJECT that was just built [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_fobs_onBuildItemBuiltLocal] Entering: [isNull _object, typeOf _object]: %1"
        , str [isNull _object, typeOf _object]], "FOBS", true] call KPLIB_fnc_common_log;
};

private _player = player;

switch (typeOf _object) do {

    case KPLIB_preset_fobBoxF;
    case KPLIB_preset_fobTruckF: {
        // FOB BOX|TRUCK may be built with or without REPACKAGE FOB being the source
        private _fobBuilding = _player getVariable [QMVAR(_packBuilding), objNull];
        if (!isNull _fobBuilding) then {
            // PLAYER relays to server side for TEAR DOWN completion then forget about it
            [_fobBuilding] remoteExecCall [QMFUNC(_onTearDownBuilding), 2];
            _player setVariable [QMVAR(_packBuilding), nil];
        };
    };

    case KPLIB_preset_fobBuildingF: {
        // Server side handles most of this, so all the PLAYER need to is forget about it
        private _boxOrTruck = _player getVariable [QMVAR(_boxOrTruck), objNull];
        deleteVehicle _boxOrTruck;
        _player getVariable [QMVAR(_boxOrTruck), nil];
    };
};

if (_debug) then {
    ["[fn_fobs_onBuildItemBuiltLocal] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
