#include "script_component.hpp"
/*
    KPLIB_fnc_resources_getCrateValue

    File: fn_resources_getCrateValue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-09 13:11:23
    Last Update: 2021-03-09 13:11:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the resource value from the crate.

    Parameter(s):
        _crate - a crate object [OBJECT, default: objNull]

    Returns:
        The resource value from the crate [SCALAR]
 */

params [
    [Q(_crate), objNull, [objNull]]
];

private _default = 0;

if (isNull _crate) exitWith {
    _default;
};

private _value = _crate getVariable [QMVAR(_crateValue), _default];

_value;
