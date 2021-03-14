/*
    KPLIB_fnc_namespace_getVars

    File: fn_namespace_getVars.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 08:09:28
    Last Update: 2021-03-05 15:58:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Retrieves the member variables that make working with a CBA namespace what it is.
        We get the variables in the namespace for use throughout the state machine, for
        instance. If the caller does not need all of them, then do not use them.

    Parameter(s):
        _namespace - a CBA namespace [LOCATION || OBJECT, default: locationNull]
        _nameValuePairs - name and default value associative pairs to retrieve [ARRAY, default: []]

    Returns:
        An array of the namespace member variables for use throughout [ARRAY]
 */

private _debug = [
    [
        {KPLIB_param_namespace_getVars_debug}
    ]
] call KPLIB_fnc_debug_debug;

private _debug_getVar = [
    [
        {KPLIB_param_namespace_getVar_debug}
    ]
] call KPLIB_fnc_debug_debug;

params [
    ["_namespace", locationNull, [objNull, locationNull]]
    , ["_nameValuePairs", [], [[]]]
    , ["_callerName", "", [""]]
];

[
    !(_callerName isEqualTo "") && (_callerName in KPLIB_namespace_debugCallerNames)
] params [
    "_hasCaller"
];

if (_debug && _hasCaller) then {
    [format ["[fn_namespace_getVars::%1] Entering: [_namespace, isNull _namespace, typeName _namespace, _nameValuePairs]: %2"
        , _callerName, str [_namespace, isNull _namespace, typeName _namespace, _nameValuePairs]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

private _retval = _nameValuePairs apply {
    _x params [
        ["_variableName", "", [""]]
        , "_defaultValue"
    ];

    private _args = if (isNil "_defaultValue") then {

        if (_debug_getVar && _hasCaller) then {
            [format ["[fn_namespace_getVars::%1::onApply] Entering: [_namespace, _variableName]: %2"
                , _callerName, str [_namespace, _variableName]], "NAMESPACE", true] call KPLIB_fnc_common_log;
        };

        _variableName;
    } else {

        if (_debug_getVar && _hasCaller) then {
            [format ["[fn_namespace_getVars::%1::onApply] Entering: [_namespace, _variableName, _defaultValue]: %2"
                , _callerName, str [_namespace, _variableName, _defaultValue]], "NAMESPACE", true] call KPLIB_fnc_common_log;
        };

        [_variableName, _defaultValue];
    };

    _namespace getVariable _args;
};

_retval;
