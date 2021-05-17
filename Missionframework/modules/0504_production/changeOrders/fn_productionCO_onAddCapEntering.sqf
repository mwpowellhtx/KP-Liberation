/*
    KPLIB_fnc_productionCO_onAddCapEntering

    File: fn_productionCO_onAddCapEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 10:07:17
    Last Update: 2021-03-17 10:07:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs advanced screening when managers request to ADD CAPABILITY.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull] 
        _changeOrder - the CHANGE ORDER relaying key strategic bits
            "KPLIB_production_capability" - a capability [ARRAY, default: KPLIB_production_cap_default]
            "KPLIB_production_capabilityMask" - a capability mask [ARRAY, default: KPLIB_production_cap_default]
            "KPLIB_production_cid" - the client identifier used to invoke client side callbacks [SCALAR, default: -1]

    Returns:
        The transformed target of the raised change order event [ARRAY, default: _capability]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

private _debug = [
    [
        {KPLIB_param_productionCO_onAddCapEntering_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_onAddCapEntering_debug", false]}
        , {_changeOrder getVariable ["KPLIB_param_productionCO_onAddCapEntering_debug", false]}
    ]
] call KPLIB_fnc_productionCO_debug;

([_namespace, [
    ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
    , ["KPLIB_production_baseMarkerText", ""]
    , ["KPLIB_production_capability", +KPLIB_production_cap_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_baseMarkerText"
    , "_cap"
];

([_changeOrder, [
    ["KPLIB_production_cid", -1]
    , ["KPLIB_production_capabilityMask", +KPLIB_production_cap_default]
    , ["KPLIB_production_capabilityDebit", +KPLIB_resources_storageValueDefault]
    , ["KPLIB_production_capabilityCandidate", +KPLIB_production_cap_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
    , "_mask"
    , "_debit"
    , "_candidate"
];

if (_debug) then {
    [format ["[fn_productionCO_onAddCapEntering] Entering: [_markerName, _cap, _mask, _candidate, _cid]: %1"
        , str [_markerName, _cap, _mask, _candidate, _cid]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: making progress, turning a corner with the revised approach, refactored CO, etc...
private _resourceNameKey = _mask call {
    params [
        ["_supplyMask", false, [false]]
        , ["_ammoMask", false, [false]]
        , ["_fielMask", false, [false]]
    ];
    if (_supplyMask) exitWith { "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY"; };
    if (_ammoMask) exitWith { "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO"; };
    if (_fuelMask) exitWith { "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL"; };
    "STR_KPLIB_PRODUCTION_CAPABILITY_NA";
};
private _resourceName = localize _resourceNameKey;

private _tried = [_namespace, _changeOrder] call KPLIB_fnc_productionCO_tryDebitCap;

([_changeOrder, [
    ["KPLIB_production_assessment", KPLIB_productionCO_addCap_invalid]
]] call KPLIB_fnc_namespace_getVars) params [
    "_assessment"
];

private _key = [_namespace, _changeOrder] call KPLIB_fnc_productionCO_getCapNotificationKey;

// Notify caller according to the result...
[format [localize _key, _resourceName, _baseMarkerText
            , (_debit#0), (_debit#1), (_debit#2)]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
// 1. Supply:  ^^^^^^^^
// 2.   Ammo:              ^^^^^^^^
// 3.   Fuel:                          ^^^^^^^^

if (_debug) then {
    [format ["[fn_productionCO_onAddCapEntering] Fini: [_key, _assessment, _resourceName, _baseMarkerText, _cap, _candidate]: %1"
        , str [_key, _assessment, _resourceName, _baseMarkerText, _cap, _candidate]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

// Debit successfully paid may proceed with candidate
_assessment isEqualTo KPLIB_productionCO_addCap_success;
