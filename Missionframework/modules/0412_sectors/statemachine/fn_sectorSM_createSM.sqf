#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_createSM

    File: fn_sectorSM_createSM.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-08 20:57:07
    Last Update: 2021-06-14 16:57:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates the CBA statemachine from the specified configuration '_className'.

    Parameter(s):
        _className - the configuration statemachine class name [STRING, default: MVARSM(_configClassNameDefault)]

    Returns:
        The production CBA statemachine object [LOCATION]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/statemachine/fnc_createFromConfig-sqf.html
 */

private _debug = MPARAMSM(_createSM_debug);

params [
    [Q(_className), MVARSM(_defaultConfigClassName), [""]]
];

if (_debug) then {
    [format ["[fn_sectorSM_createSM] Entering: [_className]: %1"
        , str [_className]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

// Only load the configuration once when required to do so
MVARSM(_configSM) = missionConfigFile >> Q(CfgStateMachines) >> Q(KPLIB) >> _className;

// TODO: TBD: we may want to test for the config path...
MVARSM(_objSM) = [MVARSM(_configSM)] call CBA_statemachine_fnc_createFromConfig;

/* For use throughout the SECTORS state machine, also serves as the singular LIST
 * element, with default empty ACTIVE SECTOR HASHMAP. Defers sitrep-summary until
 * later. */
private _context = [false, {
    _this setVariable [QMVARSM(_activeSectorMap), createHashMap];
}] call KPLIB_fnc_namespace_create;

MVARSM(_objSM) setVariable [QMVARSM(_context), _context];

// // // TODO: TBD: incorporate SM variables, if any...
// // Publication originates from the statemachine object itself
// MVARSM(_objSM) setVariable ["KPLIB_logisticsSM_publicationTimer", (+KPLIB_timers_default)];

if (_debug) then {
    ["[fn_sectorSM_createSM] Finished", "SECTORSM", true] call KPLIB_fnc_common_log;
};

MVARSM(_objSM);
