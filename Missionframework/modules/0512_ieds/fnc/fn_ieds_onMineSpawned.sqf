#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_ieds_onMineSpawned

    File: fn_ieds_onMineSpawned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 21:35:37
    Last Update: 2021-06-14 17:09:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to the 'KPLIB_vehicle_created' event.

    Parameter(s):
        _target - a TARGET object being created [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]
 */

private _debug = MPARAM(_onMineSpawned_debug);

params [
    [Q(_target), objNull, [objNull]]
];

private _className = typeOf _target;

// TODO: TBD: IED may be triggered
// TODO: TBD: may also receive damage
// TODO: TBD: which should also trigger it potentially
if (!(_className in MPRESET(_mineClassNames))) exitWith {
    true;
};

private _uuid = [] call KPLIB_fnc_uuid_create_string;

if (_debug) then {
    [format ["[fn_ieds_onMineSpawned] Entering: [typeOf _target, _uuid]: %1"
        , str [typeOf _target, _uuid]], "IEDS", true] call KPLIB_fnc_common_log;
};

// // TODO: TBD: since MINES are technically consider "ammo" then primitives like setVariable will not work...
// _target setVariable [QMVAR(_uuid), _uuid, true];

private _triggerAreaAngle;
private _triggerAreaIsRectangle = false;

private _small = _className in MPRESET(_smallClassNames);

private _area = if (_small) then {
    [
        MPRESET(_smallTriggerAreaRadius)
        , MPRESET(_smallTriggerAreaRadius)
        , _triggerAreaAngle
        , _triggerAreaIsRectangle
        , MPRESET(_smallTriggerAreaHeight)
    ];
} else {
    [
        MPRESET(_bigTriggerAreaRadius)
        , MPRESET(_bigTriggerAreaRadius)
        , _triggerAreaAngle
        , _triggerAreaIsRectangle
        , MPRESET(_bigTriggerAreaHeight)
    ];
};

private _triggerActivationRepeating = true;

private _activation = [
    KPLIB_preset_sideF
    , KPLIB_preset_triggers_typePresent
    , _triggerActivationRepeating
];

private _onTriggerCondition = if (_small) then {
    MFUNC(_onTriggerSmallCondition);
} else {
    MFUNC(_onTriggerBigCondition);
};

private _statementCallbacks = [
    _onTriggerCondition
    , MFUNC(_onTriggerActivation)
];

// Mine spawned in so now we must arrange for its TRIGGER
private _trigger = [_target, _area, _activation, _statementCallbacks] call KPLIB_fnc_triggers_create;

if (_debug) then {
    ["[fn_ieds_onMineSpawned] Fini", "IEDS", true] call KPLIB_fnc_common_log;
};

true;
