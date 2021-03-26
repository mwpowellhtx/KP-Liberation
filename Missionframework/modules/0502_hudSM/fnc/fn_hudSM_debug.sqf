#include "script_component.hpp"

// ...

params [
    [Q(_additional), [], [[]]]
];

_additional pushBackUnique {MPARAM(_debug)};

[_additional] call KPLIB_fnc_debug_debug;
