#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_onPreInit

    File: fn_namespace_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 16:03:49
    Last Update: 2021-06-14 16:36:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes
*/

if (isServer) then {
    [format ["[fn_namespace_onPreInit] Initializing..."], "PRE] [NAMESPACE", true] call KPLIB_fnc_common_log;
};

MPARAM(_timerHasElapsed_debug)                  = false;

if (isServer) then {
    MVAR(_changed)                              = QMVAR(_changed);

    MPARAM(_setVar_debug)                       = false;
    MPARAM(_setVars_debug)                      = false;

    MPARAM(_getVar_debug)                       = false;
    MPARAM(_getVars_debug)                      = false;

    MVAR(_debugCallerNames)                     = [];
    // KPLIB_namespace_debugCallerNames pushBack "fn_logisticsCO_onRequestAddOrRemoveLines";
    // KPLIB_namespace_debugCallerNames pushBack "fn_logisticsSM_onAddLines";
    // KPLIB_namespace_debugCallerNames pushBack "fn_logisticsSM_onRemoveLines";
    // KPLIB_namespace_debugCallerNames pushBack "fn_logisticsCO_onRequestTransportBuild";
    // KPLIB_namespace_debugCallerNames pushBack "fn_changeOrders_process";
};

MFUNC(_defaultStatusPredicate)                  = { true; };

if (isServer) then {
    [format ["[fn_namespace_onPreInit] Initialized"], "PRE] [NAMESPACE", true] call KPLIB_fnc_common_log;
};

true;
