#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/BIS_fnc_bitflagsSet

private _always = { true; };
private _standby = MSTATUS(_standby);

params [
    [Q(_target), _standby, [0, objNull]]
    , [Q(_mask), _standby, [0]]
    , [Q(_predicate), _always, [{}]]
    , [Q(_variableName), KPLIB_hudDispatchSM_dispatchStatus, [""]]
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
