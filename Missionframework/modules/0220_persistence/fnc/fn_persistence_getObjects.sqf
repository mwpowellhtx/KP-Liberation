/*
    KPLIB_fnc_persistence_enumerateFobObjects

    File: fn_persistence_enumerateFobObjects.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 19:38:09
    Last Update: 2021-05-20 11:20:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns an ARRAY of OBJECTS within RANGE of each of the FOB BUILDINGS that should be persistent.

    Parameter(s):
        _markerNames - an array of MARKER NAMES [ARRAY, default: KPLIB_sectors_fobs]
        _range - a RANGE within which to consider [SCALAR, default: KPLIB_param_fobs_range]
        _classNames - CLASS NAMES used to restrict the nearest objects [ARRAY, default: []]

    Returns:
        An ARRAY of eligible OBJECTS [ARRAY]

    References:
        https://community.bistudio.com/wiki/flatten
 */

params [
    ["_markerNames", +KPLIB_sectors_fobs, [[]]]
    , ["_range", KPLIB_param_fobs_range, [0]]
    , ["_classNames", [], [[]]]
];

private _allObjectsToPersist = _markerNames apply {
    private _markerPos = markerPos _x;
    private _objects = nearestObjects [_markerPos, _classNames, _range];
    private _objectsToPersist = _objects select { [_x, _range, _markerNames] call KPLIB_fnc_persistence_shouldBePersistent; };
    _objectsToPersist;
};

flatten _allObjectsToPersist;
