#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_sectors_settings

    File: fn_sectors_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 15:49:28
    Last Update: 2021-06-14 16:52:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arrranges for the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://www.thefreedictionary.com/arity
        https://en.wikipedia.org/wiki/Arity
        https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

MPARAM(_onLoadData_debug)                                           = false;
MPARAM(_onReconcileSectors_debug)                                   = false;
MPARAM(_getActiveSectors_debug)                                     = false;
MPARAM(_onSaveData_debug)                                           = false;
MPARAM(_onRefresh_debug)                                            = false;
MPARAM(_canActivate_debug)                                          = false;
MPARAM(_onCapturedSetCaptured_debug)                                = false;
MPARAM(_onCapturedUpdateArrays_debug)                               = false;
MPARAM(_onCapturedShowNotification_debug)                           = false;
MPARAM(_onCaptured_surrenderVehicles_debug)                         = false;
MPARAM(_onCaptured_surrenderUnits_debug)                            = false;
MPARAM(_onSectorActivated_debug)                                    = false;
MPARAM(_onActivating_debug)                                         = false;
MPARAM(_onSectorDeactivated_debug)                                  = false;
MPARAM(_onSectorCaptured_debug)                                     = false;
MPARAM(_onUpdateMarkers_debug)                                      = false;
MPARAM(_onNotifyCapture_debug)                                      = false;
MPARAM(_getActivatingNamespaces_debug)                              = false;
MPARAM(_getSectorCapturing_debug)                                   = false;
MPARAM(_createSector_debug)                                         = false;
MPARAM(_getStatusReport_debug)                                      = false;
MPARAM(_getSide_debug)                                              = false;
MPARAM(_getCapRatio_debug)                                          = false;
MPARAM(_getCivResRatio_debug)                                       = false;
MPARAM(_onNotifySitRep_debug)                                       = false;
MPARAM(_onRefreshBuckets_debug)                                     = false;
MPARAM(_onRefreshNotify_debug)                                      = false;
MPARAM(_onRefreshProximities_debug)                                 = false;
MPARAM(_getBucketBundle_debug)                                      = false;
MPARAM(_getSectorSitRep_debug)                                      = false;
MPARAM(_getAllObjects_debug)                                        = false;
MPARAM(_getAllUnits_debug)                                          = false;
MPARAM(_getAllVehicles_debug)                                       = false;
MPARAM(_canCapture_debug)                                           = false;
MPARAM(_canCaptureEval_debug)                                       = false;
MPARAM(_onTearDownVars_debug)                                       = false;
MPARAM(_tearDownObjects_debug)                                      = false;

// TODO: TBD: determine patrol count params, etc...

// Radius in meters around the sector center to activate the sector.
[
    QMPARAM(_actRange)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_SECTOR_SECACT", localize "STR_KPLIB_SETTINGS_SECTOR_SECACT_TT"]
    , localize "STR_KPLIB_SETTINGS_SECTOR"
    , [250, 2000, 1000, 0] // range [250, 2000], default: 1000 (meters)
    , 2
    , {}
] call CBA_fnc_addSetting;

// The amount of sectors which can be active at the same time.
[
    QMPARAM(_maxAct)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_SECTOR_MAX_SECTOR_ACT", localize "STR_KPLIB_SETTINGS_SECTOR_MAX_SECTOR_ACT_TT"]
    , localize "STR_KPLIB_SETTINGS_SECTOR"
    , [1, 12, 6, 0] // range: [1, 12], default: 6
    , 2
    , {}
] call CBA_fnc_addSetting;

// Radius in meters around the sector center a unit has to be to being able to capture the sector.
[
    QMPARAM(_capRange)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_SECTOR_SECRANGE", localize "STR_KPLIB_SETTINGS_SECTOR_SECRANGE_TT"]
    , localize "STR_KPLIB_SETTINGS_SECTOR"
    , [100, 200, 150, 0] // range: [100, 200], default: 150 (meters)
    , 2
    , {}
] call CBA_fnc_addSetting;

