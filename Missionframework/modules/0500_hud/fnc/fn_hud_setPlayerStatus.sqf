#include "script_component.hpp"
/*
    KPLIB_fnc_hud_setPlayerStatus

    File: fn_hud_setPlayerStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Conditionally sets the masked bitflags from the target and returns
        with the target in its changed condition.

    Parameters:
        _target - a target SCALAR bitmask, or OBJECT hosting the same
            [SCALAR, OBJECT; default: _standby]
        _mask - a bitflags mask used to set [SCALAR, default: _standby]
        _predicate - the condition used to check prior to fulfilling the request
            [CODE, default: _always]
        _variableName - optional variable name used to lift the bitmask from a target
            OBJECT [STRING, default: KPLIB_hudDispatchSM_standbyStatus]

    Returns:
        The target element in its changed state [SCALAR, OBJECT]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsSet
 */

[
    MSTATUS(_standby)
    , { true; }
] params [
    Q(_standby)
    , Q(_always)
];

params [
    [Q(_target), _standby, [0, objNull]]
    , [Q(_mask), _standby, [0]]
    , [Q(_predicate), _always, [{}]]
    , [Q(_variableName), KPLIB_hudDispatchSM_standbyStatus, [""]]
];

private _onSetStatusRaw = {
    params [
        [Q(_status), _standby, [0]]
        , [Q(_mask), _standby, [0]]
    ];
    [_status, _mask] call BIS_fnc_bitflagsSet;
};

private _onSetStatusPlayer = {
    params [
        [Q(_player), objNull, [objNull]]
        , [Q(_mask), _standby, [0]]
    ];

    private _status = _player getVariable [_variableName, _standby];

    [_player, [
        [_variableName, ([_status, _mask] call _onSetStatusRaw)]
    ]] call KPLIB_fnc_namespace_setVars;

    _player;
};

if ([_target, _mask] call _predicate) then {

    _target = switch (true) do {

        case (_target isEqualType _standby): {
            [_target, _mask] call _onSetStatusRaw;
        };

        case (_target isEqualType objNull): {
            [_target, _mask] call _onSetStatusPlayer;
        };

        default { _target; };
    };
};

_target;
