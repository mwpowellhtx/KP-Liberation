/*
    KPLIB_fnc_logistics_calculateTelemetry

    File: fn_logistics_calculateTelemetry.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 00:04:26
    Last Update: 2021-02-26 00:04:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Recalculates logistics asset telemetry based on any new information, changes in
        transport velocity from the most recent telemetry, etc. Should include side effects
        like impact to status flags, etc. Server side we only keep track of a few additional
        bits of detail in addition to the core logistics elements.

    Parameters:
        _targetUuid - the target UUID of the CBA logistics namespace to recycle transport [STRING, default: ""]

    Returns:
        Whether the request was successful [BOOL]

    References:
        https://en.wikipedia.org/wiki/Telemetry
        https://community.bistudio.com/wiki/getDir#Alternative_Syntax
        https://community.bistudio.com/wiki/BIS_fnc_dirTo#Description
        https://community.bistudio.com/wiki/Category:Function_Group:_Geometry
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

// TODO: TBD: recalculate: recalibrate new velocity
// TODO: TBD: recalculate: current pos from previous pos
// TODO: TBD: indicate whether blockage has occurred, etc
// TODO: TBD: if on standby then should estimate distance, duration, assuming the same, etc...

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , ["KPLIB_logistics_timer", +KPLIB_timers_default]
    , ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_status", KPLIB_logistics_status_standby, [0]]
    , ["_timer", [], [[]]]
    , ["_endpoints", [], [[]]]
];

if (_status <= KPLIB_logistics_status_standby) exitWith {
    // TODO: TBD: should log this...
    false;
};

_timer params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
];

// Semantically, contingent upon the status, ALPHA and BRAVO mean different things
_endpoints params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

private _zeroPos = +KPLIB_zeroPos;

_alpha params [
    ["_alphaPos", _zeroPos, [[]]]
];

_bravo params [
    ["_bravoPos", _zeroPos, [[]]]
];

private _newTransportSpeedMps = [] call KPLIB_fnc_logistics_calculateTransportSpeedMps;
private _telemetry = [_namespace, _newTransportSpeedMps] call KPLIB_fnc_logistics_getTelemetryArray;

// (De-)con bits of '_telemetry' for use throughout...
_telemetry params [
    "_totalDistanceMeters"
    , "_transitDistanceMeters"
    , "_oldTransportSpeedMps"
    , "_transitPos"
    , "_transitDir"
    , "_actualPos"
    , "_actualDir"
];

// ALPHA is always considered to be "loading" ...
if ([_status, KPLIB_logistics_status_loading] call BIS_fnc_bitflagsCheck) then {
    _transitPos = _alphaPos;
};

// BRAVO is always considered to be "unloading" ...
if ([_status, KPLIB_logistics_status_unloading] call BIS_fnc_bitflagsCheck) then {
    _transitPos = _bravoPos;
};

// State machine flags "blocks" or "abandoned", all we need to know is "where", or "when", it is
if ([_status, KPLIB_logistics_status_enRouteAbortingAbandoned] call BIS_fnc_bitflagsCheck) then {
    // Recalculate telemetry given new components, taking into account progress thus far

    // Recalibrate the logistics timer when key components, i.e. speed in mps, have changed
    if (_newTransportSpeedMps != _oldTransportSpeedMps) then {
        // As long as we are always keeping '_transitPos' up to date then should never have to calculate back from it using old speed
        _timer = [_alphaPos, _bravoPos, _transitPos, _newTransportSpeedMps] call KPLIB_fnc_logistics_calibrateTimer;
        //  Transit pos is a hard fact: ^^^^^^^^^^^ as are ALPHA and BRAVO positions
        //  Varying only by the new transport speed: ^^^^^^^^^^^^^^^^^^^^^

        /* Telemetry MAY recalibrate the timer, but that's it; the only thing we are
         * 'here' to do is calculate speed, distance, position, heading, etc. */

        _namespace setVariable ["KPLIB_logistics_timer", _timer];
    };

    // ============================================================================
    // TODO: TBD: this could potentially be a separate function in and of itself...

    // TODO: TBD: refactor as proper function, i.e. 'KPLIB_fnc_logistics_calculateTransitPos'
    private _result = [_alphaPos, _bravoPos, _timer, _newTransportSpeedMps] call {
        params [
            ["_alphaPos", +KPLIB_zeroPos, [[]]]
            , ["_bravoPos", +KPLIB_zeroPos, [[]]]
            , ["_timer", +KPLIB_timers_default, [[]]]
            , ["_speedMps", 0, [0]]
        ];

        // We do not need '_duration' ('_0') and '_startTime' ('_1') components in this instance
        _timer params [
            "_0"
            , "_1"
            , ["_elapsedTime", 0, [0]]
        ];

        private _alphaBravoDistanceMeters = _alphaPos distance2D _bravoPos;
        private _transitDistanceMeters = _elapsedTime * _speedMps;
        // Yes, always heading from ALPHA to BRAVO, never the other way round
        private _alphaBravoHeading = _alphaPos getDir _bravoPos;
        private _transitPos = _alphaPos getPos [_alphaBravoDistanceMeters, _alphaBravoHeading];

        +[
            _alphaBravoDistanceMeters
            , _transitDistanceMeters
            , _transitPos
            , _alphaBravoHeading
        ];
    };

    _totalDistanceMeters = (_result#0);
    _transitDistanceMeters = (_result#1);
    _transitPos = (_result#2);
    _transitDir = (_result#3);

    // ============================================================================
};

// TODO: TBD: for now "actual" pos is transit pos...
// TODO: TBD: however, we want to calculate telemetry and vectors on the nearest road, within range, if possible
// TODO: TBD: and "orient" so to speak the virtual transport (and/or actual map marker image) accordingly
_actualPos = +_transitPos;
_actualDir = _transitDir;

[_namespace, +[
    _totalDistanceMeters
    , _transitDistanceMeters
    , _newTransportSpeedMps
    , _transitPos
    , _transitDir
    , _actualPos
    , _actualDir
]] call KPLIB_fnc_logistics_setTelemetry;

true;
