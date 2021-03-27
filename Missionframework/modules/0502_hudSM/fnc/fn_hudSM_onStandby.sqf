#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onStandby_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

[_player, MVAR(_overlayTimer), MPARAM(_overlayTimerPeriod)] call KPLIB_fnc_hud_onRefreshPlayerTimer;

true;
