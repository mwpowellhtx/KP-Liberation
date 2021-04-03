#include "script_component.hpp"

// ...

params [
    [Q(_pos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_side), KPLIB_preset_sideF, [KPLIB_preset_sideF]]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

private _units = [_pos, _side, _range] call MFUNC(_getUnits);

// Selecting around PLAYER in this instance
_units select { !isPlayer _x; };
