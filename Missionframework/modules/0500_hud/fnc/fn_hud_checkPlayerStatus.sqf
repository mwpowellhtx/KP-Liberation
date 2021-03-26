#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck

private _standby = MSTATUS(_standby);

params [
    [Q(_target), _standby, [0, objNull]]
    , [Q(_mask), _standby, [0]]
];

private _onCheckRaw = {
    params [
        [Q(_status), _standby, [0]]
        , [Q(_mask), _standby, [0]]
    ];
    // Allowing for a zeroed status
    (_mask == _standby && _status == _mask)
        || ([_status, _mask] call BIS_fnc_bitflagsCheck);
};

private _onCheckPlayer = {
    params [
        [Q(_player), objNull, [objNull]]
        , [Q(_mask), _standby, [0]]
    ];
    [_player getVariable [QMVAR(_status), _standby], _mask] call _onCheckRaw;
};

switch (true) do {

    case (_target isEqualType _standby): {
        [_target, _mask] call _onCheckRaw;
    };

    // TODO: TBD: 'player' is an objNull type (?)
    case (_target isEqualType objNull): {
        [_target, _mask] call _onCheckPlayer;
    };

    default { false; };
};
