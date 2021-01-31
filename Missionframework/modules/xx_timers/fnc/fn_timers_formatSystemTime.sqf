/*
    KPLIB_fnc_time_formatSystemTime

    File: fn_time_formatSystemTime.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 18:20:12
    Last Update: 2021-01-26 18:20:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Formats the given systemTime components with appropriate padding

    Parameters:
        _value - The systemTime array [ARRAY, default: [0, 0, 0, 0, 0, 0, 0]]
        _options - Options to specify [ARRAY, default: [_withDate, _withTime, _withMillisecond]]

    Returns:
        The formatted systemTime _value [STRING, format: "yyyy-mm-dd hh:MM:ss.ttt"]

    References:
        https://community.bistudio.com/wiki/systemTime
*/

// TODO: TBD: could not identify any functions that render a systemTime to string...
params [
    ["_value", systemTime, [[]], 7]
    , ["_options", [true, true, true], [[]], 3]
];

//// TODO: TBD: may include debug flags later...
//[format ["[fn_systemTime_format]: [value, options]: %1", str [_value, _options]], "SYSTEMTIME"] call KPLIB_fnc_common_log;

_value apply {format ["%1", _x]} params [
    "_year"
    , "_month"
    , "_day"
    , "_hour"
    , "_minute"
    , "_second"
    , "_millisecond"
];

private _pad = {
    params [
        ["_s", "", [""]]
        , ["_width", 2, [0]]
    ];

    while {count _s < _width} do {
        _s = format ["0%1", _s];
    };

    _s
};

_options params ["_withDate", "_withTime", "_withMillisecond"];

//[format ["[fn_systemTime_format]: params: [value, options]: %1", str [
//    [_year, _month, _day, _hour, _minute, _second, _millisecond]
//    , [_withDate, _withTime, _withMillisecond]
//]], "SYSTEMTIME"] call KPLIB_fnc_common_log;

['-', ':', '.', ' '] params ["_hyp", "_col", "_dot", "_space"];

private _date = "";
private _time = "";

if (_withDate) then {
    [_month, _day] apply {[_x, 2] call _pad} params ["_0", "_1"];
    _month = _0;
    _day = _1;
    _date = [_year, _month, _day] joinString _hyp;
};

if (_withTime) then {
    [_minute, _second] apply {[_x, 2] call _pad} params ["_0", "_1"];
    _minute = _0;
    _second = _1;
    _time = [_hour, _minute, _second] joinString _col;

    if (_withMillisecond) then {
        _millisecond = [_millisecond, 3] call _pad;
        _time = [_time, _millisecond] joinString _dot;
    };
};

([] call {
    if (_withDate && _withTime) exitWith {[_date, _time]};
    if (_withDate) exitWith {[_date]};
    if (_withTime) exitWith {[_time]};
    [];
}) joinString _space;
