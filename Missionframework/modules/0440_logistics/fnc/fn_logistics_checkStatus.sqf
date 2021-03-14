/*
    KPLIB_fnc_logistics_checkStatus

    File: fn_logistics_checkStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 17:08:31
    Last Update: 2021-03-14 11:45:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks either the raw STATUS or that of the hosting CBA logistics namespace.

    Parameter(s):
        _target - the status flags [SCALAR, default: KPLIB_logistics_status_standby], or:
            a CBA logistics namespace [LOCATION]
        _mask - the bit flags mask to check [SCALAR, default: KPLIB_logistics_status_standby]

    Returns:
        Checks either the raw STATUS or that of the hosting CBA logistics namespace [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

params [
    ["_target", KPLIB_logistics_status_standby, [0, locationNull]]
    , ["_mask", KPLIB_logistics_status_standby, [0]]
];

private _onCheckRaw = {
    params [
        ["_status", KPLIB_logistics_status_standby, [0]]
        , ["_mask", KPLIB_logistics_status_standby, [0]]
    ];
    // Allowing for a zeroed status
    (_mask == KPLIB_logistics_status_standby && _status == _mask)
        || ([_status, _mask] call BIS_fnc_bitflagsCheck);
};

private _onCheckNamespace = {
    params [
        ["_namespace", locationNull, [locationNull]]
        , ["_mask", KPLIB_logistics_status_standby, [0]]
    ];

    ([_namespace, [
        ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_status"
    ];

    [_status, _mask] call _onCheckRaw;
};

switch (true) do {

    case (_target isEqualType KPLIB_logistics_status_standby): {
        [_target, _mask] call _onCheckRaw;
    };

    case (_target isEqualType locationNull): {
        [_target, _mask] call _onCheckNamespace;
    };

    default { false; };
};
