/*
    KPLIB_fnc_common_onKilled

    File: fn_common_onKilled.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-13 10:23:03
    Last Update: 2021-06-14 16:38:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Event handler occurs on UNIT KILLED event. Typocally MAN or CAMANBASE objects,
        but may also be applied for actual VEHICLE objects, we think.

    Parameters:
        _target - a target object [OBJECT, default: objNull]
        _killer - a killer object [OBJECT, default: objNull]
        _instigator - an instigator object [OBJECT, default: objNull]
        _useEffects - whether effects are used [BOOL, default: false]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

params [
    ["_target", objNull, [objNull]]
    , ["_killer", objNull, [objNull]]
    , ["_instigator", objNull, [objNull]]
    , ["_useEffects", false, [false]]
];

private _debug = KPLIB_param_common_onKilled_debug
    || (_target getVariable ["KPLIB_common_onKilled_debug", false])
    || (_killer getVariable ["KPLIB_common_onKilled_debug", false])
    || (_instigator getVariable ["KPLIB_common_onKilled_debug", false])
    ;

if (_debug) then {
    [format ["[fn_common_onKilled] Entering: [typeOf _target, typeOf _killer, typeOf _instigator, _useEffects]: %1"
        , str [typeOf _target, typeOf _killer, typeOf _instigator, _useEffects]], "COMMON", true] call KPLIB_fnc_common_log;
};

if (!isNull _target) then {
    [
        {
            [_this] call KPLIB_fnc_common_disembarkCrew;
            deleteVehicle _this;
        }
        , _target
        , KPLIB_param_common_gcTimeoutOnKilled
    ] call CBA_fnc_waitAndExecute;
};

if (_debug) then {
    ["[fn_common_onKilled] Fini", "COMMON", true] call KPLIB_fnc_common_log;
};

true;
