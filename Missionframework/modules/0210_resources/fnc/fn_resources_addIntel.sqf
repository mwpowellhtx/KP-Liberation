#include "script_component.hpp"
/*
    KPLIB_fnc_resources_addIntel

    File: fn_resources_addIntel.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-16
    Last Update: 2021-04-26 12:09:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds the delta to the intel value and returns the new value. Delta may be positive
        or negative.

    Parameter(s):
        _delta - quantity of intel to add [SCALAR, default: 0]

    Returns:
        The new intel value [BOOL]
 */

params [
    ["_delta", 0, [0]]
];

// Sets the new intel resource value bounded by ZERO and the MAX
MVAR(_intel) =  0 max ((MVAR(_intel) + _delta) min MPARAM(_maxIntel));

// // TODO: TBD: we do not need to publish anything here
// publicVariable "KPLIB_resources_intel";

true;
