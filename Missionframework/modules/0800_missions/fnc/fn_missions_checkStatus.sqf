// So... the patterns may be similar with LOGISTICS, but the key is the included elements
#include "script_component.hpp"
/*
    KPLIB_fnc_missions_checkStatus

    File: fn_missions_checkStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 01:59:06
    Last Update: 2021-03-20 01:59:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks either the raw bitwise STATUS or that of the hosting CBA MISSION namespace.

    Parameter(s):
        _target - the status flags [SCALAR, default: KPLIB_mission_status_standby], or:
            a CBA MISSION namespace [LOCATION]
        _mask - the bit flags mask to check [SCALAR, default: KPLIB_mission_status_standby]

    Returns:
        Checks either the raw STATUS or that of the hosting CBA MISSION namespace [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

[
    MSTATUS(_standby)
] params [
    Q(_standby)
];

params [
    [Q(_target), _standby, [0, locationNull]]
    , [Q(_mask), _standby, [0]]
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

private _onCheckNamespace = {
    params [
        [Q(_namespace), locationNull, [locationNull]]
        , [Q(_mask), _standby, [0]]
    ];

    ([_namespace, [
        [QMVAR(_status), _standby]
    ]] call KPLIB_fnc_namespace_getVars) params [
        Q(_status)
    ];

    [_status, _mask] call _onCheckRaw;
};

switch (true) do {

    case (_target isEqualType _standby): {
        [_target, _mask] call _onCheckRaw;
    };

    case (_target isEqualType locationNull): {
        [_target, _mask] call _onCheckNamespace;
    };

    default { false; };
};
