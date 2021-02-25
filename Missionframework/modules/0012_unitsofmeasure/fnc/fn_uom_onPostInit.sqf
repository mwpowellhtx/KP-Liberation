/*
    KPLIB_fnc_uom_onPostInit

    File: fn_uom_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 08:18:23
    Last Update: 2021-02-25 08:18:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameter(s):

    Returns:
 */

if (isServer) then {
    ["[fn_uom_onPostInit] Initializing...", "POST] [UNITSOFMEASURE", true] call KPLIB_fnc_common_log;
};


/*
    ===== Module Initialization =====
 */

if (isServer) then {
    // Server section (dedicated and player hosted)
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_uom_onPostInit] Initialized", "POST] [UNITSOFMEASURE", true] call KPLIB_fnc_common_log;
};

true;
