/*
    KPLIB_fnc_productionMgr_onPreInit

    File: fn_productionMgr_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:59:43
    Last Update: 2021-02-06 12:59:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Module pre initialization phase callback.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {
    ["[fn_productionMgr_onPreInit] Initializing...", "PRE] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (isServer) then {

    /* Keep track of the known client owners with open production manager dialogs
     * We will use this in order to post updates to their respective client UI. */

    KPLIB_productionMgr_clientOwners = [];
};

// TODO: TBD: lays any ground work, client or server, required to support the module
if (hasInterface) then {
    KPLIB_productionMgr_resourceIndexes = [0, 1, 2];

    KPLIB_productionMgr_resourceImages = [
        "res\ui_supplies.paa"
        , "res\ui_ammo.paa"
        , "res\ui_fuel.paa"
    ];

    KPLIB_productionMgr_capabilityKeys = [
        "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY"
        , "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO"
        , "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL"
    ];

    KPLIB_productionMgr_boolMap = [
        [true, "yes"]
        , [false, "no"]
    ];

    // Not quite 'empty' but it is a known default state
    KPLIB_productionMgr_productionElem_default = +[
        ["", ""]
        , KPLIB_timers_default
        , [[false, false, false], [0, 0, 0], []]
    ];
};

if (isServer) then {
    ["[fn_productionMgr_onPreInit] Initialized", "PRE] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true
