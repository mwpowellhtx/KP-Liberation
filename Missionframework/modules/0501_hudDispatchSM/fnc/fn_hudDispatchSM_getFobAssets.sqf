#include "script_component.hpp"

// ...

params [
    [Q(_fob), [], [[]]]
    , [Q(_assetType), Q(Plane), [""]]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

_fob params [
    Q(_0)
    , Q(_1)
    , Q(_2)
    , Q(_3)
    , Q(_pos)
];

private _assets = nearestObjects [_pos, [_assetType], _range];

private _retval = _assets select { [_x] call MFUNC(_whereShouldBeCounted); };

_retval;
