/*
    KPLIB_fnc_common_getSectorInfo

    File: fn_common_getSectorInfo.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-01-29 17:25:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the 'KPLIB_sector_info' corresponding to the _target object. When the
        variable cannot be identified on _target, then we make a best effort to identify
        the bits based on current geospatial references to 'KPLIB_sectors_edens' and
        'KPLIB_sectors_fobs'.

    Parameter(s):
        _target - the _target from which to obtain the 'KPLIB_sector_info' [OBJECT, default: player]
            - tuples in the shape of, ['_markerName', '_uuid', '_sectorType']
        _selector - OPTIONAL, may select bits of the info tuple as needed [CODE, default: {_this}]
        _default - a defaullt return value in the event the variable has not yet been set

    Returns:
        The sector UUID variable attached to the _target object, if possible. Empty string oetherwise.
*/

params [
    ["_target", player, [objNull]]
    , ["_selector", {_this}, [{}]]
    , ["_default", ["", "", KPLIB_sectorType_nil], [[]], 3]
];

if (isNull _target) exitWith {_default};

/* Which are all injected by the "eventLoop" ... Note that here we are looking for that
 * moment when Player is near an FOB, but Player may be accounted for anywhere on the map. */

if ("KPLIB_sector_info" in (allVariables _target)) exitWith {
    (_target getVariable "KPLIB_sector_info") call _selector;
};

/* We get away with merging the two sets because we make the
 * decision to represent the assets in the same shape. */

private _xPlusRange = {
    params [
        ["_range", 0, [0]]
        , ["_tuple", [], [[]]]
    ];
    [_tuple#3#0, _tuple#1#0, _tuple#2#0] params ["_markerName", "_uuid", "_sectorType"];
    private _markerPos = getMarkerPos _markerName;
    private _dist = _target distance2d _markerPos;
    [_dist <= _range, _dist, _markerName, _uuid, _sectorType];
};

// Apply the transformation including distance candidates.
private _edens = KPLIB_sectors_edens apply {[KPLIB_param_edenRange, _x] call _xPlusRange};
private _fobs = KPLIB_sectors_fobs apply {[KPLIB_param_fobRange, _x] call _xPlusRange};

// Include only those sectors within the appropriate ranges.
private _selection = (_edens + _fobs) select {_x#0} apply {_x select [1, count _x - 1]};

private _dist2d = -1;

// TODO: TBD: looks kind of similar to the event loop...
// TODO: TBD: then maybe we just use this...
// TODO: TBD: excepting for the cached state informing the event loop...
private _aggregateG = [_default, _selection, {
    params [
        ["_g", _default, [[]], 3]
        , ["_current", [], [[]], 4]
    ];
    if (_dist2d < 0 || _dist2d > _current#0) then {
        // Tally the current distance, and register the new G candidate in queue.
        _dist2d = _current#0;
        _current select [1, count _current - 1];
    } else {_g};
}] call KPLIB_fnc_linq_aggregate;

_aggregateG call _selector;
