/*
    KPLIB_fnc_linq_roll

    File: fn_linq_roll.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 21:09:29
    Last Update: 2021-04-28 11:01:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        The number of SIDES rolled TIMES times, optionally SUM.

    Parameter(s):
        _sides - number of sides to support [SCALAR, default: 6]
        _times - number of times to roll [SCALAR, default: 1]
        _sum - whether to sum the roll [BOOL, default: true]
        _offset - added to the SUM of all rolls [SCALAR, default: 0]

    Returns:
        The result the rolls, either summarized or the individual rolls [SCALAR|ARRAY]
 */

params [
    ["_sides", 6, [0]]
    , ["_times", 1, [0]]
    , ["_sum", true, [true]]
    , ["_offset", 0, [0]]
];

private _rolls = [];

_rolls resize _times;

_rolls = _rolls apply { floor (_sides * random 1) + 1; };

if (_sum) exitWith {
    private _retval = [_rolls] call KPLIB_fnc_linq_sum;
    _retval + _offset;
};

_rolls;
