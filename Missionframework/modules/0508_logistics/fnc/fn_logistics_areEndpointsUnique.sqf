/*
    KPLIB_fnc_logistics_areEndpointsUnique

    File: fn_logistics_areEndpointsUnique.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-02 11:50:58
    Last Update: 2021-03-02 11:51:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the '_endpoints' ALPHA and BRAVO pairing are considered
        UNIQUE compared against '_lines' CHARLIE and DELTA pairings.

    Parameters:
        _endpoints - two ENDPOINTS, ALPHA and BRAVO, to be considered [ARRAY, default: []]
        _lines - the current logistics LINES whose CHARLIE and DELTA ENDPOINTS are compared [ARRAY, default: []]

    Returns:
        See above [BOOL]
 */

params [
    ["_endpoints", [], [[]], 2]
    , ["_lines", [], [[]]]
];

// No other lines, then consider that UNIQUE
if (count _lines == 0) exitWith {
    true;
};

// Manager may or may not have selected endpoint(s) yet at this moment...
_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

// Meaning that manager may engage fully with the endpoint groups...
if ((_alpha isEqualTo []) || (_bravo isEqualTo [])) exitWith {
    true;
};

// We only need to concern ourselves with lines that are currently active, i.e. not in STANDBY
private _whereNotInStandby = {
    _x params [
        ["_lineUuid", "", [""]]
        , ["_status", KPLIB_logistics_status_standby, [0]]
    ];
    _status > KPLIB_logistics_status_standby;
};

private _notInStandby = _lines select _whereNotInStandby;

// Calling the LINE ENDPOINTS '_charlie' and '_delta', respectively, for predicate purposes
private _whereInConflict = {

    // Expecting ENDPOINT for active lines in a 2x shape
    _x params [
        ["_lineUuid", "", [""]]
        , ["_status", KPLIB_logistics_status_standby, [0]]
        , ["_timer", +KPLIB_timers_default, [[]], 4]
        , ["_endpoints", [], [[]], 2]
    ];

    // We do not care about BILL VALUE for comparison purposes in these situations
    _endpoints params [
        ["_charlie", [], [[]]]
        , ["_delta", [], [[]]]
    ];

    // Check if the pairings or their swaps are equal, i.e. in CONFLICT
    private _alphaCharlieEqual = [_alpha, _charlie] call KPLIB_fnc_logistics_areEndpointsEqual;
    private _bravoDeltaEqual = [_bravo, _delta] call KPLIB_fnc_logistics_areEndpointsEqual;
    private _alphaDeltaEqual = [_alpha, _delta] call KPLIB_fnc_logistics_areEndpointsEqual;
    private _bravoCharlieEqual = [_bravo, _charlie] call KPLIB_fnc_logistics_areEndpointsEqual;

    (_alphaCharlieEqual && _bravoDeltaEqual)
        || (_alphaDeltaEqual && _bravoCharlieEqual);
};

private _inConflict = _notInStandby select _whereInConflict;

// No conflicts detected, i.e. UNIQUE
count _inConflict == 0;
