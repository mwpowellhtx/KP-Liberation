#include "script_component.hpp"
/*
    KPLIB_fnc_aidWoundedCivs_onPreInit

    File: fn_aidWoundedCivs_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 15:04:49
    Last Update: 2021-04-26 15:04:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

if (isServer) then {
    ["[fn_aidWoundedCivs_onPreInit] Initializing...", "PRE] [AIDWOUNDEDCIVS", true] call KPLIB_fnc_common_log;
};

// Call to setup some settings
[] call MFUNC(_settings);

if (isServer) then {
    // We will present a simply icon, scaled smaller, with appropriate civilian colors (i.e. purple)
    MPRESET(_woundedIcon)                   = "\a3\ui_f\data\map\mapcontrol\hospital_ca.paa";

    // Register event handlers that respond accordingly
    [KPLIB_sectors_captured, { _this call MFUNC(_onSectorCaptured); }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["[fn_aidWoundedCivs_onPreInit] Initialized", "PRE] [AIDWOUNDEDCIVS", true] call KPLIB_fnc_common_log;
};

true;
