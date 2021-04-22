#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_settings

    File: fn_sectorsSM_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 15:49:28
    Last Update: 2021-04-22 15:05:59
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

MPARAMSM(_onContext_debug)                                          = true;

MPARAMSM(_createSM_debug)                                           = true;
MPARAMSM(_onGarrisonPending_debug)                                  = true;
MPARAMSM(_onDeactivatingEntered_debug)                              = true;
MPARAMSM(_onDeactivated_debug)                                      = true;
MPARAMSM(_onGetContextList_debug)                                   = false;
MPARAMSM(_onIterating_debug)                                        = true;
MPARAMSM(_onCapturing_debug)                                        = true;
MPARAMSM(_onCapturedEntered_debug)                                  = true;
MPARAMSM(_onDeactivating_debug)                                     = false;
MPARAMSM(_onDeactivatedEntered_debug)                               = false;
MPARAMSM(_timerHasElapsed_debug)                                    = false;
MPARAMSM(_onNoOp_debug)                                             = true;
MPARAMSM(_onGC_debug)                                               = true;
MPARAMSM(_zeroSitrep_debug)                                         = true;

MPARAMSM(_getStochasticTrigger_debug)                               = false;
MPARAMSM(_onPendingEntered_debug)                                   = true;
MPARAMSM(_onPending_debug)                                          = true;
MPARAMSM(_onGarrisonEntered_debug)                                  = true;
MPARAMSM(_onGarrison_debug)                                         = true;
MPARAMSM(_onGarrisonLeaving_debug)                                  = true;
MPARAMSM(_onResistanceEntered_debug)                                = true;
MPARAMSM(_onResistance_debug)                                       = true;
MPARAMSM(_onReinforceEntered_debug)                                 = true;
MPARAMSM(_onReinforce_debug)                                        = true;
MPARAMSM(_onPatrolMissionEntered_debug)                             = true;
MPARAMSM(_onAntiAirMissionEntered_debug)                            = true;
MPARAMSM(_onCloseAirSupportMissionEntered_debug)                    = true;
MPARAMSM(_onCombatAirPatrolMissionEntered_debug)                    = true;
MPARAMSM(_onCounterAttackMissionTransit_debug)                      = true;

if (isServer) then {

    // TODO: TBD: refactored from ENEMY module, _patrolDuration
    MPARAMSM(_pendingPeriod)                                        =   10;

    // TODO: TBD: may just 'drop' these periods in favor of one 'pending' period...
    MPARAMSM(_patrolPeriod)                                         =   30;
    MPARAMSM(_deactivateDuration)                                   =   30;
};

true;
