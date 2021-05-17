#include "script_component.hpp"
/*
    KPLIB_fnc_resources_setCrateValue

    File: fn_resources_setCrateValue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-09 13:11:23
    Last Update: 2021-05-05 22:28:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets the resource value for the crate object.

    Parameter(s):
        _crate - a crate object [OBJECT, default: objNull]
        _value - a resoruce value [SCALAR, default: KPLIB_param_crateVolume]

    Returns:
        The operation finished [BOOL]
 */

params [
    [Q(_crate), objNull, [objNull]]
    , [Q(_value), KPLIB_param_crateVolume, [0]]
];

if (isNull _crate) exitWith {
    false;
};

private _default = -1;

_value = _value max 0;

_crate setVariable [QMVAR(_crateValue), _value, true];

_value == (_crate getVariable [QMVAR(_crateValue), _default]);
