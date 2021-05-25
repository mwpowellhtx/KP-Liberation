/*
    KPLIB_fnc_core_onUpdatePlayerProximity

    File: fn_core_onUpdatePlayerProximity.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-25
    Last Update: 2021-05-21 00:40:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Update PLAYER proximity local to the client machine. Key to this algorithm succeeding
        is that we must gauge each MARKER type according to its own range, in general: SECTORS,
        FOBS, and STARTBASES. After having screened in general, then we want to order in terms
        of ACTUAL RANGE to the PLAYER. After which, we want the NEAREST matching MARKER.

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
        [KPLIB_sectors_all, KPLIB_param_sectors_actRange]
        , [KPLIB_sectors_fobs, KPLIB_param_fobs_range]
        , [KPLIB_sectors_startbases, KPLIB_param_eden_startbaseRadius]
    ];

    private _getMarkerDistance = { markerPos _this distance _player; };

    /* First, sort all PROXIMITIES among themselves
     * Shape: [[[_marker, _distance], ...], ...]
     * Filtering: The overall MARKER+DISTANCE report, notwithstanding actual counts
     */
    private _proximities = _allProximities apply {
        _x params ["_markers", "_range"];
        private _nearest = [_markers, [], { _x call _getMarkerDistance; }, "ascend", { _x call _getMarkerDistance <= _range; }] call BIS_fnc_sortBy;
        _nearest apply { [_x, _x call _getMarkerDistance]; };
    };

    /* #0. A MARKER+DISTANCE pair
     * #1. The DISTANCE component of each pair
     * Shape: [[[_marker, _distance], ...], ...]
     * Filtering: Should contain only those MARKERS with verified DISTANCES
     */
    private _allCandidates = [_proximities, [], { (_x#0#1); }, "ascend", { count _x > 0; }] call BIS_fnc_sortBy;
    //       Mindful of intermediate tuple shapes: ^^^^^^

    // After the above questions then we should be able to isonate a specific MARKER(+RANGE)
    _allCandidates params [
        ["_candidates", [], [[]]]
    ];

    _candidates params [
        ["_candidate", [], [[]]]
    ];

    _candidate params [
        ["_marker", "", [""]]
        , ["_range", 0, [0]]
    ];

    // Which should either SET or UNSET the variable accordingly
    _player setVariable ["KPLIB_sectors_markerName", _marker, true];
};

// Relay the baton for the next iteration
[
    { [] call KPLIB_fnc_core_onUpdatePlayerProximity; }
    , []
    , KPLIB_param_core_updatePlayerProximityPeriod
] call CBA_fnc_waitAndExecute;

true;
