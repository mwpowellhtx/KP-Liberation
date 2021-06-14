#include "script_component.hpp"
/*
    KPLIB_fnc_captive_settings

    File: fn_captive_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-12
    Last Update: 2021-06-14 17:19:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module CBA settings.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://dictionary.cambridge.org/dictionary/english/scuttle
 */

// KPLIB_param_captiveIntel
// Amount of intel which will be granted on interrogation.
// Default: 10
[
    "KPLIB_param_captiveIntel",
    "SLIDER",
    [localize "STR_KPLIB_SETTINGS_CAPTIVE_INTELVALUE", localize "STR_KPLIB_SETTINGS_CAPTIVE_INTELVALUE_TT"],
    localize "STR_KPLIB_SETTINGS_CAPTIVE",
    [1, 100, 10, 1],
    1,
    {}
] call CBA_Settings_fnc_init;

// KPLIB_param_captiveIntelRandom
// Amount of random intel modifier on interrogation.
// Default: 5
[
    "KPLIB_param_captiveIntelRandom",
    "SLIDER",
    [localize "STR_KPLIB_SETTINGS_CAPTIVE_INTELRANDOM", localize "STR_KPLIB_SETTINGS_CAPTIVE_INTELRANDOM_TT"],
    localize "STR_KPLIB_SETTINGS_CAPTIVE",
    [0, 100, 5, 1],
    1,
    {}
] call CBA_Settings_fnc_init;

if (isServer) then {

    KPLIB_param_captive_onSectorCapturedSurrenderVehicles_debug             = false;
    KPLIB_param_captive_onSectorCapturedSurrenderUnits_debug                = false;

    MPARAM(_onCaptiveGC_debug)                                              = true;

    KPLIB_param_captive_bluforScuttleTimeout                                =  30;

    // TODO: TBD: starting with OPFOR... TBD: whether we want to include RESISTANCE...
    /* Contributes 50% to the overall chance, with INVERSE ENEMY STRENGTH the other 50.
     *  chance - range: [0, 100], default: 85 (%)
     *  bias - range: [-100, 100], default: 0 (%)
     */
    KPLIB_param_captive_opforLightVehicleSurrenderChance                    =  85;
    KPLIB_param_captive_opforLightVehicleSurrenderBias                      =   0;

    KPLIB_param_captive_opforHeavyVehicleSurrenderChance                    =  65;
    KPLIB_param_captive_opforHeavyVehicleSurrenderBias                      =   0;

    KPLIB_param_captive_opforApcVehicleSurrenderChance                      =  75;
    KPLIB_param_captive_opforApcVehicleSurrenderBias                        =   0;

    KPLIB_param_captive_opforUnitSurrenderChance                            =  75;
    KPLIB_param_captive_opforUnitSurrenderBias                              =   0;

    KPLIB_param_captive_period                                              =  30;
    KPLIB_param_captive_timeout                                             = 300;
};

true;
