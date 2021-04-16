#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_addStrength

    File: fn_enemy_addStrength.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-02-24
    Last Update: 2021-04-03 19:59:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds a given delta to the enemy strength.

    Parameter(s):
        _delta - a positive or negative change [SCALAR, default: 0]

    Returns:
        The function has finished [BOOL]
 */

private _debug = KPLIB_param_enemyDebug;

waitUntil {
    !isNil QMVAR(_strength)
};

// TODO: TBD: the commander logic FSM will need a serious review as well...
params [
    [Q(_delta), 0, [0]]
];

// // // TODO: TBD: we do not 
// // Exit, if not enough strength available
// if (_amount < 0 && _amount > KPLIB_enemy_strength) exitWith {false};

[
    MVAR(_strength)
    , MPARAM(_maxStrength)
] params [
    Q(_oldStrength)
    , Q(_maxStrength)
];

// Ensures that we have appropriate boundaries enforced, MIN the max and MAX the min
private _newStrength = 0 max ((_oldStrength + _delta) min _maxStrength);

if (_debug) then {
    [format ["[fn_enemy_addStrength] Enemy strength: [_delta, _oldStrength, _newStrength, _maxStrength]: %1"
        , str [_delta, _oldStrength, _newStrength, _maxStrength]], "ENEMY"] call KPLIB_fnc_common_log;
};

MVAR(_strength) = _newStrength;

// // // TODO: TBD: and a similar story to AWARENESS, no other reference made except server side
// // TODO: TBD: why is this one "public" (?) for HUD purposes? if so, we do not need it...
// publicVariable "KPLIB_enemy_strength";

true;
