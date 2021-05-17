#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_settings

    File: fn_ieds_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 17:59:32
    Last Update: 2021-05-08 22:52:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arrranges for the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

MPARAM(_onPlayerRespawn_debug)              = false;
MPARAM(_onPlayerRedeploy_debug)             = false;
MPARAM(_setupPlayerActions_debug)           = false;
MPARAM(_canDisarm_debug)                    = false;

MPARAM(_onTriggerActivation_debug)          = true;
MPARAM(_onTriggerSmallCondition_debug)      = true;
MPARAM(_onTriggerBigCondition_debug)        = true;

MPARAM(_disarmRange)                        = 5;
MPARAM(_disarmPrecision)                    = 10;

MPRESET(_smallTriggerAreaRadius)            = 15;
MPRESET(_smallTriggerAreaHeight)            = 15;

MPRESET(_bigTriggerAreaRadius)              = 25;
MPRESET(_bigTriggerAreaHeight)              = 25;

// Tested in debugger
MPARAM(_unitApproachSafeSpeed)              = 6;
MPARAM(_vehicleApproachSafeSpeed)           = 11;

MPARAM(_smallRunningThreshold)              = 1;
MPARAM(_bigRunningThreshold)                = 1;

MPARAM(_smallDetonationChance)              = 40;
MPARAM(_bigDetonationChance)                = 60;

if (isServer) then {
    // Server side settings
    MPARAM(_createOne_debug)                = false;
    MPARAM(_getRoads_debug)                 = false;
    MPARAM(_getSpawnPos_debug)              = false;
    MPARAM(_whereRoadMatches_debug)         = false;
    MPARAM(_onMineSpawned_debug)            = false;
    MPARAM(_onDisarm_debug)                 = false;
    MPARAM(_onTriggered_debug)              = false;
    MPARAM(_onGC_debug)                     = false;
    MPARAM(_verifyMine_debug)               = false;

    MPARAM(_spacing)                        = 25;
    MPARAM(_damagePrecision)                = 10;

    // TODO: TBD: damage as a die roll (?)
    // TODO: TBD: how to sim explosions? or do they just do it?
    MPARAM(_damageBigDieSides)              = "8,6,4";
    MPARAM(_damageBigDieTimes)              = "3,4,5";
    MPARAM(_damageBigDieOffsets)            = "";
};

true;
