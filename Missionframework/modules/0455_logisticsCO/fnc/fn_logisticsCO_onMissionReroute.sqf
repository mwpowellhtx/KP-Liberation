/*
    KPLIB_fnc_logisticsCO_onMissionReroute

    File: fn_logisticsCO_onMissionReroute.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 13:02:33
    Last Update: 2021-03-13 13:02:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Closes the loop on the REROUTE MISSION request in a few, key, high level
        phases. First, filter the known ENDPOINTS excluding current MISSION ENDPOINTS.
        Second, reroute MISSION ENDPOINTS accordingly using the FILTERED ENDPOINTS as
        reference. Third, CONFIRM the REROUTED ENDPOINTS as the new mission. Fourth,
        and finally, calculate a new EN_ROUTE TIMER taking into account the MISSION
        STATUS.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]

    Remarks:
        REROUTE is perhaps one of the more involved, esoteric LOGISTICS operational
        response that can occur. At a high level, a REROUTED MISSION identifies zero,
        one or two new ENDPOINTS, depending on availability, conflicts with the current
        ABANDONED MISSION, and so on. The REROUTED MISSION is always places in an
        EN_ROUTE STATUS because it is thought that it simulates the mission having
        backtracked, planned afresh, and accounted for contingencies, etc. Additionally,
        we set the mission in ABORTING STATUS, because the objective is to recover as
        quickly as possible and free up the line for subsequent planning by the COMMANDER
        or LOGISTICIAN.
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
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
];

([_changeOrder, [
    ["KPLIB_logistics_cid", -1]
    , ["KPLIB_logistics_lineEndpoints", []]
    , ["KPLIB_logistics_lineEndpointIndexes", []]
    , ["KPLIB_logistics_candidateEndpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
    , "_lineEps"
    , "_lineEpIndexes"
    , "_canEps"
];

[
    [_namespace, KPLIB_logistics_status_enRoute] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_loading] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_unloading] call KPLIB_fnc_logistics_checkStatus
] params [
    "_enRoute"
    , "_loading"
    , "_unloading"
];

// TODO: TBD: we may need the indexes at this level, but for now, disregard them...

/* Normalize to a standard [ALPHA, BRAVO] form factor; we should be "here" with a
 * running LOGISTIC LINE, with correct [ALPHA, BRAVO] form factor, but normalize
 * anyway as a precaution.
 */
private _normalizedEps = [_lineEps] call KPLIB_fnc_logistics_normalizeEndpoints;

/* Allows the known ENDPOINTS where ALPHA was not found, or ALPHA not equal to the
 * ENDPOINT in question. Rinse and repeat also for BRAVO, same sort of criteria. The
 * bottom line here, we want to REROUTE to the next nearest ENDPOINTS that are neither
 * old ALPHA nor old BRAVO. Whether ALPHA or BRAVO feel out of commission approaching
 * this question ought to be irrelevant, should still work as a filter.
 */
private _filteredEps = _normalizedEps call {
    params [
        ["_alpha", [], [[]]]
        , ["_bravo", [], [[]]]
    ];
    _canEps select {
        !(
            // Should match existing ones and ignore abandoned ones just fine
            ([_alpha, _x] call KPLIB_fnc_logistics_areEndpointsEqual)
                || ([_bravo, _x] call KPLIB_fnc_logistics_areEndpointsEqual)
        );
    };
};

