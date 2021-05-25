#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_settings

    File: fn_fobs_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:06:46
    Last Update: 2021-05-25 00:14:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

[
    QMPARAM(_range)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_FOBS_RANGE", localize "STR_KPLIB_SETTINGS_GENERAL_RANGE_TT"]
    , localize "STR_KPLIB_SETTINGS_FOBS"
    , [100, 250, 125, 0] // range: [100, 250], default: 125
    , 2
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_maxBlindRange)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_FOBS_MAX_BLIND_RANGE", localize "STR_KPLIB_SETTINGS_FOBS_MAX_BLIND_RANGE_TT"]
    , localize "STR_KPLIB_SETTINGS_FOBS"
    , [1000, 40000, 20000, 0] // range: [1000, 40000], default: 20000
    , 2
    , {}
] call CBA_fnc_addSetting;

if (isServer) then {
    MPARAM(_presets_debug)                      = false;
    MPARAM(_resequence_debug)                   = false;
    MPARAM(_onLoadData_debug)                   = false;
    MPARAM(_onPreInit_debug)                    = false;
    MPARAM(_onPostInit_debug)                   = false;
    MPARAM(_canBuild_debug)                     = false;
    MPARAM(_getBuildings_debug)                 = false;
    MPARAM(_onUpdateMarkerOne_debug)            = false;
    MPARAM(_onUpdateMarkers_debug)              = false;
    MPARAM(_onDeployRequested_debug)            = false;
    MPARAM(_onRepackageRequested_debug)         = false;
    MPARAM(_onTearDown_debug)                   = false;
    MPARAM(_onConfirmRepackage_debug)           = false;
    MPARAM(_onVehicleCreated_debug)             = false;
    MPARAM(_setupDeployActions_debug)           = false;
    MPARAM(_setupPlayerActions_debug)           = false;
    MPARAM(_onVerifyStartingBoxOrTruck_debug)   = false;
};

true;
