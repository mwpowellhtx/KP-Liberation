#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onTriggerActivation

    File: fn_ieds_onTriggerActivation.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 22:03:28
    Last Update: 2021-06-14 17:09:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        TRIGGER ACTIVATION callback detonates the IED.

    Parameter(s):
        _trigger - the TRIGGER object [OBJECT, default: objNull]

    Returns:
        The callback finished [BOOL]
 */

params [
    [Q(_trigger), objNull, [objNull]]
    , [Q(_list), [], [[]]]
];

private _unitCount = ({ _x distance2D _trigger <= 25; } count allUnits);

private _debug = _unitCount > 0 && (MPARAM(_onTriggerActivation_debug)
    || (_trigger getVariable [QMVAR(_onTriggerActivation_debug), false]));

if (_debug) then {
    ["[fn_ieds_onTriggerActivation] Entering...", "IEDS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: this or we look for the nearest mine to the trigger, which should be the same pos...
private _target = _trigger getVariable [Q(KPLIB_triggers_target), objNull];
// // TODO: TBD: may not need to influence LIST of UNITS, or nearby UNITS, at all...
// private _units = _list select { alive _x && _x isEqualTo vehicle _x; };

private _targetGc = false;

// Key is setting TARGET (IED) damage to 1 after which GC TARGET+TRIGGER
if (!isNull _target) then {
    _target setDamage 1; // TODO: TBD: and this will work?
    [_target] spawn { sleep 30; _this call MFUNC(_onGC); };
    _targetGc = true;
};

private _triggerGc = [_trigger] call KPLIB_fnc_triggers_onGC;

if (_debug) then {
    [format ["[fn_ieds_onTriggerActivation] Fini: [_targetGc, _triggerGc]: %1"
        , str [_targetGc, _triggerGc]], "IEDS", true] call KPLIB_fnc_common_log;
};

_targetGc && _triggerGc;
