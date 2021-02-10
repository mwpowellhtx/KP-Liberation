/*
    KPLIB_fnc_timers_renderTimeRemainingString

    File: fn_timers_renderTimeRemainingString.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 01:08:13
    Last Update: 2021-02-10 01:08:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Renders the timer to string format.

    Parameter(s):
        May be invoked with the _timer tuple itself as the arguments array:
        _timer - as the entire function args: i.e. [KPLIB_timers_disabled, KPLIB_timers_disabled, 0, 0]
            _duration - literally the timer duration, negative to disable [SCALAR, default: KPLIB_timers_disabled]
            _startTime - the time when the timer started [SCALAR, default: KPLIB_timers_disabled]
            _elapsedTime - the epalsed time since the timer started [SCALAR, default: 0]
            _timeRemaining - the estimated time remaining [SCALAR, default: 0]
            _now - not technically part of the _timer tuple, we allow for a _now component, which informs
                the current ([] call KPLIB_fnc_timers_now) while performing the necessary creation [SCALAR, default: ([] call KPLIB_fnc_timers_now)]
                i.e. [KPLIB_timers_disabled, KPLIB_timers_disabled, 0, 0, [] call KPLIB_fnc_timers_now]

    Returns:
        The time rendered to string format.
            "##:##" - when there are at least seconds remaining, also minutes and seconds
            "##:##:##" - when there are hours, minutes, seconds remaining
            "#.##:##:##" - when there are also days remaining
        Trims off any leading zeros ('0') when necessary.
*/

params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", KPLIB_timers_disabled, [0]]
    , ["_elapsedTime", 0, [0]]
    , ["_timeRemaining", 0, [0]]
];

private ["_i"];

// Return with a "not running" representation
if (_duration <= 0) exitWith {
    KPLIB_timers_renderedNotRunning;
};

/* Handles cases where the timer has run over for whatever reason,
 * and render timer overages as 'positive' time. */
private _signage = if (_timeRemaining <= 0) then { "+"; } else { ""; };
_timeRemaining = abs _timeRemaining;

private _parts = [];

private _factors = [60, 60, 24];
//                          ^^ hours per day
//                      ^^ minutes per hour
//                  ^^ seconds per minute

// This is not that much different an algo from converting base values
for [{ _i = 0; }, { _i < count _factors && _timeRemaining >= 0; }, { _i = _i + 1; }] do {
    private _factor = _factors select _i;
    private _newRemaining = floor (_timeRemaining / _factor);
    _parts = [_timeRemaining - (_newRemaining * _factor)] + _parts;
    _timeRemaining = _newRemaining;
};

// We want at least these number of parts, minutes and seconds
if (count _parts < 2) then { _parts = [0] + _parts; };

// Renders the hours:minutes:seconds parts first
private _renderedParts = (_parts apply {
    if (_x >= 10) then { str _x; } else { format ["0%1", _x]; }
}) joinString ":";

private _rendered = _renderedParts;

// If there is still time remaining then these are a 'days' component
if (_timeRemaining > 0) then {
    _rendered = format ["%1.%2", _timeRemaining, _renderedParts];
};

// Read around a leading '0' when necessary
if (_rendered select [0, 1] isEqualTo "0") then {
    _rendered = _rendered select [1, count _rendered - 1];
};

// Otherwise return with what we have in rendered parts
_signage + _rendered;
