/*
    KPLIB_fnc_linq_selectMany

    File: fn_linq_selectMany.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-23 17:29:22
    Last Update: 2021-03-23 17:29:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Performs a LINQ style 'selectMany' using a form that is closely approximate
        to the index based versions.

    Parameter(s):
        _source - the source of ranges to select over [ARRAY of ARRAYS, default: []]
        _resultSelector - result selector callback [CODE, default: {_this#0}]
        _collectionSelector - optional collection selector, [optional, CODE, default: nil]

    Returns:
        A flattened array over a range of source arrays [ARRAY]

    Remarks:
        parents.selectMany((p, i) => p.Children, (p, c, i, j) => new {p, c})
        SelectMany<TSource,TCollection,TResult>(IEnumerable<TSource>, Func<TSource,Int32,IEnumerable<TCollection>>, Func<TSource,TCollection,TResult>)
        SelectMany<TSource,TResult>(IEnumerable<TSource>, Func<TSource,Int32,IEnumerable<TResult>>)

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.selectMany
 */

params [
    ["_source", [], [[]]]
    , ["_resultSelector", { (_this#0); }, [{}]]
    , "_collectionSelector"
];

private _retval = [];

{
    private _alpha = _x;
    // We do not care quite so much about the index of the SOURCE itself
    private _alphaIndex = _forEachIndex;

    {
        private _a = _x;
        private _i = _forEachIndex;

        if (isNil "_collectionSelector") then {
            // Works on the immediate SOURCE only
            _retval pushBack ([_a, _i, _alphaIndex] call _resultSelector);
        } else {
            // Or on the SOURCE and constituent collections of CHILDREN
            private _bravo = [_a, _i, _alphaIndex] call _collectionSelector;
            {
                private _b = _x;
                private _j = _forEachIndex;
                _retval pushBack ([_a, _b, _i, _j, _alphaIndex] call _resultSelector);
            } forEach _bravo;
        };
    } forEach _alpha;

// Remember "source" is an array of SOURCES
//                                  ^^^^^^^
} forEach _source;

_retval;
