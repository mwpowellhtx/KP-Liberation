#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_onPostInit

    File: fn_enemy_onPostInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-04-05 15:48:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitUntilAndExecute-sqf.html
 */

if (isServer) then {
    ["[fn_enemy_onPostInit] Initializing...", "POST] [ENEMY", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)

    // Start strength increase events
    [] call MFUNC(_strengthInc);

    [
        { missionNamespace getVariable [Q(KPLIB_campaignRunning), false]; }
        , MFUNC(_onUpdateDisposition)
        , []
        , MPARAM(_updateDispositionPeriod)
        , { /* no-op */ }
    ] call CBA_fnc_waitUntilAndExecute;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_enemy_onPostInit] Initialized", "POST] [ENEMY", true] call KPLIB_fnc_common_log;
};

true;
