/*
    KPLIB_fnc_string_startsWith

    File: fn_string_startsWith.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-26 07:52:01
    Last Update: 2021-03-26 07:52:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether one string STARTSWITH a substring.

    Parameter(s):
        _string - the string in which to find [STRING, default: ""]
        _substring - the substring to find [STRING, default: ""]

    Returns:
        Whether one string STARTSWITH a substring [BOOL]

    Reference:
        https://community.bistudio.com/wiki/find
*/

params [
    ["_string", "", [""]]
    , ["_substring", "", [""]]
    , ["_caseInsensitive", false, [false]]
];

// By definition cannot start with a longer substring
if (count _substring > count _string) exitWith {
    false;
};

// To lower to upper does not matter, we FIND in a CASEINSENSITIVE manner
if (_caseInsensitive) then {
    _string = toLower _string;
    _substring = toLower _substring;
};

(_string find _substring) == 0;
