/*
    KPLIB_fnc_persistence_addPersistentVars

    File: fn_persistence_addPersistentVars.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-14 12:57:32
    Last Update: 2021-02-14 12:29:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Add object variables to persistence system.
        Variables should contain simple data only, i.e. no objects, etc.

    Parameter(s):
        _variableNameOrNames - The name or names of variables which should be saved [STRING, or ARRAY of STRING]
        _global         - Whether variables are global [BOOL, default: false]

    Returns:
        Variables were added to persistence system [BOOL]
 */

private _debug = [] call KPLIB_fnc_persistence_debug;

params [
    "_variableNameOrNames"
    , ["_global", false, [false]]
];

if (isNil "_variableNameOrNames") exitWith {
    false;
};

private _onEach = {
    private _variableName = _this;
    private _debug = [] call KPLIB_fnc_persistence_debug;

    if (_variableName isEqualTo "") exitWith {
        false;
    };

    // Case is probably fine in this instance, only when we are dealing in 'allVariables' is ie a question
    private _idx = KPLIB_persistenceSavedVars findIf { (_x#0) isEqualTo _variableName; };

    if (_debug) then {
        [format ["[fn_persistence_addPersistentVars::_onEach] Adding or setting variable: [_variableName, _global, _idx]: %1"
            , str [_variableName, _global, _idx]], ""] call KPLIB_fnc_common_log;
    };

    // Already set, so re-set, or pushBack afresh...
    if (_idx >= 0) then {
        KPLIB_persistenceSavedVars set [_idx, [_variableName, _global]];
    } else {
        KPLIB_persistenceSavedVars pushBack [_variableName, _global];
    };

    true;
};

private _retval = switch (typeName _variableNameOrNames) do {
    case "STRING": { [_variableNameOrNames call _onEach]; };
    case "ARRAY": { _variableNameOrNames apply { _x call _onEach; }; };
    default {[]};
};

// There are none that should fail...
(_retval isEqualTo [])
    || (_retval select { !_x } isEqualTo [])
    ;
