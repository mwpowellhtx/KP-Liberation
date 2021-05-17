/*
    KPLIB_fnc_namespace_onPostInit

    File: fn_namespace_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 16:03:08
    Last Update: 2021-03-05 16:03:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No
*/

if (!isServer) exitWith {true};

[format ["[fn_namespace_onPostInit] Initializing..."], "POST] [NAMESPACE", true] call KPLIB_fnc_common_log;

[format ["[fn_namespace_onPostInit] Initialized"], "POST] [NAMESPACE", true] call KPLIB_fnc_common_log;

true;
