/*
    KPLIB_fnc_common_getMomentum

    File: fn_common_getMomentum.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 13:21:55
    Last Update: 2021-05-19 13:21:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the MOMENTUM of the TARGET object.

    Parameter(s):
        _target - the TARGET object [OBJECT, default: objNull]
        _absolute - whether to calculate in terms of absolute value [BOOL, default: true]

    Returns:
        The MOMENTUM of the TARGET object [SCALAR]
 */

params [
    ["_target", objNull, [objNull, []]]
    , ["_absolute", true, [true]]
];

private _speed = speed _target;

if (_absolute) exitWith { abs _speed; };

_speed;
