/*
    KPLIB_fnc_productionCO_onPostInit

    File: fn_productionCO_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 07:15:45
    Last Update: 2021-03-17 07:15:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module post initialization phase callback.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
*/

private _debug = [] call KPLIB_fnc_productionCO_debug;

if (_debug) then {
    ["[fn_productionCO_onPostInit] Initializing...", "POST] [PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server section

    // Client may add capability to a target factory sector
    [KPLIB_productionCO_requestAddCapability, KPLIB_fnc_productionCO_onRequestAddCap] call CBA_fnc_addEventHandler;
    // Client may change the queue via the production manager
    [KPLIB_productionCO_requestChangeQueue, KPLIB_fnc_productionCO_onRequestChangeQueue] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // Player section

    // // TODO: TBD: probably unnecessary, although we may refactor some bits...
    //[] call KPLIB_fnc_productionCO_setupPlayerMenu;
};

if (_debug) then {
    ["[fn_productionCO_onPostInit] Initialized", "POST] [PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

true
