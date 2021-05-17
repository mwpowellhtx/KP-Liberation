#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_addAwareness

    File: fn_enemies_addAwareness.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-24
    Last Update: 2021-05-17 15:09:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds the DELTA score to the current ENEMY AWARENESS, bounded by ZERO and the MAX
        value. Returns the new value. This is also a save-worthy moment.

    Parameter(s):
        _delta - adds the value to the awareness [SCALAR, default: 0]

    Returns:
        The new ENEMY AWARENESS value [SCALAR]
 */

private _debug = MPARAM(_addAwareness_debug);

waitUntil {
    !isNil QMVAR(_awareness)
};

params [
    [Q(_delta), 0, [0]]
];

if (_delta != 0) then {
    // Set the AWARENESS bounded by the ZERO and the MAX
    MVAR(_awareness) = 0 max ((MVAR(_awareness) + _delta) min MPARAM(_maxAwareness));

    [] spawn KPLIB_fnc_init_save;
};

MVAR(_awareness);
