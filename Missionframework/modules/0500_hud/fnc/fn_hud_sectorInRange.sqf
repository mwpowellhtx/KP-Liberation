#include "script_component.hpp"

// ...

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_bravoMarker), "", [""]]
    , [Q(_range), KPLIB_param_sectorActRange, [0]]
];

if (_bravoMarker isEqualTo "") exitWith {
    false;
};

// Defer to the core calculation
[_player, markerPos _bravoMarker, _range] call MFUNC(_inRange);
