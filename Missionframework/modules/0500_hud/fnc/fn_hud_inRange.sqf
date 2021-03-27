#include "script_component.hpp"

// ...

// TODO: TBD: factoring on this one could possibly be better, seems more generic than just HUD
params [
    [Q(_player), objNull, [objNull]]
    , [Q(_bravoPos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

[
    isNull _player
    , _bravoPos isEqualTo KPLIB_zeroPos
] params [
    Q(_playerNull)
    , Q(_bravoZero)
];

// Rule out some obvious misnomers
if (_playerNull || _bravoZero || _range <= 0) exitWith {
    false;
};

((getPos _player) distance2D _bravoPos) <= _range;
