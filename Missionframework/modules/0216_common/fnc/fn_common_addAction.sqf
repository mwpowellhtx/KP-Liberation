/*
    KPLIB_fnc_common_addAction

    File: fn_common_addAction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-24 14:19:07
    Last Update: 2021-05-24 14:19:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds the ACTION to the TARGET by default, allowing for consistent ACTION ARRAY
        and OPTIONS treatment. Callers may LOCALIZE the text, and may add a COLOR, as well
        as specify further arguments to the localized format string. Default is adding an
        ACTION to the TARGET, but the caller may receive the ACTION ARRAY for his own use,
        i.e. CBA_fnc_addPlayerAction.

    Parameter(s):
        _actionArray - an ACTION ARRAY for use when creating the menu [ARRAY, default: []]
        _options - an ASSOCIATIVE ARRAY of options [ARRAY, default: []]
            _localize - whether the ACTION ARRAY TITLE should be localized [BOOL, default: true]
            _color - an optional COLOR string, [STRING, default, '']
            _formatArgs - format arguments relayed during the localize [ARRAY, default: []]

    Returns:
        The action ID that was added [SCALAR, default: -1]

    References:
        https://community.bistudio.com/wiki/addAction#Syntax
        https://community.bistudio.com/wiki/getOrDefault
        https://community.bistudio.com/wiki/createHashMapFromArray
 */

// This key focusing ACTION on the TARGET, i.e. non-PLAYER object
private _defaultCallback = { _target addAction _this; };

params [
    ["_target", objNull, [objNull]]
    , ["_actionArray", [], [[]]]
    , ["_options", [], [[]]]
    , ["_callback", _defaultCallback, [{}]]
];

_actionArray params [
    ["_title", "", [""]]
];

private _debug = KPLIB_param_common_addAction_debug
    || (_target getVariable ["KPLIB_common_addAction_debug", false])
    ;

if (_debug) then {
    [format ["[fn_common_addAction] Entering: [isNull _target, alive _target, typeOf _target, _title, _options]: %1"
        , str [isNull _target, alive _target, typeOf _target, _title, _options]], "COMMON", true] call KPLIB_fnc_common_log;
};

if (isNull _target || !alive _target) exitWith {
    false;
};

private _optionMap = createHashMapFromArray _options;
private _varName = _optionMap getOrDefault ["_varName", ""];

if (!(_varName isEqualTo "")) then {
    private _targetId = _target getVariable [_varName, -1];
    if (_targetId >= 0) exitWith {
        if (_debug) then {
            [format ["[fn_common_addAction] Already: [_varName, _targetId]: %1"
                , str [_varName, _targetId]], "COMMON", true] call KPLIB_fnc_common_log;
        };
        _targetId;
    };
};

private _optionMapArgs = [
    ["_localize", true]
    , ["_color", ""]
    , ["_formatArgs", []]
];

private _optionValues = _optionMapArgs apply { _optionMap getOrDefault _x; };

_optionValues params ["_localize", "_color", "_formatArgs"];

if (_localize || !(_color isEqualTo "")) then {
    private _localized = if (!_localize) then { _title; } else {
        format ([localize _title] + _formatArgs);
    };

    if (_debug) then {
        [format ["[fn_common_addAction] Localized: [_title, _localized]: %1"
            , str [_title, _localized]], "COMMON", true] call KPLIB_fnc_common_log;
    };

    _actionArray set [0, if (_color isEqualTo "") then { _localized; } else {
        private _rendered = format ["<t color='%1'>%2</t>", _color, _localized];

        if (_debug) then {
            [format ["[fn_common_addAction] Color: [_rendered]: %1"
                , str [_rendered]], "COMMON", true] call KPLIB_fnc_common_log;
        };

        _rendered;
    }];
};

private _id = _actionArray call _callback;

if (!(_varName isEqualTo "")) then {
    _target setVariable [_varName, _id];
};

if (_debug) then {
    [format ["[fn_common_addAction] Fini: [_id]: %1"
        , str [_id]], "COMMON", true] call KPLIB_fnc_common_log;
};

_id;
