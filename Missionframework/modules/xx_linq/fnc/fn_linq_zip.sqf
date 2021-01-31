/*
    KPLIB_fnc_linq_zip

    File: fn_linq_zip.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-25 22:43:48
    Last Update: 2021-01-25 22:43:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Given two arrays, zips both of them together in LINQ manner.

    Parameter(s):
        _alpha - The first array (alpha) [ARRAY, default: []]
        _bravo - The second array (bravo) [ARRAY, default: []]
        _callback - The callback applying to both sides [CODE, default: callback which simply yields: [_a, _b]]
            - callbacks are given the following arguments: [_a, _b, _i]
        _withRemaining - Optionally includes any left over remnants of alpha or bravo unable to zip due to size restrictions
            - shape of the result is then: [_retval, _alphaRemnants, _bravoRemnants]
            - in the base case, the result is simply: _retval

    Returns:
        The results after zipping the two arrays together. May optionally include the remnants
        of either alpha or bravo in excess of the common array count.

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.zip
*/

// TODO: TBD: we just want to get a couple of these LINQ style functions in QnD...
// TODO: TBD: will add more in the way of error handling, etc, later...

private _defaultCallback = {
    params ["_a", "_b"];
    [_a, _b];
};

params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
    , ["_callback", _defaultCallback, [{}]]
    , ["_withRemaining", false, [false]]
];

private ["_i"];

private _retval = [];

private _count = (count _alpha) min (count _bravo);

private _remnants = [_alpha, _bravo] apply {
    if (count _x == _count) then {[]} else {
        _x select [_count, count _x - _count]
    };
};

for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do {
    private _zipped = [_alpha select _i, _bravo select _i, _i] call _callback;
    _retval pushBack _zipped;
};

if (_withRemaining) exitWith {[_retval] + _remnants};

_retval;
