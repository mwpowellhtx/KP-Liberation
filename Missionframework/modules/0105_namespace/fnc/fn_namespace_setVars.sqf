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
        _namespace - a CBA namespace [LOCATION, default: locationNull]
        _nameValuePairs - name value associative pairs being set [ARRAY, default: []]

    Returns:
        The callback finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_namespace_setVars_debug}
    ]
] call KPLIB_fnc_debug_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_nameValuePairs", [], [[]]]
    , ["_changedMask", true, [true]]
];

private _names = _nameValuePairs apply { (_x#0); };

private _current = _names apply { _namespace getVariable [_x, -1]; };

private _onUpdateNamespaceMember = {
    _x params [
        ["_variableName", "", [""]]
        , "_value"
    ];
    if (isNil "_value") then {
        if (_debug) then {
            systemChat format ["[fn_namespace_setVars] Nullifying variable: %1", _variableName];
        };
        _namespace setVariable [_variableName, nil];
    } else {
        _namespace setVariable [_variableName, _value];
    };
};

_onUpdateNamespaceMember forEach _nameValuePairs;

private _updated = _names apply { _namespace getVariable [_x, -1]; };

// Reflects whether anything at all about the namespace changed.
private _changedOld = _namespace getVariable [KPLIB_namespace_changed, false];
private _changedNew = _changedOld || (_changedMask && !(_current isEqualTo _updated));

if (_debug && KPLIB_logistics_timer in _names) then {
    [format ["[fn_namespace_setVars] [_nameValuePairs, _current, _updated, _changedOld, _changedMask, _changedNew]: %1"
        , str [_nameValuePairs, _current, _updated, _changedOld, _changedMask, _changedNew]], "NAMESPACE", true] call KPLIB_fnc_common_log;
};

_namespace setVariable [KPLIB_namespace_changed, _changedNew];

true;
