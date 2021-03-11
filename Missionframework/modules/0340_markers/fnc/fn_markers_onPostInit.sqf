/*
    KPLIB_fnc_markers_onPostInit

    File: fn_markers_onPostInit.sqf
    Author: Michael W. Powell
    Created: 2021-03-11 10:37:18
    Last Update: 2021-03-11 10:37:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        Module initialization finished [BOOL]
*/

if (isServer) then {
    ["[fn_markers_onPostInit] Initializing...", "POST] [MARKERS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_markers_onPostInit] Initialized", "POST] [MARKERS", true] call KPLIB_fnc_common_log;
};

true;
