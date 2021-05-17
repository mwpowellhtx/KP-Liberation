/*
    KPLIB_fnc_logisticsCO_onMissionAbort

    File: fn_logisticsCO_onMissionAbort.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 12:22:34
    Last Update: 2021-03-14 18:10:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Entering logistics change order activity, this is the moment when that subsystem
        activity may be prohibited.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionAbort_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

// A series of ABORT CONTINGENCIES, in the form, [PREDICATE, CALLBACK]
private _contingencies = [
    [
        { [_namespace, KPLIB_logistics_status_unloading] call KPLIB_fnc_logistics_checkStatus; }
        , KPLIB_fnc_logisticsCO_onAbortUnloading
    ]
    , [
        { [_namespace, KPLIB_logistics_status_loading] call KPLIB_fnc_logistics_checkStatus; }
        , KPLIB_fnc_logisticsCO_onAbortLoading
    ]
    , [
        { [_namespace, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logistics_checkStatus; }
        , KPLIB_fnc_logisticsCO_onAbortEnRoute
    ]
];

// Invoke the first CONTINGENCY CALLBACK whose PREDICATE was aligned
(_contingencies select { [] call (_x#0); }) call {
    // Which deconstructs the "first" contingency matching its predicate
    params [
        ["_contingency", [], [[]]]
    ];

    // If we fail to identify a contingency, i.e. AMBUSH, should be fine in default values
    _contingency params [
        ["_predicate", { true; }, [{}]] // Already selected, no need to repeat
        , ["_callback", { true; }, [{}]] // This is what we want to invoke
    ];

    [_namespace, _changeOrder] call _callback;
};

[
    [_namespace] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_checkStatus
] params [
    "_standby"
    , "_aborting"
];

if (!(_standby || _aborting)) then {
    if (_debug) then {
        [format ["[fn_logisticsCO_onMissionAbort] %1"
            , localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_ABORT"], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    if (_cid >= 0) then {
        [
            localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_ABORT"
        ] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };
};

_standby || _aborting;
