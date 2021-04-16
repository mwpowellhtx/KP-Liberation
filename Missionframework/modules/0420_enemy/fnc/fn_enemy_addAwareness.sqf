#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_addAwareness

    File: fn_enemy_addAwareness.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-04-03 19:58:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Add the delta to enemy awareness.

    Parameter(s):
        _delta - a positive or negative change [SCALAR, default: 0]

    Returns:
        The function has finished [BOOL]
 */

private _debug = KPLIB_param_enemyDebug;

waitUntil {
    !isNil QMVAR(_awareness)
};

// TODO: TBD: the commander logic FSM will need a serious review as well...
params [
    [Q(_delta), 0, [0]]
];

[
    MVAR(_awareness)
    , MPARAM(_maxAwareness)
] params [
    Q(_oldAwareness)
    , Q(_maxAwareness)
];

// With properly bounded values, MIN the max, MAX the min
private _newAwareness = 0 max ((_oldAwareness + _delta) min _maxAwareness);

MVAR(_awareness) = _newAwareness;

// // // TODO: TBD: no other reference is made to AWARENESS except server side
// // TODO: TBD: ditto public variable? if for HUD purposes, then we do not need to...
// publicVariable "KPLIB_enemy_awareness";

true;
