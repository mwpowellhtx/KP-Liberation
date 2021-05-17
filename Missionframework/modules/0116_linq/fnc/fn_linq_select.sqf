/*
    KPLIB_fnc_linq_select

    File: fn_linq_select.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 16:30:32
    Last Update: 2021-02-05 16:30:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Provides a LINQ style '.Select(...)', which operates similar to  an SQF 'apply' invocation.
        In addition to the base '_element' under consideration, we also provide its '_i' index for
        caller evaluation purposes.

    Parameter(s):
        _values - The array of values [ARRAY, default: []]
        _transform - a transform operator invoked on each of the '_values' elements [CODE, default: {_this#0}]
            - receives the arguments: ['_x', '_i'], where '_x' is the element
        _includeIndex -

    Returns:
        The transformed elements for each of the '_values'.

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.select
*/

// TODO: TBD: ditto error handling for now...

params [
    ["_values", [], [[]]]
    , ["_selector", { (_this#0); }, [{}]]
    , ["_includeIndex", true, [true]]
];

private ["_i"];

private _count = count _values;
private _retval = [];

for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do {

    private _element = _values select _i;

    private _selectorArgs = if (_includeIndex) then {[_element, _i]} else {[_element]};

    private _selected = _selectorArgs call _selector;

    _retval pushBack _selected;
};

_retval
