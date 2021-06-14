#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onPostInit

    File: fn_hudFob_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 17:11:49
    Last Update: 2021-06-14 17:01:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
 */

if (hasInterface || isServer) then {
    ["[fn_hudFob_onPostInit] Initializing...", "POST] [HUDFOB", true] call KPLIB_fnc_common_log;
};

if (hasInterface) then {
    // Client side section

    // Everything happens via DEFAULT OPTIONS HASHMAP and registered CBA local event handlers
    MVAR(_reportUuid)                                   = [[
        [Q(_rscLayerName), QMLAYER(_overlay)]
    ]] call KPLIB_fnc_hud_subscribe;
};

if (hasInterface || isServer) then {
    ["[fn_hudFob_onPostInit] Initialized", "POST] [HUDFOB", true] call KPLIB_fnc_common_log;
};

true;
