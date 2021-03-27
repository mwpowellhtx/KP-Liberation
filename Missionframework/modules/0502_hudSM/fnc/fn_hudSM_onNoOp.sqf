#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onNoOp_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_stateOrTransition), "", [""]]
];

if (_debug) then {
    [format ["[fn_hudSM_onNoOp] No-op: [isNull _player, _stateOrTransition]: %1"
        , str [isNull _player, _stateOrTransition]], "HUDSM", true] call KPLIB_fnc_common_log;
};

true;
