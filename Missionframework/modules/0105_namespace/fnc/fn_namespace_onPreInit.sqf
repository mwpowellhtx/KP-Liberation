/*
    KPLIB_fnc_namespace_onPreInit

    File: fn_namespace_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 16:03:49
    Last Update: 2021-03-05 16:03:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes
*/

if (!isServer) exitWith {
    true;
};

[format ["[fn_namespace_onPreInit] Initializing..."], "PRE] [NAMESPACE", true] call KPLIB_fnc_common_log;

if (isServer) then {

    KPLIB_namespace_changed = "KPLIB_namespace_changed";

    KPLIB_param_namespace_setVars_debug = false;
};

[format ["[fn_namespace_onPreInit] Initialized"], "PRE] [NAMESPACE", true] call KPLIB_fnc_common_log;

true;
