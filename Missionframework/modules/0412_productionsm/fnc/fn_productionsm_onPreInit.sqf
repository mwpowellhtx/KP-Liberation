/*
    KPLIB_fnc_productionsm_onPreInit

    File: fn_productionsm_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:55:30
    Last Update: 2021-02-18 20:55:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs module pre initialization activites.

    Parameter(s):
        NONE

    Returns:
        Module event handler finished [BOOL]
 */

if (isServer) then {
    ["[fn_productionsm_onPreInit] Initializing...", "PRE] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[] call KPLIB_fnc_productionsm_settings;

if (isServer) then {

    KPLIB_param_productionsm_debug = false;
    KPLIB_param_productionsm_create_debug = false;
    KPLIB_param_productionsm_rebaser_debug = false;
    KPLIB_param_productionsm_rebaserEntered_debug = false;
    KPLIB_param_productionsm_publisher_debug = false;
    KPLIB_param_productionsm_publisherEntered_debug = false;
    KPLIB_param_productionsm_publisherCore_debug = false;
    KPLIB_param_productionsm_publisherLeaving_debug = false;
    KPLIB_param_productionsm_scheduler_debug = false;
    KPLIB_param_productionsm_producer_debug = false;
    KPLIB_param_productionsm_producerEntered_debug = false;
    KPLIB_param_productionsm_tryProducingResource_debug = false;
    KPLIB_param_productionsm_onProducingResourceRaised_debug = false;
    KPLIB_param_productionsm_timer_debug = false;
    KPLIB_param_productionsm_conditions_debug = false;
    KPLIB_param_productionsm_calculators_debug = false;
    KPLIB_param_productionsm_changeOrders_debug = false;
    KPLIB_param_productionsm_nextChangeOrder_debug = false;
    KPLIB_param_productionsm_raise_debug = false;
    KPLIB_param_productionsm_raiseAddCap_debug = false;
    KPLIB_param_productionsm_raiseChangeQueue_debug = false;
    KPLIB_param_productionsm_productionMgr_debug = false;

    KPLIB_productionsm_objSM = locationNull;
    KPLIB_productionsm_configClassNameDefault = "KPLIB_productionsm_statemachine";

    // Arrange the enumerated add sector capability status codes
    KPLIB_productionsm_addCap_success = 0;
    KPLIB_productionsm_addCap_exists = -1;
    KPLIB_productionsm_addCap_elementNotFound = -2;
    KPLIB_productionsm_addCap_insufficientSumFob = -3;
    KPLIB_productionsm_addCap_insufficientSumSector = -4;
};

if (isServer) then {
    ["[fn_productionsm_onPreInit] Initialized", "PRE] [PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
