#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_addStrength

    File: fn_enemy_addStrength.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-02-24
    Last Update: 2021-04-26 12:39:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds the DELTA value to the current ENEMY STRENGTH, bounded by ZERO and the MAX.
        Returns the new value. This is also a save worthy moment.

    Parameter(s):
        _delta - a positive or negative change [SCALAR, default: 0]

    Returns:
        The new ENEMY STRENGTH value [SCALAR]
 */

private _debug = MPARAM(_addStrength_debug);

waitUntil {
    !isNil QMVAR(_strength)
};

params [
    [Q(_delta), 0, [0]]
];

// Sets the STRENGTH bounded by ZERO and the MAX
MVAR(_strength) = 0 max ((MVAR(_strength) + _delta) min MPARAM(_maxStrength));

[] spawn KPLIB_fnc_init_save;

MVAR(_strength);
