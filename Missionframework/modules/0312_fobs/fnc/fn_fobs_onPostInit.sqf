#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onPostInit

    File: fn_fobs_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:05:14
    Last Update: 2021-05-17 20:05:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onPostInit_debug);

if (_debug) then {
    ["[fn_fobs_onPostInit] Initializing...", "POST] [FOBS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section

    [Q(KPLIB_updateMarkers), { _this call MFUNC(_onUpdateMarkers); }] call CBA_fnc_addEventHandler;
};

if (_debug) then {
    ["[fn_fobs_onPostInit] Initialized", "POST] [FOBS", true] call KPLIB_fnc_common_log;
};

true;
