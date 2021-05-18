/*
    KPLIB_fnc_common_getNearestMarkerAndUuid

    File: fn_common_getNearestMarkerAndUuid.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-13 20:04:55
    Last Update: 2021-02-13 20:04:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the nearest FOB '_markerName' plus its '_uuid'. Because in some scenarios,
        while knowing a marker name is interesting, we want to ensure of its uniqueness,
        and the UUID field is the way in which we do just that.

    Parameter(s):
        _target - the object from which to gauge nearest sector [OBJECT, default: player]
        _sectors - a sectors array;
            [nil, default: (KPLIB_sectors_all + KPLIB_sectors_edens + KPLIB_sectors_fobs)]
            [ARRAY]
        _default - a default return value in the event a result could not be obtained [STRING, default: ""]

    Returns:
        The sector '_markerName' corresponding with the nearest sector to the '_target' [STRING, default: _default]
 */

params [
    ["_target", player, [objNull]]
    , ["_default", "", [""]]
];

private _nearestMarker = [
    _target
    , KPLIB_param_fobs_range
    , KPLIB_sectors_fobs
    , _default] call KPLIB_fnc_common_getTargetMarkerIfInRange;

if (_nearestMarker isEqualTo _default) exitWith {
    // TODO: TBD: may also log...
    [_default, _default];
};

private _nearestFobs = KPLIB_sectors_fobs select { (_x#0) isEqualTo _nearestMarker; };

[_nearestMarker, (_nearestFobs#0#3)];
