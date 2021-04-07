#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_unsetStatus

    File: fn_namespace_unsetStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 11:44:49
    Last Update: 2021-04-05 11:44:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Conditionally unsets the masked bitflags from the target and returns
        with the target in its changed condition.

    Parameters:
        _target - a target SCALAR bitmask, or target hosting the same [SCALAR, LOCATION, OBJECT; default: _zed]
        _mask - a bitflags mask used to unset [SCALAR, default: _zed]
        _predicate - the condition used to check prior to fulfilling the request [CODE, default: KPLIB_fnc_namespace_defaultStatusPredicate]
        _variableName - optional variable name used to lift the bitmask from a target [STRING, default: ""]

    Returns:
        The target element in its changed state [SCALAR, OBJECT]
 */

private _zed = 0;

params [
    [Q(_target), _zed, [0, locationNull, objNull]]
    , [Q(_mask), _zed, [0]]
    , [Q(_predicate), KPLIB_fnc_namespace_defaultStatusPredicate, [{}]]
    , [Q(_variableName), "", [""]]
];

private _onUnsetStatus = {
    params [
        [Q(_status), _zed, [0]]
        , [Q(_mask), _zed, [0]]
    ];
    [_status, _mask] call BIS_fnc_bitflagsUnset;
};

private _onUnsetTargetStatus = {
    params [
        [Q(_target), objNull, [locationNull, objNull]]
        , [Q(_mask), _zed, [0]]
    ];

    private _status = _target getVariable [_variableName, _zed];

    [_target, [
        [_variableName, [_status, _mask] call _onUnsetStatus]
    ]] call KPLIB_fnc_namespace_setVars;

    _target;
};

if ([_target, _mask] call _predicate) then {

    _target = switch (true) do {

        case (_target isEqualType _zed): {
            [_target, _mask] call _onUnsetStatus;
        };

        case (_target isEqualType locationull);
        case (_target isEqualType objNull): {
            [_target, _mask] call _onUnsetTargetStatus;
        };

        default { _target; };
    };
};

_target;
