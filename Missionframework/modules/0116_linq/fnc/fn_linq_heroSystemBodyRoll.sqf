/*
    KPLIB_fnc_linq_heroSystemBodyRoll

    File: fn_linq_heroSystemBodyRoll.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-28 11:03:50
    Last Update: 2021-06-14 16:35:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Rolls for HERO RPG style 'BODY' result. Not used for 'body', obviously, but
        for those times when we want a more qualitative sort of result, and possibly
        with a more limited range of outcomes. i.e. let's say, rolling for number of
        vehicles.

        On a SIX sided die, [1, 1]: 0, [2, 5]: 1, [6, 6]: 2. But, in more general terms,
        we will support any die, and the filter may also be customized. In the default
        case, [1, 1]: 0, [2, (_sides - 1)]: 1, [_sides, _sides]: 2.

        Good hunting!

    Parameter(s):
        _sides - number of sides to support [SCALAR, default: 6]
        _times - number of times to roll [SCALAR, default: 1]
        _sum - whether to summarize the rolls [BOOL, default: true]
        _offset - an offset to add to the summarized rolls [SCALAR, default: 0]
        _filter - filter through which to evaluate the raw die rolls [CODE, default: _heroKillingDamageFilter]

    Returns:
        The total number of 'body' useful by the caller [SCALAR]

    Remarks:
        Inspired by HERO SYSTEM 6ED VOL 2 COMBAT+ADVENTURING NORMAL DAMAGE TABLE p98.
            EACH DIE FOR NORMAL ATTACK|BODY DONE
            1|0 (zero)
            2-5|1
            6|2

    References:
        https://anydice.com/program/1b7de
 */

// Following the default pattern, [1, 1]: 0, [2, _sides - 1]: 1, [_sides, _sides]: 2
private _heroKillingDamageFilter = {
    params [
        ["_value", 0, [0]]
        , ["_sides", 6, [0]]
        , ["_offsets", [-4, 0, 1], [[]], 3]
        , ["_predicate", { (_this#0) < (_this#1) }, [{}]]
    ];
    // TODO: TBD: this algo 'is' literally the result...
    // TODO: TBD: short of getting fancy or cute with the conditions, filtered results, etc...
    private _adjusted = _offsets apply { _sides + _x; };
    private _retval = _adjusted apply { [_value, _x] call _predicate; } findIf { _x; };
    _retval;
};

params [
    ["_sides", 6, [0]]
    , ["_times", 1, [0]]
    , ["_sum", true, [true]]
    , ["_offset", 0, [0]]
    , ["_filter", _heroKillingDamageFilter, [{}]]
];

private _rolls = [];

_rolls resize _times;

// Accounting for valid use cases
if (_sides > 0 && _times > 0) then {
    _rolls = _rolls apply { floor (_sides * random 1) + 1; };
};

private _filtered = _rolls apply { [_x, _sides] call _filter; };

if (_sum) exitWith {
    private _retval = [_filtered] call KPLIB_fnc_linq_sum;
    _retval + _offset;
};

_filtered;
