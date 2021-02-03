/*
    KPLIB_fnc_linq_aggregate

    File: fn_linq_aggregate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-25 23:16:31
    Last Update: 2021-01-25 23:16:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Given an initial value, an array, and a callback, applies the callback to the current value
        and the next array element in sequential order, yielding whatever the type of the aggregate
        result will be.

    Parameter(s):
        _start - The starting value [ANY, default: any]
        _values - The array of values [ARRAY, default: []]
        _callback - The callback to invoke for each of the elements [CODE, default: {}]
            - receives the arguments: [_g, _x, _i], where _g is the current aggregate, and _x is the element

    Returns:
        The results after aggregating the start over the values through the callback.

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.aggregate
*/

// TODO: TBD: ditto error handling for now...

private _defaultCallback = {
    params ["_g", "_x", "_i"];
    // No-op in the default case.
};

params [
    ["_start", nil]
    , ["_values", [], [[]]]
    , ["_callback", _defaultCallback, [{}]]
];

private ["_i"];

private _count = count _values;

private _retval = _start;

for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do {
    _retval = [_retval, _values select _i, _i] call _callback;
};

_retval
