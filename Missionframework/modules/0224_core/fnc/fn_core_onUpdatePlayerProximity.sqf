/*
    KPLIB_fnc_core_onUpdatePlayerProximity

    File: fn_core_onUpdatePlayerProximity.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-25
    Last Update: 2021-06-14 16:44:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Update PLAYER proximity local to the client machine. Key to this algorithm succeeding
        is that we must gauge each MARKER type according to its own range, in general: SECTORS,
        FOBS, and STARTBASES. After having screened in general, then we want to order in terms
        of ACTUAL RANGE to the PLAYER. After which, we want the NEAREST matching MARKER.

        In addition to reporting the NEAREST NEAREST MARKER MARKER NAME, we also want to
        report the NEAREST FOB, NEAREST STARTBASE, and NEAREST MARKER in general, which will
        themselves be useful when determining HUD displays.

    Parameter(s):
        _player - the PLAYER object for which proximity is updated [OBJECT, default: objNull]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
        http://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
        http://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
 */

// TODO: TBD: could do the more general "update target proximity" one off function..
params [
    ["_player", player, [objNull]]
];

if (alive _player) then {

    // Shape: [[_markers, _range], ...]
    private _allProximities = +[
        [missionNamespace getVariable ["KPLIB_sectors_all", []], KPLIB_param_sectors_actRange]
        , [missionNamespace getVariable ["KPLIB_sectors_fobs", []], KPLIB_param_fobs_range]
        , [missionNamespace getVariable ["KPLIB_sectors_startbases", []], KPLIB_param_eden_startbaseRadius]
    ];

    private _getMarkerDistance = { markerPos _this distance2D _player; };

    /* First, sort all PROXIMITIES among themselves
     * Shape: [[[_marker, _distance], ...], ...]
     * Filtering: The overall MARKER+DISTANCE report, notwithstanding actual counts
     * Returns with the NEAREST CANDIDATES in each of the categories, if possible
     */
    private _nearestCandidates = _allProximities apply {
        _x params ["_markers", "_range"];
        private _nearest = [_markers, [], { _x call _getMarkerDistance; }, "ascend", { _x call _getMarkerDistance <= _range; }] call BIS_fnc_sortBy;
        _nearest apply { [_x, _x call _getMarkerDistance, _range]; };
    };

    // First we want to make a note of each category
    _nearestCandidates params [
        ["_allCandidates", [], [[]]]
        , ["_fobCandidates", [], [[]]]
        , ["_startBaseCandidates", [], [[]]]
    ];

    // Dissect each CATEGORY and install on PLAYER accordingly as appropriate
    private _setNearestCategoryMarker = {
        params [
            ["_categoryVarName", "", [""]]
            , ["_markerDistPairs", [], [[]]]
        ];
        _markerDistPairs params [
            ["_markerDistPair", [], [[]]]
        ];
        _markerDistPair params [
            ["_markerName", "", [""]]
            , ["_distance", 0, [0]]
        ];
        if (_markerName isEqualTo "") then {
            _player setVariable [_categoryVarName, nil, true];
        } else {
            _player setVariable [_categoryVarName, _markerName, true];
        };
    };

    // "Out of range" markers should be filtered out by this point
    ["KPLIB_sectors_nearestSector", _allCandidates] call _setNearestCategoryMarker;
    ["KPLIB_sectors_nearestFob", _fobCandidates] call _setNearestCategoryMarker;
    ["KPLIB_sectors_nearestStartBase", _startBaseCandidates] call _setNearestCategoryMarker;

    /* Then we want to contain the true nearest sector
     * #0. A MARKER+DISTANCE pair
     * #1. The DISTANCE component of each pair
     * Shape: [[[_marker, _distance], ...], ...]
     * Filtering: Should contain only those MARKERS with verified DISTANCES
     * We should have the 'NEAREST NEAREST' CANDIDATES following this sort
     */
    private _nearestNearestCandidates = [_nearestCandidates, [], { (_x#0#1); }, "ascend", { count _x > 0; }] call BIS_fnc_sortBy;
    //                        Mindful of intermediate tuple shapes: ^^^^^^

    // After the above questions then we should be able to isonate a specific MARKER(+RANGE)
    _nearestNearestCandidates params [
        ["_nearestCandidates", [], [[]]]
    ];

    _nearestCandidates params [
        ["_nearestCandidate", [], [[]]]
    ];

    _nearestCandidate params [
        ["_markerName", "", [""]]
        , ["_distance", 0, [0]]
    ];

    // Which should either SET or UNSET the variable accordingly
    if (_markerName isEqualTo "") then {
        _player setVariable ["KPLIB_sectors_markerName", nil, true];
    } else {
        _player setVariable ["KPLIB_sectors_markerName", _markerName, true];
    };
};

// Relay the baton for the next iteration
[
    { [] call KPLIB_fnc_core_onUpdatePlayerProximity; }
    , []
    , KPLIB_param_core_updatePlayerProximityPeriod
] call CBA_fnc_waitAndExecute;

true;
