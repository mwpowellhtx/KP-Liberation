#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_settings

    File: fn_sectors_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 15:49:28
    Last Update: 2021-05-03 13:25:23
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
 */

MPARAM(_onLoadData_debug)                                           = false;
MPARAM(_onReconcileSectors_debug)                                   = false;
MPARAM(_getActiveSectors_debug)                                     = false;
MPARAM(_onSaveData_debug)                                           = false;
MPARAM(_onRefresh_debug)                                            = false;
MPARAM(_onSectorActivated_debug)                                    = false;
MPARAM(_onSectorDeactivated_debug)                                  = false;
MPARAM(_onSectorCaptured_debug)                                     = false;
MPARAM(_onUpdateMarkers_debug)                                      = false;
MPARAM(_onNotifyCapture_debug)                                      = false;
MPARAM(_getActivatingNamespaces_debug)                              = false;
MPARAM(_getSectorCapturing_debug)                                   = false;
MPARAM(_createSector_debug)                                         = false;
MPARAM(_getStatusReport_debug)                                      = false;
MPARAM(_getSide_debug)                                              = false;

// TODO: TBD: determine patrol count params, etc...

// Radius in meters around the sector center to activate the sector.
[
    QMPARAM(_actRange)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_SECTOR_SECACT", localize "STR_KPLIB_SETTINGS_SECTOR_SECACT_TT"]
    , localize "STR_KPLIB_SETTINGS_SECTOR"
    , [250, 2000, 1000, 0] // range [250, 2000], default: 1000 (meters)
    , 1
    , {}
] call CBA_settings_fnc_init;

// The amount of sectors which can be active at the same time.
[
    QMPARAM(_maxAct)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_SECTOR_MAX_SECTOR_ACT", localize "STR_KPLIB_SETTINGS_SECTOR_MAX_SECTOR_ACT_TT"]
    , localize "STR_KPLIB_SETTINGS_SECTOR"
    , [1, 12, 6, 0] // range: [1, 12], default: 6
    , 1
    , {}
] call CBA_settings_fnc_init;

// Radius in meters around the sector center a unit has to be to being able to capture the sector.
[
    QMPARAM(_capRange)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_SECTOR_SECRANGE", localize "STR_KPLIB_SETTINGS_SECTOR_SECRANGE_TT"]
    , localize "STR_KPLIB_SETTINGS_SECTOR"
    , [100, 200, 150, 0] // range: [100, 200], default: 150 (meters)
    , 1
    , {}
] call CBA_settings_fnc_init;

// Ratio of enemy units to friendly units, which is needed to capture a sector.
[
    QMPARAM(_capRatio)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_SECTOR_SECRATIO", localize "STR_KPLIB_SETTINGS_SECTOR_SECRATIO_TT"]
    , localize "STR_KPLIB_SETTINGS_SECTOR"
    , [1, 10, 1.5, 1] // range: [1, 10], default: 1.5, precision: 1
    , 1
    , {}
] call CBA_settings_fnc_init;

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
};

true;
