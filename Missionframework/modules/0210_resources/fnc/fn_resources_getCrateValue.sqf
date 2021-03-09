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
    ["_crate", objNull, [objNull]]
];

private _value = 0;

if (isNull _crate) exitWith { _value; };

_value = _crate getVariable ["KPLIB_resources_crateValue", 0];

_value;
