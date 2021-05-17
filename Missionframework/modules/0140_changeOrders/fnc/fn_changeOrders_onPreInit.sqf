/*
    KPLIB_fnc_changeOrders_onPreInit

    File: fn_changeOrders_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 09:34:48
    Last Update: 2021-03-06 09:34:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        NONE

    Returns:
        NONE

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html
 */

if (isServer) then {
    ["[fn_changeOrders_onPreInit] Initializing...", "PRE] [CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */

KPLIB_changeOrders_orders                           = "KPLIB_changeOrders_orders";

KPLIB_changeOrders_onChangeOrder                    = "KPLIB_changeOrders_onChangeOrder";
KPLIB_changeOrders_onChangeOrderEntering            = "KPLIB_changeOrders_onChangeOrderEntering";
KPLIB_changeOrders_onChangeOrderComplete            = "KPLIB_changeOrders_onChangeOrderComplete";

if (isServer) then {
    // Server section (dedicated and player hosted)

    KPLIB_param_changeOrders_debug                  = false;

    KPLIB_param_changeOrders_create_debug           = false;

    KPLIB_param_changeOrders_enqueue_debug          = false;
    KPLIB_param_changeOrders_tryDequeue_debug       = false;

    KPLIB_param_changeOrders_insert_debug           = false;

    KPLIB_param_changeOrders_process_debug          = false;
    KPLIB_param_changeOrders_processOne_debug       = false;
    KPLIB_param_changeOrders_processMany_debug      = false;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_changeOrders_onPreInit] Initialized", "PRE] [CHANGEORDERS", true] call KPLIB_fnc_common_log;
};

true;
