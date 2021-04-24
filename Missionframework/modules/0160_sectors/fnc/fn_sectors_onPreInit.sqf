#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onPreInit

    File: fn_sectors_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 13:33:30
    Last Update: 2021-04-24 11:11:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/Category:Function_Group:_Bitwise
        https://community.bistudio.com/wiki/a_%5E_b (a ^ b)
 */

if (isServer) then {
    ["[fn_sectors_onPreInit] Initializing...", "PRE] [SECTORS", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */


/*
    ----- Module Initialization -----
 */

// Process CBA Settings, must be processed first
[] call MFUNC(_settings);

// Server section (dedicated and player hosted)
if (isServer) then {

    MVAR(_namespaces)                                               = [];

    // For use informing the state machine
    MVAR(_activeNamespaces)                                         = [];

    MVAR(_serializationRegistry) = [QMVAR(_markerName)] call KPLIB_fnc_namespace_createSerializationRegistry;

    // TODO: TBD: may register other variable names...
    [MVAR(_serializationRegistry), [
            QMVAR(_markerPos)
        ]] call KPLIB_fnc_namespace_registerSerializationVars;

    MVAR(_activating)                                               = QMVAR(_activating);
    // MVAR(_activated)                                                = QMVAR(_activated);
    MVAR(_captured)                                                 = QMVAR(_captured);
    MVAR(_deactivated)                                              = QMVAR(_deactivated);

    /* Bits like ENEMY 'defending', etc, will be regulated differently than SECTOR state machine,
     * because this has more to do with 'friendliness' between sides, which also involves civilian,
     * resistance, etc, disposition towards BLUFOR, OPFOR, etc. Which is a function of civilian
     * reputation, awareness, and strength. */

    /* There are several overall status flags here, paired according to bracketing the event,
     * mission, activity, etc.
     *      - GARRISON+GARRISONED
     *      - CAPTURING+CAPTURED
     *      - DEACTIVATING+DEACTIVATED
     *      - RESISTING+RESISTED
     *      - REINFORCING+REINFORCED+(INFANTRY|MECHANIZED|PARATROOPER)
     *
     * Then with a couple of MISSION considerations, indicating whether one should be triggered:
     *      - PATROL
     *      - COUNTER-ATTACK
     *      - ANTI-AIR
     * Which themselves are bracketed by MISSION+COMPLETE, signaling whether a next mission of its
     * type may be considered.
     */
    {
        private _index = _forEachIndex;
        // Accounting for STANDBY which should be ZED
        private _flag = if (_index == 0) then { 0; } else { 2 ^ (_index - 1); };
        private _variableName = _x;
        // Such that we get each of the BITWIZE flags aligned in a predictable position
        missionNamespace setVariable [_variableName, _flag];
    } forEach [
        QMSTATUS(_standby)
        , QMSTATUS(_garrisoning)    , QMSTATUS(_garrisoned)
        , QMSTATUS(_capturing)      , QMSTATUS(_captured)
        , QMSTATUS(_deactivating)   , QMSTATUS(_deactivated)
        , QMSTATUS(_resisting)      , QMSTATUS(_resisted)
        , QMSTATUS(_reinforcing)    , QMSTATUS(_reinforced)
        , QMSTATUS(_infantry)       , QMSTATUS(_paratrooper)
        , QMSTATUS(_lightArmor)     , QMSTATUS(_heavyArmor)
        , QMSTATUS(_mission)        , QMSTATUS(_complete)
        , QMSTATUS(_patrol)         , QMSTATUS(_antiAir)
        , QMSTATUS(_closeAirSupport), QMSTATUS(_combatAirPatrol)
        , QMSTATUS(_counterAttack)
    ];

    // Align some combinations
    MSTATUS(_capturingCaptured)         = MSTATUS(_capturing)       + MSTATUS(_captured);
    MSTATUS(_deactivatingDeactivated)   = MSTATUS(_deactivating)    + MSTATUS(_deactivated);

    MSTATUS(_resistingResisted)         = MSTATUS(_resisting)       + MSTATUS(_resisted);
    MSTATUS(_reinforcingReinforced)     = MSTATUS(_reinforcing)     + MSTATUS(_reinforced);

    MSTATUS(_reinforcingInfantry)       = MSTATUS(_reinforcing)      + MSTATUS(_infantry);
    MSTATUS(_reinforcingParatrooper)    = MSTATUS(_reinforcing)      + MSTATUS(_paratrooper);
    MSTATUS(_reinforcingLightArmor)     = MSTATUS(_reinforcing)      + MSTATUS(_lightArmor);
    MSTATUS(_reinforcingHeavyArmor)     = MSTATUS(_reinforcing)      + MSTATUS(_heavyArmor);

    MSTATUS(_reinforcedInfantry)        = MSTATUS(_reinforced)      + MSTATUS(_infantry);
    MSTATUS(_reinforcedParatrooper)     = MSTATUS(_reinforced)      + MSTATUS(_paratrooper);
    MSTATUS(_reinforcedLightArmor)      = MSTATUS(_reinforced)      + MSTATUS(_lightArmor);
    MSTATUS(_reinforcedHeavyArmor)      = MSTATUS(_reinforced)      + MSTATUS(_heavyArmor);

    MSTATUS(_patrolMission)             = MSTATUS(_patrol)          + MSTATUS(_mission);
    MSTATUS(_antiAirMission)            = MSTATUS(_antiAir)         + MSTATUS(_mission);
    MSTATUS(_closeAirSupportMission)    = MSTATUS(_closeAirSupport) + MSTATUS(_mission);
    MSTATUS(_combatAirPatrolMission)    = MSTATUS(_combatAirPatrol) + MSTATUS(_mission);
    MSTATUS(_counterAttackMission)      = MSTATUS(_counterAttack)   + MSTATUS(_mission);
    MSTATUS(_missionComplete)           = MSTATUS(_mission)         + MSTATUS(_complete);

    // // TODO: TBD: for follow up later: https://github.com/mwpowellhtx/KP-Liberation/issues/78
    // // TODO: TBD: for now, making a best possible effort to minimize the shake up in order to accomplish HUD overlays
    // // TODO: TBD: we think these only ever need to be defined server side...

    // MPRESET(_awareness)                                             = Q(awareness);
    // MPRESET(_strength)                                              = Q(strength);
    // MPRESET(_defend)                                                = Q(defend);
    // MPRESET(_skirmish)                                              = Q(skirmish);
    // MPRESET(_reinforce)                                             = Q(reinforce);
    // MPRESET(_counterattack)                                         = Q(counterattack);

    // // For use with getting awareness threshold
    // MPRESET(_lessOrEqual)                                           = Q(le);
    // MPRESET(_greaterOrEqual)                                        = Q(ge);
    // MPRESET(_thresholdDelim)                                        = Q(:);

    // // TODO: TBD: the approach is penciled in for now, will want to revise it later...
    // MPRESET(_thresholdMap)                                          = [
    //         MPRESET(_awareness)
    //         , MPRESET(_strength)
    //         , MPRESET(_defend)
    //         , MPRESET(_skirmish)
    //         , MPRESET(_reinforce)
    //         , MPRESET(_counterattack)
    //         , MPRESET(_thresholdDelim)
    // ] call {
    //     params [
    //         Q(_awareness)
    //         , Q(_strength)
    //         , Q(_defend)
    //         , Q(_skirmish)
    //         , Q(_reinforce)
    //         , Q(_counterattack)
    //         , Q(_delim)
    //     ];
    //     createHashMapFromArray [
    //         // Setup the AWARENESS based thresholds
    //         [[_awareness, _reinforce, _defend] joinString _delim        , MPARAM(_awarenessThresholdReinforceDefend)        ]
    //         , [[_awareness, _defend, _reinforce] joinString _delim      , MPARAM(_awarenessThresholdDefendReinforce)        ]
    //         //  ^^^^^^^^^^
    //         , [[_awareness, _reinforce, _skirmish] joinString _delim    , MPARAM(_awarenessThresholdReinforceSkirmish)      ]
    //         , [[_awareness, _counterattack, _skirmish] joinString _delim, MPARAM(_awarenessThresholdCounterattackSkirmish)  ]
    //         , [[_awareness, _skirmish, _reinforce] joinString _delim    , MPARAM(_awarenessThresholdSkirmishReinforce)      ]
    //         , [[_awareness, _skirmish, _counterattack] joinString _delim, MPARAM(_awarenessThresholdSkirmishCounterattack)  ]
    //         // Setup some STRENGTH based thresholds
    //         , [[_strength, _reinforce, _defend] joinString _delim       , MPARAM(_strengthThresholdReinforceDefend)         ]
    //         //  ^^^^^^^^^
    //         , [[_strength, _defend, _reinforce] joinString _delim       , MPARAM(_strengthThresholdDefendReinforce)         ]
    //         , [[_strength, _reinforce, _skirmish] joinString _delim     , MPARAM(_strengthThresholdReinforceSkirmish)       ]
    //         , [[_strength, _skirmish, _counterattack] joinString _delim , MPARAM(_strengthThresholdSkirmishCounterattack)   ]
    //     ];
    // };

    // Add event handlers
    [Q(KPLIB_doLoad), { [] call MFUNC(_onLoadData); }] call CBA_fnc_addEventHandler;
    [Q(KPLIB_doSave), { [] call MFUNC(_onSaveData); }] call CBA_fnc_addEventHandler;

    [MVAR(_activating), { _this call MFUNC(_onSectorActivating); }] call CBA_fnc_addEventHandler;
    [MVAR(_captured), { _this call MFUNC(_onSectorCaptured); }] call CBA_fnc_addEventHandler;

    [Q(KPLIB_updateMarkers), { [] call MFUNC(_onUpdateMarkers); }] call CBA_fnc_addEventHandler;

    // Define the SECTOR prefixes, we use this for easy identification and classification
    MPRESET(_towerPrefix)                                           = Q(KPLIB_eden_t); // -ower
    MPRESET(_factoryPrefix)                                         = Q(KPLIB_eden_f); // -actory
    MPRESET(_basePrefix)                                            = Q(KPLIB_eden_b); // -ase
    MPRESET(_cityPrefix)                                            = Q(KPLIB_eden_c); // -ity
    MPRESET(_metropolisPrefix)                                      = Q(KPLIB_eden_m); // -etropolis

    MPRESET(_towerIcon)                                             = "\a3\ui_f\data\map\mapcontrol\transmitter_ca.paa";
    MPRESET(_factoryIcon)                                           = "\a3\ui_f\data\map\mapcontrol\fuelstation_ca.paa";
    MPRESET(_baseIcon)                                              = "\a3\ui_f\data\map\markers\nato\o_support.paa";
    MPRESET(_cityIcon)                                              = "\a3\ui_f\data\map\markers\nato\n_art.paa";
    MPRESET(_metropolisIcon)                                        = "\a3\ui_f\data\map\markers\nato\n_service.paa";
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_sectors_onPreInit] Initialized", "PRE] [SECTORS", true] call KPLIB_fnc_common_log;
};

true;
