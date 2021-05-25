/*
    KPLIB_fnc_linq_any

    File: fn_linq_any.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-21 12:43:56
    Last Update: 2021-05-21 12:43:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether there are ANY elements in the array. Elements may also be PREDICATED.

    Parameter(s):
        _values - The array of VALUES [ARRAY, default: []]
        _predicate - an optional CODE predicate [CODE|NIL, default: nil]
            - receives the arguments: [_x, _i], where _x is the element

    Returns:
        Returns whether there are ANY elements in the VALUES, optionally PREDICATED [BOOL]

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.any
 */

params [
    ["_values", [], [[]]]
    , "_predicate"
];

private _count = if (isNil { _predicate; }) then {
    count _values;
} else {
    private _i = -1;
    { _i = _i + 1; [_x, _i] call _predicate; } count _values;
};

_count > 0;
