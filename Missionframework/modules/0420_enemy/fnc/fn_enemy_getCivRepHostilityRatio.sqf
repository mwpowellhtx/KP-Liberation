#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_getCivRepHostilityRatio

    File: fn_enemy_getCivRepHostilityRatio.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-19 08:00:45
    Last Update: 2021-04-29 13:58:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the calculated CIVILIAN REPUTATION RATIO. Filters the raw value
        to {abs (_zed min _this)}, i.e. allowing only the HOSTILE value through.

    Parameter(s):
        NONE

    Returns:
        CIVILIAN REPUTATION in terms of HOSTILITY [SCALAR|ARRAY]
 */

private _debug = MPARAM(_getCivRepHostilityRatio_debug);

private _zed = 0;

private _civRepRatio = [{ abs (_zed min _this); }] call MFUNC(_getCivRepRatio);

_civRepRatio;
