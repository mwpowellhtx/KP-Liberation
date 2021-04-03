#include "script_component.hpp"

// ...

params [
    [Q(_pos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_side), KPLIB_preset_sideF, [KPLIB_preset_sideF]]
    , [Q(_range), KPLIB_param_sectorCapRange, [0]]
    // Key:       ^^^^^^^^^^^^^^^^^^^^^^^^^^
];

private _units = [_pos, _side, _range] call MFUNC(_getUnits);

_units;
