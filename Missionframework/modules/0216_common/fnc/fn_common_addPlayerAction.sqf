/*
    KPLIB_fnc_common_addPlayerAction

    File: fn_common_addPlayerAction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-24 09:55:04
    Last Update: 2021-05-24 09:55:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds the PLAYER ACTION given the ACTION ARRAY. May specify whether to LOCALIZE,
        and an optional COLOR with which to render, via an ASSOCIATIVE ARRAY of OPTIONS.

    Parameter(s):
        _actionArray - an ACTION ARRAY
        _options - an ASSOCIATIVE ARRAY of options [ARRAY, default: []]
            [
                ['_localize', true]
                , ['_color', '']
                , ['_varName', '']
                , ['_formatArgs', '']
            ]

    Returns:
        The action ID that was added [SCALAR, default: -1]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
        https://community.bistudio.com/wiki/addAction#Syntax

    See also:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_removePlayerAction-sqf.html#CBA_fnc_removePlayerAction
        https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_addPlayerAction.sqf
 */

private _player = player;

params [
    ["_actionArray", [], [[]]]
    , ["_options", [], [[]]]
];

private _debug = KPLIB_param_common_addPlayerAction_debug
    || (_player getVariable ["KPLIB_common_addPlayerAction_debug", false])
    ;

if (_debug) then {
    [format ["[fn_common_addPlayerAction] Entering: [_actionArray#0, _options]: %1"
        , str [_actionArray#0, _options]], "COMMON", true] call KPLIB_fnc_common_log;
};

// Adds an ACTION to the PLAYER, allowing for the same, consistent treatment of ACTION ARRAY, OPTIONS, etc
private _id = [_player, _actionArray, _options, { [_this] call CBA_fnc_addPlayerAction; }] call KPLIB_fnc_common_addAction;

if (_debug) then {
    [format ["[fn_common_addPlayerAction] Fini: [_id]: %1"
        , str [_id]], "COMMON", true] call KPLIB_fnc_common_log;
};

_id;