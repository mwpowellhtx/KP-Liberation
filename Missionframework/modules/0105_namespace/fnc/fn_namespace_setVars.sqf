/*
    KPLIB_fnc_namespace_setVars

    File: fn_namespace_setVars.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 08:09:28
    Last Update: 2021-03-05 15:59:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Updates the member variables that make working with a CBA namespace what it is.
        We get the variables in the namespace for use throughout the state machine, for
        instance. If the caller does not need all of them, then do not use them.

    Parameter(s):
        _namespace - a CBA namespace [LOCATION || OBJECT, default: locationNull]
        _nameValuePairs - name value associative pairs being set [ARRAY, default: []]

    Returns:
        The callback finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_namespace_setVars_debug}
    ]
] call KPLIB_fnc_debug_debug;

private _debug_setVar = [
    [
        {KPLIB_param_namespace_setVar_debug}
    ]
] call KPLIB_fnc_debug_debug;

params [
    ["_namespace", locationNull, [objNull, locationNull]]
    , ["_nameValuePairs", [], [[]]]
    , ["_changedMask", true, [true]]
    , ["_callerName", "", [""]]
];

[
    !(_callerName isEqualTo "") && (_callerName in KPLIB_namespace_debugCallerNames)
] params [
    "_hasCaller"
];

if (_debug && _hasCaller) then {
    [format ["[fn_namespace_setVars::%1] Entering: [_namespace, isNull _namespace, typeName _namespace, _changedMask]: %2"
        , _callerName, str [_namespace, isNull _namespace, typeName _namespace, _changedMask]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

private _names = _nameValuePairs apply { (_x#0); };
private _current = _names apply { _namespace getVariable [_x, -1]; };

if (_debug && _hasCaller) then {
    [format ["[fn_namespace_setVars::%1] Setting vars: [_namespace, _names, count _current]: %2"
        , _callerName, str [_namespace, _names, count _current]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

{
    _x params [
        ["_variableName", "", [""]]
        , "_value"
    ];
    if (isNil "_value") then {

        if (_debug_setVar && _hasCaller) then {
            [format ["[fn_namespace_setVars::%1] Nullifying var: [_variableName]: %2"
                , _callerName, str [_variableName]], "NAMESPACE", true] call KPLIB_fnc_common_log;
        };

        _namespace setVariable [_variableName, nil];
    } else {

        if (_debug_setVar && _hasCaller) then {
            [format ["[fn_namespace_setVars::%1] Setting var: [_variableName, _value]: %2"
                , _callerName, str [_variableName, _value]], "NAMESPACE", true] call KPLIB_fnc_common_log;
        };

        _namespace setVariable [_variableName, _value];
    };
} forEach _nameValuePairs;

private _updated = _names apply { _namespace getVariable [_x, -1]; };

if (_debug && _hasCaller) then {
    [format ["[fn_namespace_setVars::%1] Vars set: [_namespace, _names, _current isEqualTo _updated]: %2"
        , _callerName, str [_namespace, _names, _current isEqualTo _updated]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

// Reflects whether anything at all about the namespace changed.
private _changedOld = _namespace getVariable [KPLIB_namespace_changed, false];
private _changedNew = _changedOld || (_changedMask && !(_current isEqualTo _updated));

if (_debug && _hasCaller) then {
    [format ["[fn_namespace_setVars::%1] Fini: [_namespace, _names, _changedOld, _changedMask, _changedNew]: %2"
        , _callerName, str [_namespace, _names, _changedOld, _changedMask, _changedNew]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

_namespace setVariable [KPLIB_namespace_changed, _changedNew];

true;
