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
            - tuples in the shape of, ['_markerName', '_sectorType', '_uuid']
        _selector - OPTIONAL, may select bits of the info tuple as needed [CODE, default: {_this}]
        _default - a defaullt return value in the event the variable has not yet been set

    Returns:
        The sector UUID variable attached to the _target object, if possible. Empty string oetherwise.
*/

params [
    ["_target", player, [objNull]]
    , ["_selector", {_this}, [{}]]
    , ["_default", ["", KPLIB_sectorType_nil, ""], [[]], 3]
];

if (isNull _target) exitWith {_default};

/* Which are all injected by the "eventLoop" ... Note that here we are looking for that
 * moment when Player is near an FOB, but Player may be accounted for anywhere on the map. */

if ("KPLIB_sector_info" in (allVariables _target)) exitWith {
    (_target getVariable "KPLIB_sector_info") call _selector;
};

/* We get away with merging the two sets because we make the
 * decision to represent the assets in the same shape. */

private _thisPlusRange = {
    params [
        ["_tuple", [], [[]]]
        , ["_range", 0, [0]]
    ];

    _tuple params [
        ["_ident", [], [[]], 4]
        , ["_info", [], [[]], 4]
    ];

    _ident params [
        ["_markerName", "", [""]]
        , "_markerText"
        , "_varName"
        , ["_pos", KPLIB_zeroPos, [[]], 3]
    ];

    _info params [
        ["_sectorType", 0, [0]]
        , "_side"
        , "_est"
        , ["_uuid", "", [""]]
    ];

    private _dist = _target distance2d _pos;
    [_dist <= _range, _dist, _markerText, _sectorType, _uuid];
};

/* Apply the transformation including distance candidates. Here we only want
 * the first two elements from each of the sectors tuples. Anticipating entry
 * into aspects such as production, especially, logistics, etc. */

private _edens = KPLIB_sectors_edens apply {([_x, KPLIB_param_edenRange]) call _thisPlusRange};
private _fobs = KPLIB_sectors_fobs apply {([_x, KPLIB_param_fobRange]) call _thisPlusRange};

// Include only those sectors within the appropriate ranges.
private _withinRange = (_edens + _fobs) select {_x#0};
private _selection = _withinRange apply {_x select [1, count _x - 1]};

// TODO: TBD: looks kind of similar to the event loop...
// TODO: TBD: then maybe we just use this...
// TODO: TBD: excepting for the cached state informing the event loop...

private _defaultRange = -1;

/* Aggregate the closest possible selection.
 * Note that we also assume a tuple shape of: [_dist2d]+_sectorInfo */
private _aggregateG = [([_defaultRange] + _default), _selection, {
    params ["_g", "_current"];
    /* Return with one of two cases:
     * 1. _g when we have a current _g and current is further away, or:
     * 2. _current when we have no other candidate or was nearer
     */
    if (_g#0 >= 0 && _current#0 > _g#0) then {_g} else {_current};
}] call KPLIB_fnc_linq_aggregate;

// And with the above optimization also simplifies the resulting distillation.
private _retvalG = _aggregateG select [1, count _aggregateG - 1];

// TODO: TBD: which we might do a check on the distance, when -1, return what? empty array?
_retvalG call _selector;
