/*
    KPLIB_fnc_common_vehicleSafeRadius

    File: fn_common_vehicleSafeRadius.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-10 15:38:25
    Last Update: 2021-06-14 16:38:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the MINIMUM SAFE RADIUS about a given VEHICLE CLASS NAME which
        shall be considered for activities such a vehicle creation, placement, etc.

        We depend on a BOUNDING BOX having been CACHED corresponding to the CLASS NAME
        in order to make an appropriate calculation in response to this function.

        Assumes that CLASS NAME is at a least valid vehicle class which may be created.

    Parameter(s):
        _className - the CLASS NAME being created [STRING, default: '']

    Returns:
        Minimum safe radius about the vehicle class [SCALAR]

    References:
        https://community.bistudio.com/wiki/boundingBoxReal#Examples
        https://community.bistudio.com/wiki/File:Boundingbox.jpg
        https://community.bistudio.com/wiki/Position#PositionRelative
        https://community.bistudio.com/wiki/vectorMultiply
        https://community.bistudio.com/wiki/vectorAdd
        https://community.bistudio.com/wiki/selectMax
 */

params [
    ["_className", "", [""]]
];

private _bbr = [_className] call KPLIB_fnc_common_vehicleBoundingBox;

_bbr params ["_p1", "_p2"];

private _deltas = _p1 vectorAdd (_p2 vectorMultiply -1);

private _maxDiameter = selectMax (_deltas apply { abs _x; });

private _maxRadius = _maxDiameter / 2;

_maxRadius;
