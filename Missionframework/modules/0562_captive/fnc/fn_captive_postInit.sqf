/*
    KPLIB_fnc_captive_postInit

    File: fn_captive_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-10
    Last Update: 2021-06-14 17:19:55
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
    ["Module initializing...", "POST] [CAPTIVE", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section (dedicated and player hosted)
    [{ KPLIB_campaignRunning; }, { _this call KPLIB_fnc_captive_onWatchCaptives; }, []] call CBA_fnc_waitUntilAndExecute;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["Module initialized", "POST] [CAPTIVE", true] call KPLIB_fnc_common_log;
};

true;
