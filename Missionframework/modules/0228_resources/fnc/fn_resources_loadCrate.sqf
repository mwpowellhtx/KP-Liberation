#include "script_component.hpp"
/*
    KPLIB_fnc_resources_loadCrate

    File: fn_resources_loadCrate.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 18:27:14
    Last Update: 2021-05-27 18:27:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Loads the given crate to nearest valid transport vehicle.

    Parameter(s):
        _crate - Crate which should be loaded [OBJECT, defaults to objNull]

    Returns:
        Whether the crate loaded on a transport vehicle [BOOL]
 */

params [
    [Q(_crate), objNull, [objNull]]
];

// Exit if we have no valid crate object
if (isNull _crate || !(typeOf _crate in MVAR(_crateClasses))) exitWith {
    false;
};

// TODO: TBD: entities? or 'objects'?
// Check for near transport vehicles
private _nearTransports = _crate nearEntities [MVAR(_transportVehicles), 10];

// De-con the nearest nearest transport
_nearTransports params [
    [Q(_nearTransport), objNull, [objNull]]
];

// Exit if no transport vehicles near
if (!isNull _nearTransport) exitWith {
    [localize "STR_KPLIB_HINT_NOTRANSPORTNEAR"] call KPLIB_fnc_notification_hint;
    false;
};

// TODO: TBD: will reserve for future use: revise 'KPLIB_fnc_resources_getAttachArray' to handle both STORAGE+TRANSPORT...
// Get attach position array depending on transport vehicle
private _attachPositions = [typeOf _nearTransport] call {
    params [Q(_className)];
    private _cfgs = MVAR(_transportConfigs) select { (_x#0) isEqualTo _className; };
    _cfgs params [Q(_cfg)];
    _cfgs#2;
};

// Get amount of used slots
private _usedSlots = _nearTransport getVariable [QMVAR(_usedSlots), 0];

// TODO: TBD: instead of questions like this, we should really be front loading the conditions on the menus themselves...
// Exit if the nearest storage has no more space
if (_usedSlots >= (count _attachPositions)) exitWith {
    [localize "STR_KPLIB_HINT_NOSTORAGESPACE"] call KPLIB_fnc_notification_hint;
    false;
};

// // TODO: TBD: this is where better API would be helpful...
// // TODO: TBD: do we really need another variable?
// // TODO: TBD: or just count the attached objects of the apppropriate kinds
// Load crate to transport and adjust usedSlots variable
_crate attachTo [_nearTransport, _attachPositions select _usedSlots];
_nearTransport setVariable [QMVAR(_usedSlots), _usedSlots + 1, true];

// TODO: TBD: should really go during a vehicle create event handler...
// TODO: TBD: and perhaps with a slightly more robust storage/transport slots API...
// TODO: TBD: but for now that is pasta we do not want to eat...
[_nearTransport] remoteExecCall [QMFUNC(_setupTransportActions), 0, _nearTransport];

true;
