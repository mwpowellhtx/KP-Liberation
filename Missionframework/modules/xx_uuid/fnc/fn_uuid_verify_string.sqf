/*
    KPLIB_fnc_uuid_verify_string

    File: fn_uuid_verify_string.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 12:28:20
    Last Update: 2021-01-26 12:28:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether _candidate can in fact be considered a UUID.

    Parameters:
        _candidate - The candidate string under consideration [STRING, default: ""]

    Returns:
        Whether _candidate can be considered a UUID.

    Reference:
        https://en.wikipedia.org/wiki/Universally_unique_identifier
*/

params [
    ["_candidate", "", [""]]
];

// We can rule out based on length.
if (count _candidate != 32) exitWith {false};

// Then we need to verify each character in the candidate against the character set.
private _cs = "0123456789abcdef" splitString "";

[
    true
    , (toLower _candidate) splitString ""
    , {
        params [
            ["_g", false, [false]]
            , ["_ch", "", [""]]
        ];
         _g
         && _ch in _cs;
    }
] call KPLIB_fnc_linq_aggregate;
