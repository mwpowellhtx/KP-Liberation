#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onSerializingObject

    File: fn_resources_onSerializingObject.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 16:32:57
    Last Update: 2021-05-19 16:33:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Installs the STORAGE VALUES summary on the OBJECT prior to serialization.

    Parameter(s):
        _object - the OBJECT being SERIALIZED [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

switch (typeOf _object) do {
    case KPLIB_preset_storageSmallF;
    case KPLIB_preset_storageLargeF: {
        private _storageValue = [_object] call MFUNC(_getStorageValue);
        _object setVariable [QMVAR(_storageValue), _storageValue, true];
    };
};

true;
