#include "script_component.hpp"
/*
    KPLIB_fnc_eden_onPostInit

    File: fn_eden_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 11:20:08
    Last Update: 2021-04-15 11:11:38
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

    KPLIB_sectors_edens = [] call MFUNC(_enumerate);

    {
        if (_debug) then {
            [format ["[fn_eden_onPostInit] Edens: [_i, _eden]: %1", str [_forEachIndex, _x]], "POST] [EDEN", true] call KPLIB_fnc_common_log;
        };
    } forEach KPLIB_sectors_edens;

    // TODO: TBD: we may need to put some timers on any of these things to continually refresh clients with public vars...
    // TODO: TBD: or better yet, events requesting edens when required...
    publicVariable "KPLIB_sectors_edens";

    [Q(KPLIB_updateMarkers)] call CBA_fnc_serverEvent;
};

if (_debug) then {
    ["[fn_eden_onPostInit] Initialized", "POST] [EDEN", true] call KPLIB_fnc_common_log;
};

true;