{
    _x params [Q(_name), Q(_kind), Q(_suffix)];

    [
        format [KPLIB_SECTORS_CAP_DIVIDEND_OFFSET_FORMAT, _kind, _suffix]
        , Q(SLIDER)
        , [
            format [localize "STR_KPLIB_SETTINGS_SECTORS_CAP_DIVIDEND_OFFSET_FORMAT", _name, _kind]
            , localize "STR_KPLIB_SETTINGS_SECTORS_CAP_DIVIDEND_OFFSET_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_SECTOR"
        , [-25, 25, 0, 0] // range: [-25, 25], default: 0
        , 2
        , {}
    ] call CBA_fnc_addSetting;

    [
        format [KPLIB_SECTORS_CAP_DIVISOR_OFFSET_FORMAT, _kind, _suffix]
        , Q(SLIDER)
        , [
            format [localize "STR_KPLIB_SETTINGS_SECTORS_CAP_DIVISOR_OFFSET_FORMAT", _name, _kind]
            , localize "STR_KPLIB_SETTINGS_SECTORS_CAP_DIVISOR_OFFSET_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_SECTOR"
        , [-25, 25, 0, 0] // range: [-25, 25], default: 0
        , 2
        , {}
    ] call CBA_fnc_addSetting;

    [
        format [KPLIB_SECTORS_CAP_RATIO_BIAS_FORMAT, _kind, _suffix]
        , Q(SLIDER)
        , [
            format [localize "STR_KPLIB_SETTINGS_SECTORS_CAP_RATIO_BIAS_FORMAT", _name, _kind]
            , localize "STR_KPLIB_SETTINGS_SECTORS_CAP_RATIO_BIAS_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_SECTOR"
        , [-50, 50, 0, 0] // range: [-50, 50], default: 0
        , 2
        , {}
    ] call CBA_fnc_addSetting;

    [
        format [KPLIB_SECTORS_CAP_THRESHOLD_FORMAT, _kind, _suffix]
        , Q(SLIDER)
        , [
            format [localize "STR_KPLIB_SETTINGS_SECTORS_CAP_THRESHOLD_FORMAT", _name, _kind]
            , localize "STR_KPLIB_SETTINGS_SECTORS_CAP_THRESHOLD_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_SECTOR"
        , [10, 90, 50, 0] // range: [10, 90], default: 50
        , 2
        , {}
    ] call CBA_fnc_addSetting;

} forEach [
    ["Friendly", Q(Unit), (KPLIB_preset_allSideSuffixes#0)]
    , ["Friendly", Q(Tank), (KPLIB_preset_allSideSuffixes#0)]
    , ["Enemy", Q(Unit), (KPLIB_preset_allSideSuffixes#1)]
    , ["Enemy", Q(Tank), (KPLIB_preset_allSideSuffixes#1)]
];

if (isServer) then {

    // On a scale of 0-85, let's say...
    MPRESET(_arity_zero)                                            =    0;

    MPARAM(_arity_resistance)                                       =   40;
    MPARAM(_arity_reinforce)                                        =   20;
    MPARAM(_arity_patrol)                                           =   25;
    MPARAM(_arity_antiAir)                                          =   45;
    MPARAM(_arity_closeAirSupport)                                  =   65;
    MPARAM(_arity_combatAirPatrol)                                  =   75;
    MPARAM(_arity_counterAttack)                                    =   35;

    // TODO: TBD: ditto strength, re: params, etc
    // TODO: TBD: under no circumstaces should we tune these unless we know what we are doing...
    // TODO: TBD: not least of which the commander logic FSM is **UGLY** to say the least
    // TODO: TBD: in fact the FSM could really be revised and simplified if possible...
    MPARAM(_awarenessThresholdReinforceDefend)                      =   20;
    MPARAM(_awarenessThresholdDefendReinforce)                      =   35;
    MPARAM(_awarenessThresholdReinforceSkirmish)                    =   50;
    MPARAM(_awarenessThresholdCounterattackSkirmish)                =   65;
    MPARAM(_awarenessThresholdSkirmishReinforce)                    =   40;
    MPARAM(_awarenessThresholdSkirmishCounterattack)                =   75;

    MPARAM(_strengthThresholdReinforceDefend)                       =  200;
    MPARAM(_strengthThresholdDefendReinforce)                       =  350;
    MPARAM(_strengthThresholdReinforceSkirmish)                     =  500;
    MPARAM(_strengthThresholdSkirmishCounterattack)                 =  750;

    MPARAM(_deactivationTimeout)                                    =   30;
};

true;
