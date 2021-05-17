/*
    KPLIB_fnc_uuid_create

    File: fn_uuid_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-25 22:18:46
    Last Update: 2021-01-25 22:18:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a UUID array of 32 elements ranging from {0-15}, respectively.
        This corresponds to the hexadecimal oriented nibbles contributing to a UUID value.

    Parameters:
        NONE

    Returns:
        A UUID array of 32 elements ranging from {0-15}, respectively.

    Reference:
        https://en.wikipedia.org/wiki/Universally_unique_identifier
*/

private _word = {floor random [0, 0x10000 / 2, 0x10000]};

private _words = [
    [] call _word
    , [] call _word
    , [] call _word
    , [] call _word
    , [] call _word
    , [] call _word
    , [] call _word
    , [] call _word
];

private _hexBase = 16;

private _hex = [
    []
    , _words
    , {
        params ["_g", "_x"];
        _g + ([_x, _hexBase] call KPLIB_fnc_math_convertDecimalToBaseRadix)
    }
] call KPLIB_fnc_linq_aggregate;

_hex
