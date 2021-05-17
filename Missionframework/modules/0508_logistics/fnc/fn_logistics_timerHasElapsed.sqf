/*
    KPLIB_fnc_logistics_timerHasElapsed

    File: fn_logistics_timerHasElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-14 16:42:17
    Last Update: 2021-03-14 16:42:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the TARGET logistics timer has elapsed.

    Parameter(s):
        _target - a CBA logistics namespace [LOCATION, default: locationNull], or:
            a logistics tuple [ARRAY]

    Returns:
        Whether the TARGET logistics timer has elapsed [ARRAY]
 */

params [
    ["_target", locationNull, [[], locationNull]]
];

private _hasTupleTimerElapsed = {
    params [
        ["_target", [], [[]]]
    ];

    _target params [
        ["_lineUuid", "", [""]]
        , ["_status", KPLIB_logistics_status_standby, [0]]
        , ["_timer", +KPLIB_timers_default, [[]]]
    ];

    _timer call KPLIB_fnc_timers_hasElapsed;
};

private _hasNamespaceTimerElapsed = {
    params [
        ["_target", locationNull, [locationNull]]
    ];

    ([_target, [
        ["KPLIB_logistics_uuid", ""]
        , ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
        , [KPLIB_logistics_timer, []]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_lineUud"
        , "_status"
        , "_timer"
    ];

    [[_lineUuid, _status, _timer]] call _hasTupleTimerElapsed;
};

switch (true) do {

    case (_target isEqualType []): {
        [_target] call _hasTupleTimerElapsed;
    };

    case (_target isEqualType locationNull): {
        [_target] call _hasNamespaceTimerElapsed;
    };

    default { false; };
};
