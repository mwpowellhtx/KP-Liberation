#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onPostInit

    File: fn_productionMgr_onPostInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module post initialization phase callback.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_onPostInit] Initializing...", "POST] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    ["KPLIB_productionMgr_onRequestProduction", {

        private _debug = [] call KPLIB_fnc_productionMgr_debug;

        if (_debug) then {
            ["[KPLIB_productionMgr_onRequestProduction::callback] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
        };

        params [
            ["_cid", -1, [0]]
        ];

        if (_cid <= 0) exitWith {

            if (_debug) then {
                ["[KPLIB_productionMgr_onRequestProduction::callback] Exiting", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
            };

            [];
        };

        private _production = KPLIB_production select {(_x#0#0) in KPLIB_sectors_blufor};

        ["KPLIB_productionMgr_onProductionResponse", [_production], _cid] call CBA_fnc_ownerEvent;

        if (_debug) then {
            [format ["[KPLIB_productionMgr_onRequestProduction::callback] Finished: [_cid]: %1", str [_cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
        };

    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // Player section
    [] call KPLIB_fnc_productionMgr_setupPlayerMenu;
};

if (_debug) then {
    ["[fn_productionMgr_onPostInit] Initialized", "POST] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true
