#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_settings

    File: fn_ieds_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 17:59:32
    Last Update: 2021-05-07 14:29:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arrranges for the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

MPARAM(_onPlayerRespawn_debug)              = true;
MPARAM(_onPlayerRedeploy_debug)             = true;
MPARAM(_setupPlayerActions_debug)           = true;
MPARAM(_canDisarm_debug)                    = false;

MPARAM(_disarmRange)                        = 5;
MPARAM(_disarmPrecision)                    = 10;

if (isServer) then {
    // Server side settings
    MPARAM(_createOne_debug)                = true;
    MPARAM(_getRoads_debug)                 = true;
    MPARAM(_getSpawnPos_debug)              = true;
    MPARAM(_whereRoadMatches_debug)         = true;
    MPARAM(_onMineSpawned_debug)            = true;
    MPARAM(_onDisarm_debug)                 = true;
    MPARAM(_onTriggered_debug)              = true;
    MPARAM(_onGC_debug)                     = true;
    MPARAM(_verifyMine_debug)               = true;

    MPARAM(_spacing)                        = 25;
    MPARAM(_damagePrecision)                = 10;

    // TODO: TBD: damage as a die roll (?)
    // TODO: TBD: how to sim explosions? or do they just do it?
    MPARAM(_damageBigDieSides)              = "8,6,4";
    MPARAM(_damageBigDieTimes)              = "3,4,5";
    MPARAM(_damageBigDieOffsets)            = "";
};

true;
