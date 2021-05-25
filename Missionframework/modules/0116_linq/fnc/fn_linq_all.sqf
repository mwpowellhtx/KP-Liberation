/*
    KPLIB_fnc_linq_all

    File: fn_linq_all.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-21 12:53:25
    Last Update: 2021-05-21 12:53:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether ALL elements in the array. Elements may also be PREDICATED.

    Parameter(s):
        _values - The array of VALUES [ARRAY, default: []]
        _predicate - an optional CODE predicate [CODE, default: _defaultPredicate]
            - receives the arguments: [_x, _i], where _x is the element

    Returns:
        Returns whether ALL elements in the VALUES, optionally PREDICATED [BOOL]

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.all
 */

private _defaultPredicate = { (_x#0); };

params [
    ["_values", [], [[]]]
    , ["_predicate", _defaultPredicate, [{}]]
];

private _i = -1;

private _count = ({ _i = _i + 1; [_x, _i] call _predicate; } count _values);

_count == count _values;
