#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_getCivRepBounded

    File: fn_enemy_getCivRepBounded.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-18 23:52:26
    Last Update: 2021-04-18 23:52:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the CIVILIAN REPUTATION bounded by plus and minus MAXIMUM CIVILIAN REPUTATION.

    Parameter(s):
        NONE

    Returns:
        CIVILIAN REPUTATION bounded by plus and minus MAXIMUM CIVILIAN REPUTATION [SCALAR]
 */

private _debug = MPARAM(_getCivRepBounded_debug);

[
    MVAR(_civRep)
    , MPARAM(_maxCivRep)
] params [
    Q(_civRep)
    , Q(_maxCivRep)
];

-_maxCivRep max (_civRep min _maxCivRep);
