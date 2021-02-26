/*
    KPLIB_fnc_linq_tupleShapeEquals

    File: fn_linq_tupleShapeEquals.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 16:30:32
    Last Update: 2021-02-05 16:30:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Whereas 'isEqualTypeArray' operates at a shallow level, we really want a relatively
        deep connection.

    Parameter(s):
        _tuple - a tuple array [ARRAY, default: []]
        _template - a template array against which to compare [ARRAY, default: []]

    Returns:
        Whether the '_tuple' and '_template' recursively agree in shape [BOOL]

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://community.bistudio.com/wiki/isEqualTypeArray
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.select
        https://community.bistudio.com/wiki/flatten - does not really work here, either, because we do want to preserve every level of arrays
 */

// params [
//     ["_tuple", [], [[]]]
//     , ["_template", [], [[]]]
// ];

// private _onTypeName = { (typeName _x); };

// [
//     _tuple apply _onTypeName
//     , _template apply _onTypeName
// ] params [
//     "_tupleTypeNames"
//     , "_templateTypeNames"
// ];

// // At surface, they do not agree in 'typeName' ...
// if (!((_tupleTypeNames isEqualTo _templateTypeNames))) exitWith {
//     false;
// };

// // Now do a deeper element-by-element inspection...
// private _onSelectElements = {
//     [
//         (_this#0)
//         , typeName (_this#0)
//         , (_this#1)
//     ];
// };

// private _onFilterSelectedElement = {
//     (_x#1) isEqualTo "ARRAY";
// };

// private _elementsEqual = true;

// private _tupleElements = [_tuple, _onSelectElements] call KPLIB_fnc_linq_select;
// private _templateElements = [_template, _onSelectElements] call KPLIB_fnc_linq_select;

// private _tupleArrayElements = _tupleElements select _onFilterSelectedElement;
// private _templateArrayElements = _templateElements select _onFilterSelectedElement;

// private ["_i"];

// // Continue to inspect the elements as long as each element equals...
// for [{ _i = 0; }, { _elementsEqual && (_i < count _templateArrayElements); }, { _i = _i + 1; }] do {
//     _elementsEqual = [
//             _tupleArrayElements select _i
//             , _templateArrayElements select _i
//         ] call KPLIB_fnc_linq_tupleShapeEquals;
// };

// _elementsEqual;

// TODO: TBD: hmm, thinking A3 does not handle recursion so well...
// TODO: TBD: will leave the function "in" for now, but will probably need to come up with an iterative approach instead...
// TODO: TBD: which might not be so terrible if we leverage LINQ select, zip, etc...
false;
