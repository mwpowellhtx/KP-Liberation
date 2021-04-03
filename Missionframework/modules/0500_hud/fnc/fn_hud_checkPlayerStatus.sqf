#include "script_component.hpp"
/*
    KPLIB_fnc_hud_checkPlayerStatus

    File: fn_hud_checkPlayerStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks either the raw SCALAR STATUS bitmask flags, or the one hosted
        by a PLAYER OBJECT.

    Parameters:
        _target - the target SCALAR or PLAYER OBJECT [SCALAR, OBJECT; default: _standby]
        _mask - the bitflags mask used to check
        _variableName - optional variable name to use for the PLAYER OBJECT
            [STRING, default: KPLIB_hudDispatchSM_standbyStatus]

    Returns:
        Whether the target bitmask flags contains any bits in the mask [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

private _standby = MSTATUS(_standby);

params [
    [Q(_target), _standby, [0, objNull]]
    , [Q(_mask), _standby, [0]]
    , [Q(_variableName), KPLIB_hudDispatchSM_standbyStatus, [""]]
];

private _onCheckRaw = {
    params [
        [Q(_status), _standby, [0]]
        , [Q(_mask), _standby, [0]]
    ];
    // Allowing for a zeroed status
    (_mask == _standby && _status == _mask)
        || ([_status, _mask] call BIS_fnc_bitflagsCheck);
};

private _onCheckPlayer = {
    params [
        [Q(_player), objNull, [objNull]]
        , [Q(_mask), _standby, [0]]
    ];
    [_player getVariable [_variableName, _standby], _mask] call _onCheckRaw;
};

switch (true) do {

    case (_target isEqualType _standby): {
        [_target, _mask] call _onCheckRaw;
    };

    // TODO: TBD: 'player' is an objNull type (?)
    case (_target isEqualType objNull): {
        [_target, _mask] call _onCheckPlayer;
    };

    default { false; };
};
