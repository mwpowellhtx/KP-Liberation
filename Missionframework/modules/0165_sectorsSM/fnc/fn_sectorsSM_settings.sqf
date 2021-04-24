#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_settings

    File: fn_sectorsSM_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 15:49:28
    Last Update: 2021-04-24 11:22:36
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

MPARAMSM(_onContext_debug)                                          = false;

MPARAMSM(_createSM_debug)                                           = false;
MPARAMSM(_onGarrisonPending_debug)                                  = false;
MPARAMSM(_onDeactivatingEntered_debug)                              = false;
MPARAMSM(_onDeactivating_debug)                                     = false;
MPARAMSM(_onDeactivated_debug)                                      = false;
MPARAMSM(_onGetContextList_debug)                                   = false;
MPARAMSM(_onIterating_debug)                                        = false;
MPARAMSM(_onCapturing_debug)                                        = false;
MPARAMSM(_onCapturedEntered_debug)                                  = false;
MPARAMSM(_onDeactivatedEntered_debug)                               = false;
MPARAMSM(_timerHasElapsed_debug)                                    = false;
MPARAMSM(_onNoOp_debug)                                             = false;
MPARAMSM(_onGC_debug)                                               = false;
MPARAMSM(_zeroSitrep_debug)                                         = false;

MPARAMSM(_getStochasticTrigger_debug)                               = false;
MPARAMSM(_onPendingEntered_debug)                                   = false;
MPARAMSM(_onPending_debug)                                          = false;
MPARAMSM(_onGarrisonEntered_debug)                                  = false;
MPARAMSM(_onGarrison_debug)                                         = false;
MPARAMSM(_onGarrisonLeaving_debug)                                  = false;
MPARAMSM(_onResistanceEntered_debug)                                = false;
MPARAMSM(_onResistance_debug)                                       = false;
MPARAMSM(_onReinforceEntered_debug)                                 = false;
MPARAMSM(_onReinforce_debug)                                        = false;
MPARAMSM(_onPatrolMissionEntered_debug)                             = false;
MPARAMSM(_onAntiAirMissionEntered_debug)                            = false;
MPARAMSM(_onCloseAirSupportMissionEntered_debug)                    = false;
MPARAMSM(_onCombatAirPatrolMissionEntered_debug)                    = false;
MPARAMSM(_onCounterAttackMissionTransit_debug)                      = false;

if (isServer) then {

    // TODO: TBD: refactored from ENEMY module, _patrolDuration
    MPARAMSM(_pendingPeriod)                                        =   30;

    // TODO: TBD: may just 'drop' these periods in favor of one 'pending' period...
    MPARAMSM(_patrolPeriod)                                         =   30;
    MPARAMSM(_deactivationPeriod)                                   =   30;
};

true;
