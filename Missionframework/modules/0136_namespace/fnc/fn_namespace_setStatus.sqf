#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_setStatus

    File: fn_namespace_setStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 11:40:22
    Last Update: 2021-06-25 15:11:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Conditionally sets the masked bitflags from the target and returns
        with the target in its changed condition.

    Parameters:
        _target - a SCALAR bitmask, or target hosting the same [SCALAR, LOCATION, OBJECT; default: _zed]
        _mask - a bitflags mask used to set [SCALAR, default: _zed]
        _predicate - the condition used to check prior to fulfilling the request [CODE, default: _defaultPredicate]
        _variableName - optional variable name used to lift the bitmask from a target OBJECT [STRING, default: ""]

    Returns:
        The target element in its changed state [SCALAR, OBJECT]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsSet
 */

private _zed = 0;
private _defaultPredicate = { true; };

params [
    [Q(_target), _zed, [0, locationNull, objNull]]
    , [Q(_mask), _zed, [0]]
    , [Q(_predicate), _defaultPredicate, [{}]]
    , [Q(_variableName), "", [""]]
];

private _onSetStatus = {
    params [
        [Q(_status), _zed, [0]]
        , [Q(_mask), _zed, [0]]
    ];
    [_status, _mask] call BIS_fnc_bitflagsSet;
};

private _onSetTargetStatus = {
    params [
        [Q(_target), objNull, [locationNull, objNull]]
        , [Q(_mask), _zed, [0]]
    ];

    private _status = _target getVariable [_variableName, _zed];

    [_target, [
        [_variableName, ([_status, _mask] call _onSetStatus)]
    ]] call KPLIB_fnc_namespace_setVars;

    _target;
};

if ([_target, _mask] call _predicate) then {

    _target = switch (true) do {

        case (_target isEqualType _zed): {
            [_target, _mask] call _onSetStatus;
        };

        case (_target isEqualType locationNull);
        case (_target isEqualType objNull): {
            [_target, _mask] call _onSetTargetStatus;
        };

        default { _target; };
    };
};

_target;
