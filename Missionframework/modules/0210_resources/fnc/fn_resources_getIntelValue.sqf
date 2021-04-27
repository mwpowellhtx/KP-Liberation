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
        Returns the INTEL value corresponding to the class name.

    Parameter(s):
        _className - class name for the INTEL object [STRING, default: ""]

    Returns:
        The INTEL value for the class name [SCALAR]
 */

params [
    [Q(_className), "", [""]]
];

private _zed = 0;

if (_className in MPRESET(_intelClassNames)) exitWith {
    private _intelIndex = MPRESET(_intelClassNames) findIf { _x isEqualTo _className; };
    private _offset = _intelIndex + 1;
    _offset + ([4, _offset] call KPLIB_fnc_linq_roll);
};

_zed;
