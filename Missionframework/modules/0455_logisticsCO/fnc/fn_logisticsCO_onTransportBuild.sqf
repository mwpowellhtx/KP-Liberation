/*
    KPLIB_fnc_logisticsCO_onTransportBuild

    File: fn_logisticsCO_onTransportBuild.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-05 22:24:37
    Last Update: 2021-03-05 22:24:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs the cached change order on the target logistics namespace.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        The change order callback finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onTransportBuild_debug}
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

private _debit = [] call KPLIB_fnc_logisticsCO_getTransportDebit;
_debit params ["_supply", "_ammo", "_fuel"];

private _debited = if (_debit isEqualTo KPLIB_resources_storageValueDefault) then { true; } else {
    [_targetFobMarker, _supply, _ammo, _fuel] call KPLIB_fnc_resources_pay;
};

if (!_debited) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsCO_onTransportBuild] Insufficient resources: [_targetUuid, _targetFobMarker, _debit, _cid]: %1"
            , str [_targetUuid, _targetFobMarker, _debit, _cid]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
    };

    [
        // TODO: TBD: may further identify the FOB that has the insufficient resources...
        format [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_INSUFFICIENT_RESOURCES", _supply, _ammo, _fuel]
    ] remoteExec ["KPLIB_fnc_notification_hint", _cid];

    false;
};

private _finalized = [_namespace, _supply, _ammo, _fuel, _cid] call {
    params ["_namespace", "_supply", "_ammo", "_fuel", "_cid"];

    ([_namespace, [
        [KPLIB_logistics_convoy, []]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_convoy"
    ];

    // So that we are indeed working with a genuine copy
    _convoy = +_convoy;

    // May use the '_transportIndex' for further diagnostics...
    private _transportIndex = _convoy pushBack +KPLIB_resources_storageValueDefault;

    [
        // May not need to set it back again, but do so in the event there was a default get (^)
        format [localize "STR_KPLIB_LOGISTICS_MSG_CONVOY_TRANSPORT_BUILT", _supply, _ammo, _fuel]
    ] remoteExec ["KPLIB_fnc_notification_hint", _cid];

    [_namespace, [
        [KPLIB_logistics_convoy, _convoy]
    ]] call KPLIB_fnc_namespace_setVars;

    true;
};

if (_debug) then {
    [format ["[fn_logisticsCO_onTransportBuild] Fini: [_finalized]: %1"
        , str [_finalized]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

_finalized;
