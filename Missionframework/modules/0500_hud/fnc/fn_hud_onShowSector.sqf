#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/createHashMapFromArray
// https://community.bistudio.com/wiki/deleteAt

private _debug = [
    [
        {MPARAM(_onShowSector_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_hud_onShowSector] Entering: [isNull _player]: %1"
        , str [isNull _player]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: fill in the gap later...
// TODO: TBD: let's get FOB HUD working first then see about this...

if (_debug) then {
    ["[fn_hud_onShowSector] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