// Just process and deal with the intermediate outcomes, short of going nuts and prescreening
private _onRerouteEp = {
    params [
        ["_ep", [], [[]]]
        , ["_epIndex", -1, [0]]
    ];
    // De-con the BILL VALUE in particular, we will append it later on; as well as using other elements
    _ep params [
        ["_epPos", +KPLIB_zeroPos, [[]], 3]
        , ["_epMarker", "", [""]]
        , ["_epMarkerText", "", [""]]
        , ["_epBillValue", +KPLIB_resources_storageValueDefault, [[]], 3]
    ];
    // Default ENDPOINT sans the BILL VALUE element
    private _defaultEp = +[_epPos, _epMarker, _epMarkerText];
    // No need to REROUTE a valid ENDPOINT
    private _reroutedEp = if (_epIndex >= 0) then {
        _defaultEp;
    } else {
        // Otherwise REROUTE making a best effort from the FILTERED ENDPOINTS (^^^ from above ^^^)
        switch (count _filteredEps) do {
            case (0): { _defaultEp; };
            case (1): { +(_filteredEps#0); };
            default {
                // Cannot depend on ENDPOINT MARKER in this instance, so fall back on POSITION
                private _sortedEps = [_filteredEps, [], { ((_x#0) distance2D _epPos); }, "ascend"] call BIS_fnc_sortBy;
                +(_sortedEps#0);
            };
        };
    };
    // Be sure to relay the BILL VALUE in any event
    private _billValueIndex = _reroutedEp pushBack (+_epBillValue);
    _reroutedEp;
};

// REROUTE the ENDPOINTS cutting across LINE ENDPOINT indexes, de-con and evaluate the results
private _reroutedEps = [0, 1] apply { [(_normalizedEps#_x), (_lineEpIndexes#_x)] call _onRerouteEp; };

[
    count _normalizedEps
    , count _reroutedEps
    , {
        private _reroutedEp = _x;
        !([] isEqualTo (_canEps select { [_x, _reroutedEp] call KPLIB_fnc_logistics_areEndpointsEqual; }));
    } count _reroutedEps
    , _reroutedEps call KPLIB_fnc_logistics_areEndpointsEqual
    , ""
] params [
    "_lineEpCount"
    , "_reroutedEpCount"
    , "_verifiedReroutedEpCount"
    , "_epsAreEqual"
    , "_msg"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionReroute] [_lineEpCount, _reroutedEpCount, _verifiedReroutedEpCount, _epsAreEqual, _normalizedEps, _reroutedEps]: %1"
        , str [_lineEpCount, _reroutedEpCount, _verifiedReroutedEpCount, _epsAreEqual, _normalizedEps, _reroutedEps]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

// Rerouted, however could not REROUTE, or MISSION ENDPOINTS cannot be equal
if (((_reroutedEpCount == _lineEpCount) && (_verifiedReroutedEpCount != _reroutedEpCount)) || _epsAreEqual) exitWith {
    _msg = localize "STR_KPLIB_LOGISTICS_MSG_MISSION_CANNOT_REROUTE_INSUFFICIENT";
    if (_debug) then {
        [format ["[fn_logisticsCO_onMissionReroute] %1", _msg], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };
    if (_cid >= 0) then {
        [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };
    false;
};

// TODO: TBD: need to have some ducks in order prior to mission planning...
if (!([_targetUuid, _reroutedEps] call KPLIB_fnc_logisticsCO_onRequestMissionConfirm)) exitWith {
    // TODO: TBD: add logging...
    false;
};

// Map out the REROUTED TIMER...
private _timer = [[_reroutedEps] call KPLIB_fnc_logistics_calculateTransitDuration, _loading, _enRoute, _unloading] call {

    params [
        ["_duration", KPLIB_timers_disabled, [0]]
        , ["_loading", false, [false]]
        , ["_enRoute", false, [false]]
        , ["_unloading", false, [false]]
        , ["_loadingCoef", KPLIB_param_logistics_reroute_loadingCoefficient, [0]]
        , ["_enRouteCoef", KPLIB_param_logistics_reroute_enRouteCoefficient, [0]]
        , ["_unloadingCoef", KPLIB_param_logistics_reroute_unloadingCoefficient, [0]]
    ];

    // Then we must arrange the new mission...
    private _rerouteCoefficient = switch (true) do {
        // Bounded by the neighboring setting
        case (_loading): { _enRouteCoef min _loadingCoef; };
        case (_unloading): { _unloadingCoef max _enRouteCoef; };
        case (_enRoute); default { _enRouteCoef; };
    };

    // De-con bits of the CREATED TIMER for use during REBASE
    ([_duration] call KPLIB_fnc_timers_create) params [
        "_0"
        , ["_startTime", 0, [0]]
    ];

    private _elapsedTime = _rerouteCoefficient * _duration;

    [_duration, _startTime, _elapsedTime, _duration - _elapsedTime] call KPLIB_fnc_timers_rebase;
};

/* Starting with: always EN_ROUTE, just a matter of "when" to consider transit REROUTE; whatever else
 * STATUS got morphed into throughout, does not matter, is now EN_ROUTE afresh, and we rinse and repeat
 * the whole state machine, picking up from this moment forward. One likely outcome, if it means the
 * LINE landed deep in enemy territory and gets BLOCKED, so be it, is highly unlikely that this would
 * not be the outcome, unless the team happens to have liberated a multitude of sectors. Also, ABORTING
 * because we want to free up the line as quickly as possible due to potential conflicts with other
 * lines on account of the ABANDONED recovery.
 */
[_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_enRouteAborting]
    , ["KPLIB_logistics_timer", _timer]
]] call KPLIB_fnc_namespace_setVars;

private _rerouted = true;

if (_rerouted) then {
    _msg = localize "STR_KPLIB_LOGISTICS_MSG_MISSION_REROUTED";
    if (_debug) then {
        [format ["[fn_logisticsCO_onMissionReroute] %1", _msg], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };
    if (_cid >= 0) then {
        [_msg] remoteExec ["KPLIB_fnc_notification_hint", _cid];
    };
};

_rerouted;
