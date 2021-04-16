#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onCombatAirPatrolMissionEntered

    File: fn_sectorsSM_onCombatAirPatrolMissionEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-13 20:16:27
    Last Update: 2021-04-13 20:16:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        COMBAT AIR PATROL (CAP) MISSION 'onStateEntered' event handler.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onCombatAirPatrolMissionEntered_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorsSM_onCombatAirPatrolMissionEntered] Entering: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: the mission, then raise the flag signaling we can leave the state...
if (true) then {
    [_namespace, MSTATUS(_combatAirPatrolMission), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;

    // // TODO: TBD: which mission should keep track of its origin and respond when complete, if possible...
    // [_namespace, MSTATUS(_complete), { true; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
};

if (_debug) then {
    [format ["[fn_sectorsSM_onCombatAirPatrolMissionEntered] Fini: [_markerName]: %1"
        , str [_markerName]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
