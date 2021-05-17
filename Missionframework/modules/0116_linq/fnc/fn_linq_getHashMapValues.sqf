/*
    KPLIB_fnc_linq_getHashMapValues

    File: fn_linq_getHashMapValues.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-19 16:21:34
    Last Update: 2021-04-19 16:21:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Provides a LINQ HASHMAP support to get just the values. Order is not guaranteed.
        Not dissimilar to the manner in which IDictionary obtains its Values property.

    Parameter(s):
        _targetHashMap - a target HASHMAP which values to return [HASHMAP, default: emptyHashMap]

    Returns:
        The values for the target HASHMAP [ARRAY]

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.idictionary-2.values
 */

params [
    ["_targetHashMap", emptyHashMap, [emptyHashMap]]
];

private _values = [];

// Sadly, apply does not work like this
{ _values pushBack _y; } forEach _targetHashMap;

_values;
