/*
    KPLIB_fnc_core_onPostInit

    File: fn_core_onPostInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2017-08-31
    Last Update: 2021-05-23 12:29:28
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

private _debug = true;

if (isServer) then {
    ["[fn_core_onPostInit] Initializing...", "POST] [CORE", true] call KPLIB_fnc_common_log;
};

// Initialize BIS Revive
[] call KPLIB_fnc_core_reviveInit;

// Server section (dedicated and player hosted)
if (isServer) then {
    [] call KPLIB_fnc_core_spawnStartVeh;
    [] call KPLIB_fnc_core_spawnPotato;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section

    if (_debug) then {
        ["[fn_core_onPostInit] Starting player proximity watch", "POST] [CORE", true] call KPLIB_fnc_common_log;
    };

    [
        { KPLIB_campaignRunning; }
        , { _this call KPLIB_fnc_core_onUpdatePlayerProximity; }
        , []
    ] call CBA_fnc_waitUntilAndExecute;
};

if (isServer) then {
    ["[fn_core_onPostInit] Initialized", "POST] [CORE", true] call KPLIB_fnc_common_log;
};

true;
