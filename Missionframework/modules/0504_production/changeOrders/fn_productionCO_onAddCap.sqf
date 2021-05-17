/*
    KPLIB_fnc_productionCO_onAddCap

    File: fn_productionCO_onAddCap.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 08:57:31
    Last Update: 2021-03-17 07:46:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback used to close the loop on the 'KPLIB_productionCO_requestAddCapability'
        client server CBA production statemachine request.

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
        {KPLIB_param_productionCO_onAddCap_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_onAddCap_debug", false]}
        , {_changeOrder getVariable ["KPLIB_param_productionCO_onAddCap_debug", false]}
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
    ["KPLIB_production_capabilityMask", +KPLIB_production_cap_default]
    , ["KPLIB_production_capabilityCandidate", +KPLIB_production_cap_default]
]] call KPLIB_fnc_namespace_getVars) params [
    "_mask"
    , "_candidate"
];

if (_debug) then {
    [format ["[fn_productionCO_onAddCap] Entering: [_markerName, _baseMarkerText, _cap, _mask, _candidate]: %1"
        , str [_markerName, _baseMarkerText, _cap, _mask, _candidate]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

// Debit successfully paid may proceed with candidate
[_namespace, [
    ["KPLIB_production_capability", _candidate]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_productionCO_onAddCap] Fini: [_markerName, _baseMarkerText, _cap, _mask, _candidate]: %1"
        , str [_markerName, _baseMarkerText, _cap, _mask, _candidate]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

true;
