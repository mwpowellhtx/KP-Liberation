/*
    KPLIB_fnc_uuid_verify

    File: fn_uuid_verify.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-26 12:45:14
    Last Update: 2021-01-26 12:45:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether _candidate can in fact be considered a UUID.

    Parameters:
        _candidate - The candidate array under consideration [ARRAY, default: []]

    Returns:
        Whether _candidate can be considered a UUID.

    Reference:
        https://en.wikipedia.org/wiki/Universally_unique_identifier
*/

params [
    ["_candidate", [], [[]]]
];

// We can rule out based on length.
if (count _candidate != 32) exitWith {false};

// Then we need to verify each character in the candidate against the character set.
private _min = 0;
private _max = 15;

[
    true
    , (toLower _candidate) splitString ""
    , {
        params [
            ["_g", false, [false]]
            , ["_nibble", 0, [0]]
        ];
         _g
         && _nibble >= _min
         && _nibble <= _max;
    }
] call KPLIB_fnc_linq_aggregate;
