#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_settings

    File: fn_garrison_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 21:47:20
    Last Update: 2021-04-27 13:46:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    
    MPARAM(_onLoadData_debug)                       = false;
    MPARAM(_onSaveData_debug)                       = false;
    MPARAM(_onGarrisoning_debug)                    = false;
    MPARAM(_onGarrisoningCalculateBits_debug)       = false;
    MPARAM(_onSpawn_debug)                          = true;
    MPARAM(_onSpawnSectorInfantry_debug)            = true;
    MPARAM(_onSpawnSectorVehicle_debug)             = true;
    MPARAM(_onSpawnSectorResistance_debug)          = true;

    MPARAM(_defaultInfantryCount)                   =  6;

    // TODO: TBD: may defer some of these to actual CBA settings...
    MPARAM(_minRange)                               = 50;
    MPARAM(_nearEntityRange)                        = 20;
    MPARAM(_waypointCompletionRange)                = 30;

    MPARAM(_defendThreshold)                        =  3;
    MPARAM(_defendPatrolChance)                     = 25;
    MPARAM(_defendHoldChance)                       = 60;

    // Patrol chance used when creating units
    MPARAM(_patrolChance)                           = 15;
    MPARAM(_waypointCount)                          =  4;

    // Biases, as whole number percentage, range: [0, 100]
    // Setup the ENEMY STRENGTH bias for the following kinds of assets
    MPARAM(_biasStrength_lightVehicle)              = 30;
    MPARAM(_biasStrength_heavyVehicle)              = 45;
    MPARAM(_biasStrength_rotary)                    = 65;
    MPARAM(_biasStrength_fixedWing)                 = 85;

    // Rinse and repeat for CIVILIAN REPUTATION units and IEDs, respectively
    MPARAM(_biasCivRep_units)                       = 40;
    MPARAM(_biasCivRep_ieds)                        = 60;
    // TODO: TBD: need to think through the whole bias question...

    // TODO: TBD: add to "KPLIP - Garrison - Base"
    /*
        BASE CONFIGURATION
     */
    MPARAM(_baseGrpMin)                             = 3;
    MPARAM(_baseGrpCount)                           = 3;
    MPARAM(_baseGrpCeil)                            = true;

    MPARAM(_baseUnitMin)                            = 2;
    MPARAM(_baseUnitCount)                          = 2;
    MPARAM(_baseUnitCeil)                           = true;
    MPARAM(_baseUnitCoef)                           = 5;

    MPARAM(_baseLightVehicleMin)                    = 3;
    MPARAM(_baseLightVehicleCount)                  = 4;
    MPARAM(_baseLightVehicleCeil)                   = false;
    MPARAM(_baseLightVehicleCoef)                   = 1;

    MPARAM(_baseHeavyVehicleMin)                    = 2;
    MPARAM(_baseHeavyVehicleCount)                  = 3;
    MPARAM(_baseHeavyVehicleCeil)                   = true;
    MPARAM(_baseHeavyVehicleCoef)                   = 1;

    // Influence the COUNT of assets as well as the CHANCE
    MPARAM(_baseUnitThrottleMin)                    = 0;
    MPARAM(_baseUnitThrottle)                       = 0;
    MPARAM(_baseUnitBias)                           = 0;

    MPARAM(_baseLightVehicleThrottleMin)            = 0;
    MPARAM(_baseLightVehicleThrottle)               = 0;
    MPARAM(_baseLightVehicleBias)                   = 0;

    MPARAM(_baseHeavyVehicleThrottle)               = 0;
    MPARAM(_baseHeavyVehicleThrottleMin)            = 0;
    MPARAM(_baseHeavyVehicleBias)                   = 0;

    // Yes, INTEL is BASE or MILITARY specific, however it is also a special case
    MPARAM(_baseIntelMin)                           = 2;
    MPARAM(_baseIntelCount)                         = 5;
    MPARAM(_baseIntelCeil)                          = true;
    MPARAM(_baseIntelCoef)                          = 1;

    MPARAM(_baseIntelBuildingDamageThreshold)       = 0.5;

    /*
        CITY CONFIGURATION
     */
    MPARAM(_cityGrpMin)                             = 2;
    MPARAM(_cityGrpCount)                           = 2;
    MPARAM(_cityGrpCeil)                            = true;

    MPARAM(_cityUnitMin)                            = 3;
    MPARAM(_cityUnitCount)                          = 3;
    MPARAM(_cityUnitCeil)                           = true;
    MPARAM(_cityUnitCoef)                           = 3;

    MPARAM(_cityLightVehicleMin)                    = 1;
    MPARAM(_cityLightVehicleCount)                  = 3;
    MPARAM(_cityLightVehicleCeil)                   = false;
    MPARAM(_cityLightVehicleCoef)                   = 1;

    MPARAM(_cityHeavyVehicleMin)                    = 1;
    MPARAM(_cityHeavyVehicleCount)                  = 2;
    MPARAM(_cityHeavyVehicleCeil)                   = true;
    MPARAM(_cityHeavyVehicleCoef)                   = 1;

    MPARAM(_cityIedMin)                             = 3;
    MPARAM(_cityIedCount)                           = 2;
    MPARAM(_cityIedCeil)                            = false;
    MPARAM(_cityIedCoef)                            = 2;

    MPARAM(_cityUnitThrottleMin)                    = 0;
    MPARAM(_cityUnitThrottle)                       = 0;
    MPARAM(_cityUnitBias)                           = 0;

    MPARAM(_cityLightVehicleThrottleMin)            = 0;
    MPARAM(_cityLightVehicleThrottle)               = 0;
    MPARAM(_cityLightVehicleBias)                   = 0;

    MPARAM(_cityHeavyVehicleThrottleMin)            = 0;
    MPARAM(_cityHeavyVehicleThrottle)               = 0;
    MPARAM(_cityHeavyVehicleBias)                   = 0;

    MPARAM(_cityIedThrottleMin)                     = 0;
    MPARAM(_cityIedThrottle)                        = 0;
    MPARAM(_cityIedBias)                            = 0;


    /*
        FACTORY CONFIGURATION
     */
    MPARAM(_factoryGrpMin)                          = 2;
    MPARAM(_factoryGrpCount)                        = 2;
    MPARAM(_factoryGrpCeil)                         = true;

    MPARAM(_factoryUnitMin)                         = 3;
    MPARAM(_factoryUnitCount)                       = 3;
    MPARAM(_factoryUnitCeil)                        = true;
    MPARAM(_factoryUnitCoef)                        = 2;

    MPARAM(_factoryLightVehicleMin)                 = 2;
    MPARAM(_factoryLightVehicleCount)               = 2;
    MPARAM(_factoryLightVehicleCeil)                = false;
    MPARAM(_factoryLightVehicleCoef)                = 1;

    MPARAM(_factoryHeavyVehicleMin)                 = 1;
    MPARAM(_factoryHeavyVehicleCount)               = 2;
    MPARAM(_factoryHeavyVehicleCeil)                = true;
    MPARAM(_factoryHeavyVehicleCoef)                = 1;

    MPARAM(_factoryIedMin)                          = 2;
    MPARAM(_factoryIedCount)                        = 2;
    MPARAM(_factoryIedCeil)                         = true;
    MPARAM(_factoryIedCoef)                         = 2;

    MPARAM(_factoryUnitThrottleMin)                 = 0;
    MPARAM(_factoryUnitThrottle)                    = 0;
    MPARAM(_factoryUnitBias)                        = 0;

    MPARAM(_factoryLightVehicleThrottleMin)         = 0;
    MPARAM(_factoryLightVehicleThrottle)            = 0;
    MPARAM(_factoryLightVehicleBias)                = 0;

    MPARAM(_factoryHeavyVehicleThrottleMin)         = 0;
    MPARAM(_factoryHeavyVehicleThrottle)            = 0;
    MPARAM(_factoryHeavyVehicleBias)                = 0;

    MPARAM(_factoryIedThrottleMin)                  = 0;
    MPARAM(_factoryIedThrottle)                     = 0;
    MPARAM(_factoryIedBias)                         = 0;


    /*
        METROPOLIS CONFIGURATION
     */
    MPARAM(_metropolisGrpMin)                       = 4;
    MPARAM(_metropolisGrpCount)                     = 4;
    MPARAM(_metropolisGrpCeil)                      = true;

    MPARAM(_metropolisUnitMin)                      = 3;
    MPARAM(_metropolisUnitCount)                    = 3;
    MPARAM(_metropolisUnitCeil)                     = true;
    MPARAM(_metropolisUnitCoef)                     = 8;

    MPARAM(_metropolisLightVehicleMin)              = 2;
    MPARAM(_metropolisLightVehicleCount)            = 2;
    MPARAM(_metropolisLightVehicleCeil)             = true;
    MPARAM(_metropolisLightVehicleCoef)             = 2;

    MPARAM(_metropolisHeavyVehicleMin)              = 1;
    MPARAM(_metropolisHeavyVehicleCount)            = 2;
    MPARAM(_metropolisHeavyVehicleCeil)             = true;
    MPARAM(_metropolisHeavyVehicleCoef)             = 2;

    MPARAM(_metropolisIedMin)                       = 2;
    MPARAM(_metropolisIedCount)                     = 2;
    MPARAM(_metropolisIedCeil)                      = true;
    MPARAM(_metropolisIedCoef)                      = 2;

    MPARAM(_metropolisUnitThrottleMin)              = 0;
    MPARAM(_metropolisUnitThrottle)                 = 0;
    MPARAM(_metropolisUnitBias)                     = 0;

    MPARAM(_metropolisLightVehicleThrottleMin)      = 0;
    MPARAM(_metropolisLightVehicleThrottle)         = 0;
    MPARAM(_metropolisLightVehicleBias)             = 0;

    MPARAM(_metropolisHeavyVehicleThrottleMin)      = 0;
    MPARAM(_metropolisHeavyVehicleThrottle)         = 0;
    MPARAM(_metropolisHeavyVehicleBias)             = 0;

    MPARAM(_metropolisIedThrottleMin)               = 0;
    MPARAM(_metropolisIedThrottle)                  = 0;
    MPARAM(_metropolisIedBias)                      = 0;


    /*
        TOWER CONFIGURATION
     */
    MPARAM(_towerGrpMin)                            = 2;
    MPARAM(_towerGrpCount)                          = 2;
    MPARAM(_towerGrpCeil)                           = true;

    MPARAM(_towerUnitMin)                           = 3;
    MPARAM(_towerUnitCount)                         = 3;
    MPARAM(_towerUnitCeil)                          = true;
    MPARAM(_towerUnitCoef)                          = 2;

    MPARAM(_towerLightVehicleMin)                   = 0;
    MPARAM(_towerLightVehicleCount)                 = 3;
    MPARAM(_towerLightVehicleCeil)                  = false;
    MPARAM(_towerLightVehicleCoef)                  = 0;

    MPARAM(_towerHeavyVehicleMin)                   = 0;
    MPARAM(_towerHeavyVehicleCount)                 = 2;
    MPARAM(_towerHeavyVehicleCeil)                  = false;
    MPARAM(_towerHeavyVehicleCoef)                  = 0;

    MPARAM(_towerUnitThrottleMin)                   = 20;
    MPARAM(_towerUnitThrottle)                      = 100;
    MPARAM(_towerUnitBias)                          = 100;

    MPARAM(_towerLightVehicleThrottleMin)           = 0;
    MPARAM(_towerLightVehicleThrottle)              = 0;
    MPARAM(_towerLightVehicleBias)                  = 0;

    MPARAM(_towerHeavyVehicleThrottleMin)           = 0;
    MPARAM(_towerHeavyVehicleThrottle)              = 0;
    MPARAM(_towerHeavyVehicleBias)                  = 0;

    // Remember also the several IED thresholds, however counts are SECTOR specific
    MPARAM(_iedThresholdXL)                         = 90; // +20
    MPARAM(_iedThresholdL)                          = 70; // +25
    MPARAM(_iedThresholdM)                          = 45; // +30
    MPARAM(_iedThresholdS)                          = 15;
};

if (hasInterface) then {
};

true;
