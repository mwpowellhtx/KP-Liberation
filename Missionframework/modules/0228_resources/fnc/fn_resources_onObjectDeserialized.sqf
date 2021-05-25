#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onObjectDeserialized

    File: fn_resources_onObjectDeserialized.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 16:27:55
    Last Update: 2021-05-23 12:46:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        We just need the STORAGE CONTAINER object itself. Assuming variables have
        been properly serialized, the rest is transparent.

    Parameter(s):
        _object - the OBJECT being DESERIALIZED [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

switch (typeOf _object) do {
    case KPLIB_preset_storageSmallF;
    case KPLIB_preset_storageLargeF: {
        [_object] call MFUNC(_onPopulateStorage);
    };
};

true;
