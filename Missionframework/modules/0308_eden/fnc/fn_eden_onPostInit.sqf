#include "script_component.hpp"
/*
    KPLIB_fnc_eden_onPostInit

    File: fn_eden_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 11:20:08
    Last Update: 2021-05-20 20:19:38
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
    ["[fn_eden_onPostInit] Initializing...", "POST] [EDEN", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // We are also getting the START BASE MARKER NAMES published
    MVAR(_startbases) = [] call MFUNC(_enumerate);

    if (_debug) then {
        [format ["[fn_eden_onPostInit] Startbases: [KPLIB_sectors_startbases]: %1"
            , str [KPLIB_sectors_startbases]], "POST] [EDEN", true] call KPLIB_fnc_common_log;
    };

    [Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent;
};

if (_debug) then {
    ["[fn_eden_onPostInit] Initialized", "POST] [EDEN", true] call KPLIB_fnc_common_log;
};

true;
