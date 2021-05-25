#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_core_handleVehicleSpawn

    File: fn_core_handleVehicleSpawn.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-10
    Last Update: 2021-05-20 22:33:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handle vehicle spawn event

    Parameter(s):
        _vehicle - Vehicle which was spawned [OBJECT, default: objNull]

    Returns:
        Function reached the end [BOOL]

    References:
        https://community.bistudio.com/wiki/remoteExecCall
 */

params [
    ["_vehicle", objNull, [objNull]]
];

// TODO: TBD: consider adding cases here for FOB building as well...

// TODO: TBD: consider, "on create callbacks" ...
// TODO: TBD: better yet, class-based initializers...
// TODO: TBD: possibly also requiring managers/FSMs for new join players, proxmity objects, i.e. add actions on the fly...
switch (typeOf _vehicle) do {
    case KPLIB_preset_respawnTruckF;
    case KPLIB_preset_potatoF: {
        _vehicle setVariable ["KPLIB_asset_isMobileRespawn", true, true];
        [_vehicle] remoteExecCall ["KPLIB_fnc_fobs_setupMobileActions", 0, _vehicle];
    };
};

true;
