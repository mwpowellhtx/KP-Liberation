/*
    KPLIB_fnc_logisticsMgr_onPreInit

    File: fn_logisticsMgr_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 11:58:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE
 */

if (isServer) then {
    ["[fn_logisticsMgr_onPreInit] Initializing...", "PRE] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
*/


/*
    ----- Module Initialization -----
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
    ["[fn_logisticsMgr_onPreInit] Initialized", "PRE] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
