#include "script_component.hpp"
/*
    KPLIB_fnc_hud_inRange

    File: fn_hud_inRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-20 10:25:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the PLAYER is in range of the BRAVO POSITION|OBJECT.

    Parameters:
        _player - the player in the question [OBJECT, default: objNull]
        _bravo - a POSITION or OBJECT about which to gauge [ARRAY|OBJECT, default: KPLIB_zeroPos]
        _range - the range in the question [SCALAR, default: KPLIB_param_fobs_range]

    Returns:
        Whether the PLAYER is in range of the BRAVO POSITION|OBJECT [BOOL]
 */

// TODO: TBD: factoring on this one could possibly be better, seems more generic than just HUD
params [
    [Q(_player), objNull, [objNull]]
    , [Q(_bravo), +KPLIB_zeroPos, [objNull, []]]
    , [Q(_range), KPLIB_param_fobs_range, [0]]
];

if (isNull _player || _range < 0) exitWith { false; };

// When dealing with an array, then it is a position, normalize it
if (_bravo isEqualType []) exitWith {
    _bravo = _bravo call {
        params [
            ["_a", 0, [0]]
            , ["_b", 0, [0]]
            , ["_c", 0, [0]]
        ];
        [_a, _b, _c];
    };
    _player distance2D _bravo <= _range;
};

if (_bravo isEqualType objNull) exitWith {
    !isNull _bravo
        && _player distance2D _bravo <= _range;
};

false;
