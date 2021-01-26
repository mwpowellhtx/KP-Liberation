/*
    KPLIB_fnc_linq_last

    File: fn_linq_last.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 13:48:56
    Last Update: 2021-01-26 13:48:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Provides a LINQ style Last or LastOrDefault function.

    Parameter(s):
        _values - The array of values [ARRAY, default: []]
        _predicate - The predicate to invoke for each of the elements [CODE, default: {}]
            - as a predicate, should return a Boolean for evaluation
            - receives the arguments: [_x, _i], where _x is the element
        _default - A default value that is returned when an element could not be identified [ANY, default: nil]
        _includeIndex - whether to include the index _i at the predicated element [BOOL, default: false]

    Returns:
        Returns the Last element or _default if no element can be identified.
        Optionally includes the index _i at the predicated element.

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.last
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.lastordefault
*/

// TODO: TBD: ditto error handling for now...

private _defaultPredicate = {true};

params [
    ["_values", [], [[]]]
    , ["_predicate", _defaultPredicate, [{}]]
    , ["_default", nil]
    , ["_includeIndex", false, [false]]
];

private ["_i", "_retval"];

private _count = count _values;

for [{_i = _count - 1}, {_i >= 0 && isNil "_retval"}, {_i = _i - 1}] do {
    if ([_values select _i, _i] call _predicate) then {
        _retval = if (_includeIndex) then {
            [_values select _i, _i];
        } else {
            _values select _i;
        };
    };
};

if (isNil "_retval") exitWith {
    if (_includeIndex) then {
        [_default, -1];
    } else {
        _default;
    };
};

_retval
