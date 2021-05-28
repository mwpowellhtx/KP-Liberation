#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onVehicleCreated

    File: fn_resources_onVehicleCreated.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-15
    Last Update: 2021-05-27 16:49:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Remotely delegates OBJECT action callbacks in a JIP manner.

    Parameter(s):
        _object - an OBJECT being created [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

switch (typeOf _object) do {
    case KPLIB_preset_crateSupplyF;
    case KPLIB_preset_crateAmmoF;
    case KPLIB_preset_crateFuelF;
    case KPLIB_preset_crateSupplyE;
    case KPLIB_preset_crateAmmoE;
    case KPLIB_preset_crateFuelE: {

        // For bookkeeping purposes
        KPLIB_resources_allCrates pushBackUnique _object;
        // // TODO: TBD: should it be public? maybe, but it seems excessive...
        // publicVariable Q(KPLIB_resources_allCrates);

        [_object] remoteExecCall [QMFUNC(_setupCrateActions), 0, _object];
    };

    // TODO: TBD: there should also be transport vehicle load/unload correct?
    case KPLIB_preset_storageSmallE;
    case KPLIB_preset_storageSmallF;
    case KPLIB_preset_storageLargeE;
    case KPLIB_preset_storageLargeF: {

        // For bookkeeping purposes
        KPLIB_resources_allStorages pushBackUnique _object;
        // // TODO: TBD: should it be public? maybe, but it seems excessive...
        // publicVariable Q(KPLIB_resources_allStorages);

        [_object] remoteExecCall [QMFUNC(_setupStorageActions), 0, _object];
    };
};

true;
