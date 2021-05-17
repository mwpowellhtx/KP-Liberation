/*
    KPLIB_fnc_common_indexToMilitaryAlpha

    File: fn_common_indexToMilitaryAlpha.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Created: 2021-01-25 19:01:29
    Last Update: 2021-01-25 19:01:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the military alphabet sequence corresponding to the index.

    Parameter(s):
        _index - The Index to convert to military alphabet sequence.

    Returns:
        The military alphabet string [STRING]
*/
params [
    ["_index", 0, [0]]
];

if (_index < 0) exitWith {
    // Unable to process negative numbers.
};

private _bits = [];
private _count = count KPLIB_preset_alphabetF;

private _alphaValues = [_index, count KPLIB_preset_alphabetF] call KPLIB_fnc_math_convertDecimalToBaseRadix;

// Such that high order bits are presented first
reverse _alphaValues;

// "Alpha ..." is assumed for lines appearing earlier in the set...
(_alphaValues apply { (KPLIB_preset_alphabetF select _x); }) joinString " ";
