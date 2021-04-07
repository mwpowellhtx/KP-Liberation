#include "script_component.hpp"
/*
    KPLIB_fnc_namespace_checkStatus

    File: fn_namespace_checkStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 11:30:51
    Last Update: 2021-04-05 11:30:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks either the raw SCALAR STATUS bitmask flags, or the one hosted by the target namespace.

    Parameters:
        _target - the target SCALAR or target namespace [SCALAR, LOCATION, OBJECT; default: _standby]
        _mask - the bitflags mask used to check [SCALAR, default: 0]
        _variableName - optional variable name to use for the target [STRING, default: ""]

    Returns:
        Whether the target bitmask flags contains any bits in the mask [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

private _zed = 0;

params [
    [Q(_target), _zed, [0, locationNull, objNull]]
    , [Q(_mask), _zed, [0]]
    , [Q(_variableName), "", [""]]
];

private _onCheckStatus = {
    params [
        [Q(_status), _zed, [0]]
        , [Q(_mask), _zed, [0]]
    ];
    // Allowing for a zeroed status
    (_mask == 0 && _status == _mask)
        || ([_status, _mask] call BIS_fnc_bitflagsCheck);
};

private _onCheckTarget = {
    params [
        [Q(_target), objNull, [locationNull, objNull]]
        , [Q(_mask), _zed, [0]]
    ];
    [_target getVariable [_variableName, 0], _mask] call _onCheckStatus;
};

switch (true) do {

    case (_target isEqualType _zed): {
        [_target, _mask] call _onCheckStatus;
    };

    case (_target isEqualType locationNull);
    case (_target isEqualType objNull): {
        [_target, _mask] call _onCheckTarget;
    };

    default { false; };
};
