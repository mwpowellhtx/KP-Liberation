/*
    KPLIB_fnc_enemy_addStrength

    File: fn_enemy_addStrength.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-02-24
    Last Update: 2019-04-23
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

// TODO: TBD: the commander logic FSM will need a serious review as well...
params [
    ["_delta", 0, [0]]
];

// // // TODO: TBD: we do not 
// // Exit, if not enough strength available
// if (_amount < 0 && _amount > KPLIB_enemy_strength) exitWith {false};

[
    KPLIB_enemy_strength
    , KPLIB_param_enemy_maxStrength
] params [
    "_oldStrength"
    , "_maxStrength"
];

// Ensures that we have appropriate boundaries enforced, MIN the max and MAX the min
private _newStrength = 0 max ((_oldStrength + _delta) min _maxStrength);

if (_debug) then {
    [format ["[fn_enemy_addStrength] Enemy strength: [_delta, _oldStrength, _newStrength, _maxStrength]: %1"
        , str [_delta, _oldStrength, _newStrength, _maxStrength]], "ENEMY"] call KPLIB_fnc_common_log;
};

KPLIB_enemy_strength = _newStrength;

// TODO: TBD: why is this one "public" (?) for HUD purposes? if so, we do not need it...
publicVariable "KPLIB_enemy_strength";

true;
