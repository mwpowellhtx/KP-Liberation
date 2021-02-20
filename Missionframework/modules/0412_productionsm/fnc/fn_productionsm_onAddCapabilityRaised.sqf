/*
    KPLIB_fnc_production_onAddCapabilityRaised

    File: fn_production_onAddCapabilityRaised.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 08:57:31
    Last Update: 2021-02-18 13:22:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback used to close the loop on the 'KPLIB_productionsm_raiseAddCapability'
        client server CBA production statemachine request.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull] 
        _capability - a capability [ARRAY, default: KPLIB_production_cap_default]
        _capabilityMask - a capability mask [ARRAY, default: KPLIB_production_cap_default]
        _cid - the client identifier used to invoke client side callbacks [SCALAR, default: -1]

    Returns:
        The transformed target of the raised change order event [ARRAY, default: _capability]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_capability", (+KPLIB_production_cap_default), [[]], 3]
    , ["_capabilityMask", (+KPLIB_production_cap_default), [[]], 3]
    , ["_cid", -1, [0]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_production_onAddCapabilityRaised] Entering: [_markerName, _capability, _capabilityMask, _cid]: %1"
        , str [_markerName, _capability, _capabilityMask, _cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _resourceName = localize (switch (true) do {
    case (_capabilityMask#0): {
        "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY";
    };
    case (_capabilityMask#1): {
        "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO";
    };
    case (_capabilityMask#2): {
        "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL";
    };
    default {
        "STR_KPLIB_PRODUCTION_CAPABILITY_NA";
    };
});

private _candidate = [_capability, _capabilityMask, { (_this#0) || (_this#1); }] call KPLIB_fnc_linq_zip;

// Assumes predetermined '_capabilityMask', one of the capabilities under requested
private _debitResult = [_namespace, _capabilityMask, _candidate] call KPLIB_fnc_production_assessCapabilityDebit;

_debitResult params [
    ["_assessment", KPLIB_productionsm_addCap_success, [0]]
    , ["_cost", KPLIB_production_cap_default, [[]], 3]
    , ["_baseMarkerText", "", [""]]
];

private _key = _debitResult call KPLIB_fnc_productionsm_getAddCapabilityNotificationKey;

// Notify caller according to the result...
[format [localize _key, _resourceName, _baseMarkerText
            , (_cost#0), (_cost#1), (_cost#2)]] remoteExec ["KPLIB_fnc_notification_hint", _cid];
// 1. Supply:  ^^^^^^^
// 2.   Ammo:             ^^^^^^^
// 3.   Fuel:                        ^^^^^^^

if (_debug) then {
    [format ["[fn_production_onAddCapabilityRaised] Finished: [_key, _resourceName, _baseMarkerText, _candidate, _capability]"
        , str [_key, _resourceName, _baseMarkerText, _candidate, _capability]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Zip them up when the costs are successfully debited
if ((_debugResult#0) isEqualTo KPLIB_productionsm_addCap_success) exitWith {
    _candidate;
};

// Otherwise return with the unaffected baseline
_capability;
