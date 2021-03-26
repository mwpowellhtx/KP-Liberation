#include "script_component.hpp"

// ...

params [
    [Q(_target), objNull, [objNull]]
    , [Q(_fobs), +KPLIB_sectors_fobs, [[]]]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

[
    // If it can be persisted, then it should be counted
    [_target] call KPLIB_fnc_persistence_whereAssetMayBeFobPersistent
    , [_target, _fobs, _range] call KPLIB_fnc_persistence_whereAssetShouldBeFobPersistent
] params [
    Q(_may)
    , Q(_should)
];

_may && _should;
