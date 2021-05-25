#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onObjectDeserialized

    File: fn_fobs_onObjectDeserialized.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-23 16:47:42
    Last Update: 2021-05-23 16:47:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _object - the OBJECT being DESERIALIZED [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

switch (typeOf _object) do {
    case KPLIB_preset_fobBuildingF: {
        [_object] call MFUNC(_setBuildingVarName);
    };
};

true;
