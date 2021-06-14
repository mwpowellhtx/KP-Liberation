#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onIntelCreated

    File: fn_resources_onIntelCreated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-04 00:21:56
    Last Update: 2021-06-14 16:45:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        INTEL object 'KPLIB_vehicle_created' event handler.

    Parameter(s):
        _object - the OBJECT being created [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

if (isServer) then {
    // Server side section

    if (typeOf _object in MPRESET(_intelClassNames)) then {
        _object setVariable [QMVAR(_uuid), [] call KPLIB_fnc_uuid_create_string, true];
    };
};

if (hasInterface) then {
    // Client side section
    // TODO: TBD: with room left for client side response if so desired...
    // TODO: TBD: i.e. in addition to or instead of CBA class events...
};

true;
