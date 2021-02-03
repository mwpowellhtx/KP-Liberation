/*
    KPLIB_fnc_eden_getNameAtIndex

    File: fn_eden_getNameAtIndex.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:28:54
    Last Update: 2021-01-28 12:28:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameters:
        _i - an optional index useful when formatting the name [NUMBER, defaults: -1]
        _name - The base name [STRING, default: "startbase"]
            i.e. KPLIB_eden_[_name]
            i.e. KPLIB_eden_[_name][_[_i]], where _i is a zero based index

    Returns:
        The enumerated start bases
*/

private _startbase = "startbase";

params [
    ["_i", -1, [0]]
    , ["_name", _startbase, [""]]
];

if (_i < 0) exitWith {
    format ["KPLIB_eden_%1", _name];
};

format ["KPLIB_eden_%1_%2", _name, str _i];
