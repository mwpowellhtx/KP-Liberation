/*
    KPLIB_fnc_linq_between

    File: fn_linq_between.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-15 00:08:29
    Last Update: 2021-03-15 00:08:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Provides a LINQ style BETWEEN operator. Comparison is always what should be
        considered: '[MIN, MAX] call _predicate', and what should be returned is
        qualitatively, LT: (negative), EQ: 0, GT: (positive).

    Parameter(s):
        _value - the value being considered [ANY]
        _lower - considered the lower for use by the predicate [ANY]
        _upper - considered the upper for use by the predicate [ANY]
        _predicate - the predicate callback used to evaluate [CODE, default: _defaultPredicate]

    Returns:
        Returns the First element or _default if no element can be identified.
        Optionally includes the index _i at the predicated element.

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
 */

private _defaultPredicate = { (_this#0) - (_this#1); };

params [
    "_value"
    , "_lower"
    , "_upper"
    , ["_predicate", _defaultPredicate, [{}]]
    // TODO: TBD: may do an "inclusive" of the bounds as well
];

[
    [_value, _lower] call _predicate
    , [_value, _upper] call _predicate
] params [
    "_withinLower"
    , "_withinUpper"
];

// This is a bit clearer than: [_lower, _value] ... [_value, _upper]
_withinLower >= 0 && _withinUpper <= 0;
