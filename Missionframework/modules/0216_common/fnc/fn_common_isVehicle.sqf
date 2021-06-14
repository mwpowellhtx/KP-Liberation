/*
    KPLIB_fnc_common_isVehicle

    File: fn_common_isVehicle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-13 09:59:52
    Last Update: 2021-06-14 16:38:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the target object is a vehicle, i.e. that it supports a crew.

    Parameter(s):
        _target - a target object [OBJECT, default: objNull]

    Returns:
        Whether the target object is a vehicle [BOOL]

    References:
        https://community.bistudio.com/wiki/fullCrew#Alternate_Syntax
 */

params [
    ["_target", objNull, [objNull]]
];

if (isNull _target) exitWith {
    false;
};

// // TODO: TBD: should instead consider positions...
// This is about as simple a "vehicle" check as there is
private _crew = fullCrew [_target, "", true];

count _crew > 0;
