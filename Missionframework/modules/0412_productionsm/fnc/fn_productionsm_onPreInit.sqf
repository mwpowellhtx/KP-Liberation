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

if (isServer) then {

    // TODO: TBD: establish CBA settings for the param bits...
    KPLIB_param_productionsm_publishPeriodSeconds = 3;
    KPLIB_param_productionsm_debug = true;

    KPLIB_productionsm_obj = locationNull;
    KPLIB_productionsm_configClassNameDefault = "KPLIB_productionStatemachine";

    ///* Nil, nothing was last produced, or -1. We use this value to indicate when scheduling,
    // * etc, ought to occur with passes through the production statemachine. */
    //KPLIB_productionsm_producing_nil = -1;

    //// TODO: TBD: how much of this we will need...
    //// TODO: TBD: also, may want to keep track of the old version of the queue...
    //// TODO: TBD: and just let statemachine do the notification...
    //KPLIB_producingStatemachine_queueChanged_nil = 0;
    //KPLIB_producingStatemachine_queueChanged_add = 1;
    //KPLIB_producingStatemachine_queueChanged_del = 2;
    //KPLIB_producingStatemachine_queueChanged_ord = 3;

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
