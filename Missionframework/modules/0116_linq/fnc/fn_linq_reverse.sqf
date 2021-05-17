/*
    KPLIB_fnc_linq_reverse

    File: fn_linq_reverse.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 17:52:57
    Last Update: 2021-02-22 17:53:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Provides a LINQ style Reverse function, without affecting the given '_values'.
        Unlike the 'reverse' primitive, does not effect the source '_values' array.

    Parameter(s):
        _values - The array of values to reverse [ARRAY, default: []]

    Returns:
        Returns a reversed copy of the '_values' array [ARRAY]

    Reference:
        https://en.wikipedia.org/wiki/Language_Integrated_Query
        https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.reverse
        https://community.bistudio.com/wiki/reverse
*/

params [
    ["_values", [], [[]]]
];

// Key...
private _retval = +_values;

// Also key, pretty straightforward...
reverse _retval;

_retval;
