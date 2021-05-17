#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_onPostInit

    File: fn_firedrill_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Date: 2021-03-20 16:44:51
    Last Update: 2021-03-20 16:44:55
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
    ["Initializing...", "POST] [FIREDRILL", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init

    [
        [nil, MVAR(_variableNamesToInit)] call PFUNC(_createTemplate)
    ] call PFUNC(_registerOne)
};

if (hasInterface) then {
    // Client side init
};

if (isServer) then {
    ["Initialized", "POST] [FIREDRILL", true] call KPLIB_fnc_common_log;
};

true;
