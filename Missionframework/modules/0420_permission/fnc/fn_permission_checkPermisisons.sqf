/*
    KPLIB_fnc_permission_checkPermisisons

    File: fn_permission_checkPermisisons.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-22 12:35:54
    Last Update: 2021-05-25 12:25:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks whether all of the requested permissions have been granted. Default
        logic is that ALL of the REQUESTED permissions must be granted.

    Parameter(s):
        _requested - the REQUESTED permissions [ARRAY, default: []]
        _unanimous - whether GRANTED should be UNANIMOUS [BOOL, default: false]
        _target - a TARGET object [OBJECT, default: player]
        _all - whether ALL of the REQUESTED permissions should be granted [BOOL, default: true]

    Returns:
        Whether the ANY or ALL permissions have been granted [BOOL]
 */

params [
    ["_requested", [], [[]]]
    , ["_unanimous", false, [false]]
    , ["_target", player, [objNull]]
    , ["_all", true, [true]]
];

if (isNull _target || _requested isEqualTo []) exitWith { false; };

private _granted = _requested select { [_x, _unanimous, _target] call KPLIB_fnc_permission_checkPermission; };

private _any = !_all;
private _intersection = _granted arrayIntersect _requested;

(_all && _intersection isEqualTo _requested)
    || (_any && !(_intersection isEqualTo []))
    ;
