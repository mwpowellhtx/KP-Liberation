/*
    KPLIB_fnc_common_addAction

    File: fn_common_addAction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-24 14:19:07
    Last Update: 2021-06-14 16:40:28
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

private _debug = KPLIB_param_common_addAction_debug
    || (_target getVariable ["KPLIB_common_addAction_debug", false])
    ;

_actionArray params [
    ["_title", "", [""]]
];

if (_debug) then {
    [format ["[fn_common_addAction] Entering: [isNull _target, alive _target, typeOf _target, _title, _options]: %1"
        , str [isNull _target, alive _target, typeOf _target, _title, _options]], "COMMON", true] call KPLIB_fnc_common_log;
};

if (isNull _target || !alive _target) exitWith {
    false;
};

// We do use the VARNAME from the options in this instance
private _optionMap = createHashMapFromArray _options;
private _varName = _optionMap getOrDefault ["_varName", ""];

private _id = _target getVariable [_varName, -1];

if (_id >= 0) exitWith {
    if (_debug) then {
        [format ["[fn_common_addAction] Already: [_varName, _id]: %1"
            , str [_varName, _id]], "COMMON", true] call KPLIB_fnc_common_log;
    };
    _id;
};

// This bit of refactor was a little while in coming and deservedly so
_actionArray set [0, [_title, _options] call KPLIB_fnc_common_renderActionTitle];

private _id = _actionArray call _callback;

if (!(_varName isEqualTo "")) then {
    _target setVariable [_varName, _id];
};

if (_debug) then {
    [format ["[fn_common_addAction] Fini: [_id]: %1"
        , str [_id]], "COMMON", true] call KPLIB_fnc_common_log;
};

_id;
