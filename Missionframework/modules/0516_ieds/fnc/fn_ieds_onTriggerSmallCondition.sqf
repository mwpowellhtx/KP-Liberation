#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onTriggerSmallCondition

    File: fn_ieds_onTriggerSmallCondition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 21:45:08
    Last Update: 2021-05-25 13:17:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Condition periodically evaluated by TRIGGER associated with the IED.

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

private _debug = _unitCount > 0 && (MPARAM(_onTriggerSmallCondition_debug)
    || (_trigger getVariable [QMVAR(_onTriggerSmallCondition_debug), false]));

[
    _trigger getVariable [Q(KPLIB_triggers_target), objNull]
    , _trigger getVariable [Q(KPLIB_triggers_uuid), ""]
] params [
    Q(_target)
    , Q(_uuid)
];

if (_debug) then {
    [format ["[fn_ieds_onTriggerSmallCondition] Entering: [_uuid, isNull _target]: %1"
        , str [_uuid, isNull _target]], "IEDS", true] call KPLIB_fnc_common_log;
};

// TARGET IED went away for whatever reason, 1. DISARMED 2. DETONATED
if (isNull _target) exitWith {
    [_trigger] call KPLIB_fnc_triggers_onGC;
    false;
};

// We only want the UNIT objects themselves
private _units = _list select { alive _x &&  _x isEqualTo vehicle _x; };
private _vehicles = _list select { alive _x && _x in vehicles; };

private _runningCount = ({ ([_x] call KPLIB_fnc_common_getMomentum) >= MPARAM(_unitApproachSafeSpeed); } count _units);
private _rollingCount = ({ ([_x] call KPLIB_fnc_common_getMomentum) >= MPARAM(_vehicleApproachSafeSpeed); } count _vehicles);

private _runningThreshold = MPARAM(_smallRunningThreshold);
private _actual = random 1;
private _chance = PCT(MPARAM(_smallDetonationChance));

if (_debug) then {
    [format ["[fn_ieds_onTriggerSmallCondition] Fini: [_actual, _chance, _runningThreshold, _runningCount, _rollingCount]: %1"
        , str [_actual, _chance, _runningThreshold, _runningCount, _rollingCount]], "IEDS", true] call KPLIB_fnc_common_log;
};

_actual <= _chance && (
    _runningCount >= _runningThreshold
        || _rollingCount > 0
);
