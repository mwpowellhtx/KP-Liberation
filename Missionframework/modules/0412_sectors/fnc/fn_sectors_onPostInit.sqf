#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onPostInit

    File: fn_sectors_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 13:33:51
    Last Update: 2021-06-14 16:51:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_createFromConfig-sqf.html
 */

if (isServer) then {
    ["[fn_sectors_onPostInit] Initializing...", "POST] [SECTORS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)
    [
        { KPLIB_campaignRunning; }
        , { _this call MFUNC(_onUpdateDebugging); }
        , []
    ] call CBA_fnc_waitUntilAndExecute;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_sectors_onPostInit] Initialized", "POST] [SECTORS", true] call KPLIB_fnc_common_log;
};

true;
