/*
    KPLIB_fnc_productionCO_onRequestAddCap

    File: fn_productionCO_onRequestAddCap.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 08:57:31
    Last Update: 2021-03-17 07:20:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Identifies the CBA PRODUCTION namespace and enqueues an ADD CAPABILITY CHANGE ORDER.

    Parameter(s):
        _targetMarker - the target factory sector, i.e. '_markerName', affected by the request [STRING, default: ""]
        _capRequest - the requested capability being added to the sector, must be in 'KPLIB_resources_indexes' [SCALAR, default: -1]
        _cid - the client identifier used to invoke client side callbacks

    Returns:
        The CBA server side event fini [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html
 */

params [
    ["_targetMarker", "", [""]]
    , ["_capRequest", -1, [0]]
    , ["_cid", -1, [0]]
];

private _namespace = [_targetMarker] call KPLIB_fnc_production_getNamespaceByMarker;

private _debug = [
    [
        {KPLIB_param_productionCO_onRequest_debug}
        , {KPLIB_param_productionCO_onRequestAddCap_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_onRequest_debug", false]}
        , {_namespace getVariable ["KPLIB_param_productionCO_onRequestAddCap_debug", false]}
    ]
] call KPLIB_fnc_productionCO_debug;

if (_debug) then {
    [format ["[fn_productionCO_onRequestAddCap] Entering: [_targetMarker, _capRequest, isNull _namespace, _cid]: %1"
        , str [_targetMarker, _capRequest, isNull _namespace, _cid]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

// May initially reject the request
if (isNull _namespace || !(_capRequest in KPLIB_resources_indexes)) exitWith {
    if (_debug) then {
        ["[fn_productionCO_onRequestAddCap] Rejected", "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
    };
    false;
};

([_namespace, [
    ["KPLIB_production_capability", +KPLIB_production_cap_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cap"
];

private _mask = KPLIB_resources_indexes apply { (_x isEqualTo _capRequest); };
private _candidate = [_cap, _mask, { (_this#0) || (_this#1); }] call KPLIB_fnc_linq_zip;
private _debit = _mask call KPLIB_fnc_productionCO_makeCapDebit;

if (_debug) then {
    [format ["[fn_productionCO_onRequestAddCap] Enqueuing change order: [_mask, _candidate, _debit]: %1"
        , str [_mask, _candidate, _debit]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

private _changeOrder = [{
    params [
        ["_changeOrder", locationNull, [locationNull]]
    ];

    [_changeOrder, [
        ["KPLIB_production_cid", _cid]
        , ["KPLIB_production_capabilityMask", _mask]
        , ["KPLIB_production_capabilityDebit", _debit]
        , ["KPLIB_production_capabilityCandidate", _candidate]
        , [KPLIB_changeOrders_onChangeOrder, KPLIB_fnc_productionCO_onAddCap]
        , [KPLIB_changeOrders_onChangeOrderEntering, KPLIB_fnc_productionCO_onAddCapEntering]
        , [KPLIB_changeOrders_onChangeOrderComplete, {["KPLIB_updateMarkers"] call CBA_fnc_serverEvent}]
    ]] call KPLIB_fnc_namespace_setVars;

}] call KPLIB_fnc_changeOrders_create;

[_namespace, _changeOrder] call KPLIB_fnc_changeOrders_enqueue;

if (_debug) then {
    [format ["[fn_productionCO_onRequestAddCap] Fini: [_mask, _candidate, _debit]: %1"
        , str [_mask, _candidate, _debit]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

true;
