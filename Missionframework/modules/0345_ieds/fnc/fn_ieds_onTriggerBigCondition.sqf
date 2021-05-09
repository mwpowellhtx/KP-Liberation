#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onTriggerBigCondition

    File: fn_ieds_onTriggerBigCondition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 21:45:00
    Last Update: 2021-05-09 00:43:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Condition periodically evaluated by TRIGGER associated with the IED. Triggers
        detonation when there are sufficient count of UNITS running, or when there are
        similarly sufficient counts of VEHICLES rolling, or TANK VEHICLES period.

    Parameter(s):
        _trigger - the TRIGGER object [OBJECT, default: objNull]
        _list - ARRAY of the objects identified by the TRIGGER [ARRAY, default: []]
        _activation - initial condition evaluated by the TRIGGER [BOOL, default: false]

    Returns:
        Whether the TRIGGER ought to be ACTIVATED from this point forward [BOOL]
 */

params [
    [Q(_trigger), objNull, [objNull]]
    , [Q(_list), [], [[]]]
    , [Q(_activation), false, [false]]
];

private _unitCount = ({ _x distance2D _trigger <= 25; } count allUnits);

private _debug = _unitCount > 0 && (MPARAM(_onTriggerBigCondition_debug)
    || (_trigger getVariable [QMVAR(_onTriggerBigCondition_debug), false]));

[
    _trigger getVariable [Q(KPLIB_triggers_target), objNull]
    , _trigger getVariable [Q(KPLIB_triggers_uuid), ""]
] params [
    Q(_target)
    , Q(_uuid)
];

if (_debug) then {
    [format ["[fn_ieds_onTriggerBigCondition] Entering: [_uuid, isNull _target]: %1"
        , str [_uuid, isNull _target]], "IEDS", true] call KPLIB_fnc_common_log;
};

// TARGET IED went away for whatever reason, 1. DISARMED 2. DETONATED
if (isNull _target) exitWith {
    [_trigger] call KPLIB_fnc_triggers_onGC;
    false;
};

// Identify UNITS+VEHICLES apart from each other
private _units = _list select { alive _x && _x isEqualTo vehicle _x; };
private _vehicles = _list select { alive _x && _x in vehicles; };

private _runningCount = ({ abs speed _x >= MPARAM(_unitApproachSafeSpeed); } count _units);
private _rollingCount = ({ abs speed _x >= MPARAM(_vehicleApproachSafeSpeed); } count _vehicles);
private _trackedCount = ({ abs speed _x > 0 && _x isKindOf Q(Tank); } count _vehicles);

private _actual = random 1;
private _chance = PCT(MPARAM(_bigDetonationChance));
private _runningThreshold = MPARAM(_bigRunningThreshold);

if (_debug) then {
    [format ["[fn_ieds_onTriggerBigCondition] Fini: [_actual, _chance, _runningThreshold, _runningCount, _rollingCount, _trackedCount]: %1"
        , str [_actual, _chance, _runningThreshold, _runningCount, _rollingCount, _trackedCount]], "IEDS", true] call KPLIB_fnc_common_log;
};

_actual <= _chance && (
    (_rollingCount + _trackedCount) > 0
        || _runningCount >= _runningThreshold
);
