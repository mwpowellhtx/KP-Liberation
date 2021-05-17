// So... the patterns may be similar with LOGISTICS, but the key is the included elements
#include "script_component.hpp"
/*
    KPLIB_fnc_mission_unsetStatus

    File: fn_mission_unsetStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 02:11:23
    Last Update: 2021-03-20 02:11:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Unsets the STATUS on either a TARGET STATUS itself, or via its hosting CBA MISSION namespace.

    Parameter(s):
        _target - a status flags [SCALAR, default: KPLIB_mission_status_standby], or:
            a CBA MISSION namespace [LOCATION]
        _mask - the bit flags mask to unset [SCALAR, default: KPLIB_mission_status_standby]
        _predicate - predicate callback used to indicate whether to unset [CODE, default: _always]

    Returns:
        The TARGET argument [SCALAR, or LOCATION]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

[
    { true; }
    , MSTATUS1(_standby)
] params [
    Q(_always)
    , Q(_standby)
];

params [
    [Q(_target), _standby, [0, locationNull]]
    , [Q(_mask), _standby, [0]]
    , [Q(_predicate), _always, [{}]]
];

private _onUnsetStatusRaw = {
    params [
        [Q(_status), _standby, [0]]
        , [Q(_mask), _standby, [0]]
    ];
    [_status, _mask] call BIS_fnc_bitflagsUnset;
};

private _onUnsetStatusNamespace = {
    params [
        [Q(_namespace), locationNull, [locationNull]]
        , [Q(_mask), _standby, [0]]
    ];

    ([_namespace, [
        [QMVAR1(_status), _standby]
    ]] call KPLIB_fnc_namespace_getVars) params [
        Q(_status)
    ];

    [_namespace, [
        [QMVAR1(_status), [_status, _mask] call _onUnsetStatusRaw]
    ]] call KPLIB_fnc_namespace_setVars;

    _namespace;
};

if ([_target, _mask] call _predicate) then {

    _target = switch (true) do {

        case (_target isEqualType _standby): {
            [_target, _mask] call _onUnsetStatusRaw;
        };

        case (_target isEqualType locationNull): {
            [_target, _mask] call _onUnsetStatusNamespace;
        };

        default { _target; };
    };
};

_target;
