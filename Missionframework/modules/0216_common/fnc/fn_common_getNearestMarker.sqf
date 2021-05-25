/*
    KPLIB_fnc_common_getNearestMarker

    File: fn_common_getNearestMarker.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-13 07:44:25
    Last Update: 2021-05-22 11:16:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the NEAREST MARKER in proximity to the TARGET object. May specify MARKER NAMES,
        as well as optional RANGE about which to filter. When VARIABLE NAME is speficied, that is
        installed on the TARGET object as a global variable.

    Parameter(s):
        _target - TARGET object about which to report the nearest marker [OBJECT, default: player]
        _markerNames - an ARRAY of marker names [ARRAY, default: KPLIB_sectors_all]
        _range - optional RANGE about which to report [SCALAR|NIL, default: nil]
        _variableName - optional VARIABLE NAME to install omn the TARGET upon successful match [STRING|NIL, default: nil]
        _global - whether the VARIABLE NAME shall be considered GLOBAL [BOOL, default: true]

    Returns:
        The NEAREST MARKER in proximity to the TARGET object [STRING]
 */

params [
    ["_target", player, [objNull]]
    , ["_markerNames", +KPLIB_sectors_all, [[]]]
    , ["_range", nil, [0]]
    , ["_variableName", nil, [""]]
    , ["_global", true, [true]]
];

private _direction = "ascend";
private _nearestMarker = "";

if (isNull _target) exitWith { _nearestMarker; };

private _getTargetDistance = {
    params [
        ["_markerName", "", [""]]
    ];
    markerPos _markerName distance _target;
};

private _sortedMarkers = if (isNil { _range; }) then {
    [_markerNames, [], { [_x] call _getTargetDistance; }, _direction] call BIS_fnc_sortBy;
} else {
    [_markerNames, [], { [_x] call _getTargetDistance; }, _direction, { ([_x] call _getTargetDistance) <= _range; }] call BIS_fnc_sortBy;
};

if (count _sortedMarkers > 0) then { _nearestMarker = _sortedMarkers#0; };

if (!isNil { _variableName; }) then {
    _target setVariable [_variableName, _nearestMarker, _global];
};

_nearestMarker;
