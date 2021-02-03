/*
    KPLIB_fnc_uuid_create_string

    File: fn_uuid_create_string.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-25 23:47:37
    Last Update: 2021-01-25 23:47:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a UUID hexadecimal string.

    Parameters:
        NONE

    Returns:
        A UUID hexadecimal string.

    Reference:
        https://en.wikipedia.org/wiki/Universally_unique_identifier
        https://en.wikipedia.org/wiki/Universally_unique_identifier#Format
*/

private _hex = [] call KPLIB_fnc_uuid_create;

private _hexString = "0123456789abcdef";

// Separate the hex bits into the appropriate fields.
//      0          1            2         3
//      01234567 8901 2345 6789 012345678901
//      xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
// i.e. 65087fe5-600a-10a6-1c27-9e659cf35cf7
// Based on an actual in-game generated UUID. Looking sweet!
// Actual output was: "65087fe5600a10a61c279e659cf35cf7"

(_hex apply {_hexString select [_x, 1]}) joinString "";

//// TODO: TBD: we could do that, but maybe we hold off on it unless it is absolutely necessary.
//// TODO: TBD: not least of which for performance reaosns.
//private _fields = [[0, 7], [8, 11], [12, 15], [16, 19], [20, 31]];
