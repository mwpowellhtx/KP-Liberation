/*
    KPLIB_fnc_productionCO_onPreInit

    File: fn_productionCO_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 07:13:16
    Last Update: 2021-03-17 07:13:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module pre initialization phase callback.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/CfgMarkers
        https://www.w3schools.com/colors/colors_picker.asp
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
*/

if (isServer) then {
    ["[fn_productionCO_onPreInit] Initializing...", "PRE] [PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

KPLIB_productionCO_requestAddCapability                         = "KPLIB_productionCO_requestAddCapability";
KPLIB_productionCO_requestChangeQueue                           = "KPLIB_productionCO_requestChangeQueue";


if (isServer) then {
    // Server side init

    // TODO: TBD: refactor these to proper CBA settings eventually...
    KPLIB_param_productionCO_debug                              = false;
    KPLIB_param_productionCO_request_debug                      = false;

    KPLIB_param_productionCO_calculators_debug                  = false;

    KPLIB_param_productionCO_onAddCap_debug                     = false;
    KPLIB_param_productionCO_onAddCapEntering_debug             = false;
    KPLIB_param_productionCO_onRequestAddCap_debug              = false;

    KPLIB_param_productionCO_onChangeQueue_debug                = false;
    KPLIB_param_productionCO_onChangeQueueEntering_debug        = false;
    KPLIB_param_productionCO_onRequestChangeQueue_debug         = false;
 
    KPLIB_param_productionCO_onRequest_debug                    = false;

    KPLIB_param_productionCO_makeCapDebit_debug                 = false;
    KPLIB_param_productionCO_tryDebitCap_debug                  = false;
    KPLIB_param_productionCO_getCapNotificationKey_debug        = false;

    // Arrange the enumerated add sector capability status codes
    KPLIB_productionCO_addCap_success                           =  0;
    KPLIB_productionCO_addCap_exists                            = -1;
    KPLIB_productionCO_addCap_elementNotFound                   = -2;
    KPLIB_productionCO_addCap_insufficientSumFob                = -3;
    KPLIB_productionCO_addCap_insufficientSumSector             = -4;
    KPLIB_productionCO_addCap_invalid                           = -9;
};


// TODO: TBD: lays any ground work, client or server, required to support the module
if (hasInterface) then {

};

if (isServer) then {
    ["[fn_productionCO_onPreInit] Initialized", "PRE] [PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

true
