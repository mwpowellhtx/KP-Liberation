/*
    KPLIB_fnc_logisticsCO_onMissionReroute

    File: fn_logisticsCO_onMissionReroute.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 13:02:33
    Last Update: 2021-03-13 13:02:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]

    References:
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionReroute_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_uuid", ""]
    , ["KPLIB_logistics_timer", +KPLIB_timers_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
    , "_oldTimer"
];

// Deconstruct the mission critical bits that got presented to the callback
([_changeOrder, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , ["KPLIB_logistics_cid", -1]
    , ["KPLIB_logistics_alphaEndpoint", []]
    , ["KPLIB_logistics_bravoEndpoint", []]
    , ["KPLIB_logistics_allEndpoints", []]
    , ["KPLIB_logistics_bluforSectors", []]
    , ["KPLIB_logistics_alphaIsEndpoint", false]
    , ["KPLIB_logistics_bravoIsEndpoint", false]
    , ["KPLIB_logistics_alphaIsFactory", false]
    , ["KPLIB_logistics_bravoIsFactory", false]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_cid"
    , "_alpha"
    , "_bravo"
    , "_allEndpoints"
    , "_bluforSectors"
    , "_alphaIsEndpoint"
    , "_bravoIsEndpoint"
    , "_alphaIsFactory"
    , "_bravoIsFactory"
];

// Identify the old TIMER elements as reference
_oldTimer params [
    "_oldDuration"
    , "_oldStartTime"
    , "_oldElapsedTime"
    , "_oldTimeRemaining"
];

// Also identify the old ENDPOINT bits as reference
_alpha params [
    ["_alphaPos", +KPLIB_zeroPos, [[]], 3]
    , ["_alphaMarker", "", [""]]
    , ["_alphaMarkerText", "", [""]]
    , ["_alphaBillValue", +KPLIB_resources_storageValueDefault, [[]], 3]
];

_bravo params [
    ["_bravoPos", +KPLIB_zeroPos, [[]], 3]
    , ["_bravoMarker", "", [""]]
    , ["_bravoMarkerText", "", [""]]
    , ["_bravoBillValue", +KPLIB_resources_storageValueDefault, [[]], 3]
];

// TODO: TBD: may want to set transport speed as a logistics line member
// TODO: TBD: why is that, because once it is set, we do not want to lose calibration with the setting afterwards
// TODO: TBD: however this is a broader question than just this change order...

// TODO: TBD: may not need "actual" distances at all, as long as timers, elapsed, etc, will suffice...
private _oldDistance = _alphaPos distance2D _bravoPos;
private _transportSpeedMps = [] call KPLIB_fnc_logistics_calculateTransportSpeedMps;

// Remember, we are here because at least one ENDPOINT must be recalibrated
private _processed = [
    _targetUuid
    , [_alpha, _bravo, _alphaIsEndpoint, _allEndpoints] call KPLIB_fnc_logistics_getEndpointOrNearest
    , [_bravo, _alpha, _bravoIsEndpoint, _allEndpoints] call KPLIB_fnc_logistics_getEndpointOrNearest
] call {
    params [
        ["_targetUuid", "", [""]]
        , ["_alpha", [], [[]], 4]
        , ["_bravo", [], [[]], 4]
    ];

    // TODO: TBD: verify ALPHA and BRAVO ENDPOINTS with 'KPLIB_fnc_logistics_verifyEndpoint'
    // TODO: TBD: then log, and/or proceed...

    // Submit the CHANGE ORDER for immediate processing
    private _onInitializeRerouteChangeOrder = {
        // There is no client owner since this is an AUTOMATED CHANGE ORDER
        [_this, [
            ["KPLIB_logistics_targetUuid", _targetUuid]
            , ["KPLIB_logistics_endpoints", +[_alpha, _bravo]]
            , [KPLIB_changeOrders_onChangeOrder, KPLIB_fnc_logisticsCO_onMissionConfirm]
            , [KPLIB_changeOrders_onChangeOrderEntering, KPLIB_fnc_logisticsCO_onMissionConfirmEntering]
        ]] call KPLIB_fnc_namespace_setVars;
    };

    private _rerouteChangeOrder = [_onInitializeRerouteChangeOrder] call KPLIB_fnc_changeOrders_create;

    [_namespace, _rerouteChangeOrder, true] call KPLIB_fnc_changeOrders_processOne;
};

// TODO: TBD: add CBA setting, whether to automatically "abort" a rerouted line...
// TODO: TBD: add CBA setting, the penalty for doing so... for now will assume 50%
KPLIB_param_logistics_reroutedTransitPenalty = 0.5;

private _penalized = if (!_processed) then {
    false;
} else {
    [_namespace, (_oldElapsedTime * KPLIB_param_logistics_reroutedTransitPenalty)] call {
        params [
            ["_namespace", locationNull, [locationNull]]
            , ["_reroutedTimeDelta", 0, [0]]
        ];

        ([_namespace, [
            ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
            , ["KPLIB_logistics_timer", +KPLIB_timers_default]
        ]] call KPLIB_fnc_namespace_getVars) params [
            "_newStatus"
            , "_newTimer"
        ];

        // // TODO: TBD: whether to add an abandoned mask, or simply log it and re-route...
        // private _abandonedMask = KPLIB_logistics_status_abandoned + KPLIB_logistics_status_aborting;
        // _status = [_status, _abandonedMask] call KPLIB_fnc_logistics_setStatus;

        // Whatever else the operation is doing, we are also clearing the ABANDONED flag
        _newStatus = [_newStatus, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_unsetStatus;

        // Identify the new TIMER elements as reference
        _newTimer params [
            "_newDuration"
            , "_newStartTime"
            , "_newElapsedTime"
            , "_newTimeRemaining"
        ];

        private _reroutedTimer = [
            _newDuration
            , _newStartTime
            , (_newElapsedTime + _reroutedTimeDelta) min _newDuration
            , 0 max (_newTimeRemaining - _reroutedTimeDelta)
        ];

        [_namespace, [
            ["KPLIB_logistics_status", _newStatus]
            , ["KPLIB_logistics_timer", _reroutedTimer call KPLIB_fnc_timers_rebase]
        ]] call KPLIB_fnc_namespace_setVars;

        true;
    };
};

_processed && _penalized;
