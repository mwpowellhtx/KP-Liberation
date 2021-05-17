#include "script_component.hpp"
/*
    KPLIB_fnc_hud_inRange

    File: fn_hud_inRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the PLAYER is in range of the BRAVO position.

    Parameters:
        _player - the player in the question [OBJECT, default: objNull]
        _bravoPos - a 3D position [ARRAY, default: KPLIB_zeroPos]
        _range - the range in the question [SCALAR, default: KPLIB_param_fobRange]

    Returns:
        Whether the PLAYER is in range of the BRAVO position.
 */

// TODO: TBD: factoring on this one could possibly be better, seems more generic than just HUD
params [
    [Q(_player), objNull, [objNull]]
    , [Q(_bravoPos), +KPLIB_zeroPos, [[]], 3]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

[
    isNull _player
    , _bravoPos isEqualTo KPLIB_zeroPos
] params [
    Q(_playerNull)
    , Q(_bravoZero)
];

// Rule out some obvious misnomers
if (_playerNull || _bravoZero || _range <= 0) exitWith {
    false;
};

((getPos _player) distance2D _bravoPos) <= _range;
