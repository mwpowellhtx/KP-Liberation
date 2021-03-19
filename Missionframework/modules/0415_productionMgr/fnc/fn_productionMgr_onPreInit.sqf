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

    References:
        https://community.bistudio.com/wiki/CfgMarkers
        https://www.w3schools.com/colors/colors_picker.asp
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
*/

if (isServer) then {
    ["[fn_productionMgr_onPreInit] Initializing...", "PRE] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Server side init
};

KPLIB_productionMgr_productionStatePublished            = "KPLIB_productionMgr_productionStatePublished";

// TODO: TBD: lays any ground work, client or server, required to support the module
if (hasInterface) then {

    KPLIB_param_productionMgr_debug                                 = false;
    KPLIB_param_productionMgr_btnEnqueue_onButtonClick_debug        = true;
    KPLIB_param_productionMgr_lnbSectors_debug                      = false;
    KPLIB_param_productionMgr_onProductionStatePublished_debug      = false;
    KPLIB_param_productionMgr_timer_debug                           = false;

    KPLIB_productionMgr_storageMarkerType                           = "hd_pickup";
    KPLIB_productionMgr_storageMarkerColor                          = KPLIB_preset_colorF;

    KPLIB_productionMgr_boolMap = [
        [true, "yes"]
        , [false, "no"]
    ];

    // TODO: TBD: transition to "zeroed prod API" ...
    // Not quite 'empty' but it is a known default state
    KPLIB_productionMgr_productionElem_default = +[
        ["", ""]
        , KPLIB_timers_default
        /* TODO: TBD: may eliminate this bit, but will need to review the production tuple, again...
         * Why is that... Now that storage receives a "KPLIB_resources_storageValue" variable, there
         * is no need to carry anything here. Worst case, we add a production function that summarizes
         * the sector in a zero (0) storage containers scenario, for instance. Everything else can be
         * aligned on the fly relatively easily. */
        , [KPLIB_resources_capDefault, KPLIB_resources_storageValueDefault, []]
        //                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ];
};

if (isServer) then {
    ["[fn_productionMgr_onPreInit] Initialized", "PRE] [PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true
