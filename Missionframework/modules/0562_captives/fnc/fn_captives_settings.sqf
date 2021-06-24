#include "script_component.hpp"
/*
    KPLIB_fnc_captives_settings

    File: fn_captives_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-12
    Last Update: 2021-06-24 11:59:54
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

[
    QMPARAM(_intelDieSides)
    , Q(EDITBOX)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_INTEL_DIE_SIDES"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_INTEL_DIE_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , "6,6,6"
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_intelDieTimes)
    , Q(EDITBOX)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_INTEL_DIE_TIMES"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_INTEL_DIE_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , "2,2,2"
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_intelDieOffsets)
    , Q(EDITBOX)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_INTEL_DIE_OFFSETS"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_INTEL_DIE_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , "3,3,3"
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_unitSurrenderBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_UNIT_SURRENDER_BIAS"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_SURRENDER_BIAS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [-100, 100, 0, 0] // range: [-100, 100], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_opforLightVehicleSurrenderBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_OPFOR_LIGHT_VEHICLE_SURRENDER_BIAS"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_SURRENDER_BIAS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [-100, 100, 0, 0] // range: [-100, 100], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_opforHeavyVehicleSurrenderBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_OPFOR_HEAVY_VEHICLE_SURRENDER_BIAS"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_SURRENDER_BIAS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [-100, 100, 0, 0] // range: [-100, 100], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_opforApcSurrenderBias)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_OPFOR_APC_SURRENDER_BIAS"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_SURRENDER_BIAS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [-100, 100, 0, 0] // range: [-100, 100], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_assetSurrenderThreshold)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_ASSET_SURRENDER_THRESHOLD"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_SURRENDER_THRESHOLD_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [0, 100, 50, 0] // range: [0, 100], default: 50
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_unitSurrenderThreshold)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_UNIT_SURRENDER_THRESHOLD"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_SURRENDER_THRESHOLD_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [0, 100, 50, 0] // range: [0, 100], default: 50
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_minScuttleTimeout)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_MIN_SCUTTLE_VEHICLE_TIMEOUT"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_MIN_SCUTTLE_VEHICLE_TIMEOUT_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [1, 30, 3, 0] // range: [1, 30], default: 3
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_bluforScuttleTimeout)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_BLUFOR_SCUTTLE_VEHICLE_TIMEOUT"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_BLUFOR_SCUTTLE_VEHICLE_TIMEOUT_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [5, 300, 30, 0] // range: [5, 300], default: 30
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_captiveTimeout)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_CAPTIVE_TIMEOUT"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_CAPTIVE_TIMEOUT_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [3, 3600, 300, 0] // range: [3, 3600], default: 300
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_watchCaptivesPeriod)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_WATCH_CAPTIVES_PERIOD"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_WATCH_CAPTIVES_PERIOD_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [1, 300, 60, 0] // range: [1, 300], default: 60
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_loadRange)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_LOAD_RANGE"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_LOAD_RANGE_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [5, 50, 10, 0] // range: [5, 50], default: 10
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_interrogationRadius)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_CAPTIVES_INTERROGATION_RADIUS"
        , localize "STR_KPLIB_SETTINGS_CAPTIVES_INTERROGATION_RADIUS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_CAPTIVES"
    , [25, 100, 50, 0] // range: [25, 100], default: 50
    , 1
    , {}
] call CBA_fnc_addSetting;

if (isServer) then {
    // Server section
    MPARAM(_isEscortEscorting_debug)                        = false;
    MPARAM(_isUnitSurrendering_debug)                       = false;
    MPARAM(_isUnitCaptured_debug)                           = false;
    MPARAM(_isUnitInterrogated_debug)                       = false;
    MPARAM(_getEscortedUnit_debug)                          = false;
    MPARAM(_onVehicleCreated_debug)                         = false;
    MPARAM(_onSectorCapturedScuttleBluforAssets_debug)      = false;
    MPARAM(_onSectorCapturedDeleteBluforUnits_debug)        = false;
    MPARAM(_onAceCaptiveStatusChanged_debug)                = false;
    MPARAM(_onSectorCapturedSurrenderVehicles_debug)        = false;
    MPARAM(_onSectorCapturedSurrenderUnits_debug)           = false;
    MPARAM(_onSectorCapturedSetIntel_debug)                 = false;
    MPARAM(_onSectorCapturedCaptiveTimers_debug)            = false;
    MPARAM(_onSurrenderUnitOne_debug)                       = false;
    MPARAM(_onSurrenderVehicleOne_debug)                    = false;
    MPARAM(_addCaptiveActions_debug)                        = false;
    MPARAM(_addEscortActions_debug)                         = false;
    MPARAM(_addVehicleActions_debug)                        = false;
    MPARAM(_onUnitCapture_debug)                            = false;
    MPARAM(_onUnitToggleEscort_debug)                       = false;
    MPARAM(_onUnitLoad_debug)                               = false;
    MPARAM(_onUnitUnloadOne_debug)                          = false;
    MPARAM(_onPreInit_onUnload_debug)                       = false;
    MPARAM(_onPlayerGetInVehicle_debug)                     = false;
    MPARAM(_onUnitGetInVehicle_debug)                       = false;
    MPARAM(_onUnitGetOutVehicle_debug)                      = false;
    MPARAM(_canLoadTransport_debug)                         = false;
    MPARAM(_canLoadUnit_debug)                              = false;
    MPARAM(_showUnloadTransportMenu_debug)                  = false;
    MPARAM(_onWatchCaptives_debug)                          = false;
    MPARAM(_onWatchStopEscortingOne_debug)                  = false;
    MPARAM(_onWatchInterrogateOne_debug)                    = false;
    MPARAM(_onWatchTimerElapsedOneGC_debug)                 = false;
    MPARAM(_getLoadedCaptives_debug)                        = false;
    MPARAM(_onTransportUnload_debug)                        = false;
    MPARAM(_playMove_debug)                                 = false;
};

true;
