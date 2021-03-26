#include "script_component.hpp"

// ...

params [
    [Q(_pos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_side), KPLIB_preset_sideF, [KPLIB_preset_sideF]]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

private _units = nearestObjects [_pos, [Q(CAManBase)], _range];

// Tally those UNITS whose are FRIENDLY
_units select {
    !isPlayer x
        && side _x == _side;
};
