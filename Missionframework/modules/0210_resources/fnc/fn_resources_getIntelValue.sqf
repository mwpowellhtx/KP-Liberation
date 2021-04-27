#include "script_component.hpp"
/*
    KPLIB_fncresources_getIntelValue

    File: fn_resources_getIntelValue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 18:55:49
    Last Update: 2021-04-26 18:58:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the INTEL value corresponding to the target OBJECT or its class name.

    Parameter(s):
        _targetOrClassName - class name for the INTEL object, or the OBJECT itself [STRING|OBJECT, default: ""]

    Returns:
        The INTEL value for the class name [SCALAR]
 */

params [
    [Q(_targetOrClassName), "", [objNull, ""]]
];

private _className = switch (true) do {
    case (_targetOrClassName isEqualType objNull): {
        typeOf _targetOrClassName;
    };
    case (_targetOrClassName isEqualType ""): {
        _targetOrClassName;
    };
    default { ""; }; 
};

private _zed = 0;

if (_className in MPRESET(_intelMap)) exitWith {
    private _offset = MPRESET(_intelMap) get _className;
    _offset + ([4, _offset] call KPLIB_fnc_linq_roll);
};

_zed;
