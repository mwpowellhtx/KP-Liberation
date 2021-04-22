#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_deserialize

    File: fn_namespace_deserialize.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-20 12:48:38
    Last Update: 2021-04-20 12:48:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Deserializes an array of VARIABLE NAME and VALUE pairs to a CBA namespace.

    Parameter(s):
        _associativeArray - an associative array of VARIABLE NAME and VALUE pairs
            [ARRAY, default: []]

    Returns:
        A CBA namespace corresponding to the array [LOCATION]
 */

params [
    [Q(_associativeArray), [], [[]]]
];

private _namespace = [] call MFUNC(_create);

{ _namespace setVariable _x; } forEach _associativeArray;

_namespace;
