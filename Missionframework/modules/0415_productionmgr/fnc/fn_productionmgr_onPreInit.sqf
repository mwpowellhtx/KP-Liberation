/*
    KPLIB_fnc_productionMgr_onPreInit

    File: fn_productionMgr_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:59:43
    Last Update: 2021-02-06 12:59:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module pre initialization phase callback.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {
    ["[fn_productionMgr_onPreInit] Initializing...", "PRE] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: lays any ground work, client or server, required to support the module

if (isServer) then {
    ["[fn_productionMgr_onPreInit] Initialized", "PRE] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true
