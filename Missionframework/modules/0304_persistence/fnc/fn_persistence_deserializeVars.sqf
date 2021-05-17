/*
    KPLIB_fnc_persistence_deserializeVars

    File: fn_persistence_deserializeVars.sqf
    Author: Michael W. Powell
    Created: 2021-02-14 13:09:40
    Last Update: 2021-02-14 13:09:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads the variables from their serialized state and sets them on the '_target'

    Parameter(s):
        _target - the target object or unit [OBJECT, default: objNull]
        _varDatum - the variable datum element [ARRAY, default: '_varDatumDefault']
        _varDatumDefault - ['_var', '_val', '_global'];

    Returns:
        Function reached the end [BOOL]
 */

private _debug = [] call KPLIB_fnc_persistence_debug;

//params [
//    ["_target", objNull, [objNull]]
//    , ["_varDatum", [], [[]], 3]
//];

// TODO: TBD: troubleshooting why we cannot receive the params? or maybe the validation is breaking down?
params [
    ["_target", objNull, [objNull]]
    , ["_varDatum", [], [[]], 3]
];

if (_debug) then {
    [format ["[fn_persistence_deserializeVars] Given: [str _target, typeOf _target, _varDatum]: %1"
        , str [str _target, typeOf _target, _varDatum]], "SAVE"] call KPLIB_fnc_common_log;
};

_varDatum params [
    ["_var", "", [""]]
    , "_val"
    , ["_global", true, [false]]
];

if (_var isEqualTo "" || isNil "_val") exitWith {

    if (_debug) then {
        [format ["[fn_persistence_deserializeVars] Variable or value error: [str _target, _var, isNil '_var']: %1"
            , str [str _target, _var, isNil '_var']], "SAVE"] call KPLIB_fnc_common_log;
    };

    false;
};

_target setVariable [_var, _val, _global];

/* Yes, re-add persistent variable. Why? Glad you asked: such that, even if module
 * that added it originally is not present, the information itself will not be lost.
 * Will be up to module authors to perform their own clean up; activities as such TBD.
 * However, as such, should also respect whether those variables were global in nature. */

[_var, _global] call KPLIB_fnc_persistence_addPersistentVars;
