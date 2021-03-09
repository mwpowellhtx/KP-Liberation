/*
    KPLIB_fnc_logisticsCO_onTransportRecycle

    File: fn_logisticsCO_onTransportRecycle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 12:06:32
    Last Update: 2021-03-01 15:07:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Logistics manager requests line transport be recycled. Assumes that change order
        verification has been accepted and we are clear to proceed with the request.

    Parameters:
        _namespace - a CBA logistics namespace for which the change order is happening [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The change order finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onTransportRecycle_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_changeOrder, [
    ["KPLIB_logistics_targetUuid", ""]
    , ["KPLIB_logistics_targetFobMarker", ""]
    , ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
    , "_targetFobMarker"
    , "_cid"
];

if (_debug) then {
    [format ["[fn_logisticsCO_onTransportRecycle] Entering: [_targetUuid, _targetFobMarker, _cid]: %1"
        , str [_targetUuid, _targetFobMarker, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_convoy"
];

// So that we are indeed working with a genuine copy
_convoy = +_convoy;

private _convoyIndex = _convoy findIf {
    (_x isEqualTo KPLIB_resources_storageValueDefault);
};

private _credit = [] call KPLIB_fnc_logisticsCO_getTransportCredit;
_credit params ["_supply", "_ammo", "_fuel"];

private _credited = if (_credit isEqualTo KPLIB_resources_storageValueDefault) then { true; } else {
    [_targetFobMarker, _supply, _ammo, _fuel] call KPLIB_fnc_resources_refund;
};

if (!_credited) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onTransportRecycle] Insufficient space: [_targetUuid, _targetFobMarker, _credit, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, _credit, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    // TODO: TBD: may further identify the FOB that has the insufficient space...
    [
        format [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_INSUFFICIENT_SPACE", _supply, _ammo, _fuel]
    ] remoteExec ["KPLIB_fnc_notification_hint", _cid];

    false;
};

if (_debug) then {
    [format ["[fn_logisticsCO_onTransportRecycle] Finalizing: [_targetUuid, _targetFobMarker, _credit, _convoy, _convoyIndex, _cid]: %1"
        , str [_targetUuid, _targetFobMarker, _credit, _convoy, _convoyIndex, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: if we add TRANSPORT ECONOMICS to the variables, then we will need to coordinate index with the credit...
private _finalized = [_namespace, _convoy, _convoyIndex, _supply, _ammo, _fuel, _cid] call {
    params ["_namespace", "_convoy", "_convoyIndex", "_supply", "_ammo", "_fuel", "_cid"];

    // May use the '_recycledTransport' for further diagnostics...
    private _recycledTransport = _convoy deleteAt _convoyIndex;

    [
        format [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_RECYCLED", _supply, _ammo, _fuel]
    ] remoteExec ["KPLIB_fnc_notification_hint", _cid];

    // May not need to set it back again, but do so in the event there was a default get (^)
    [_namespace, [
        [KPLIB_logistics_convoy, _convoy]
    ]] call KPLIB_fnc_namespace_setVars;

    true;
};

if (_debug) then {
    [format ["[fn_logisticsCO_onTransportRecycle] Fini: [_finalized]: %1"
        , str [_finalized]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

_finalized;
