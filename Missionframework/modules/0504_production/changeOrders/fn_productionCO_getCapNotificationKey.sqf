/*
    KPLIB_fnc_productionCO_getCapNotificationKey

    File: fn_productionCO_getCapNotificationKey.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 10:04:07
    Last Update: 2021-03-17 07:56:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the string table key corresponding to the CHANGE ORDER ASSESSMENT.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA CHANGE ORDER namespace [LOCATION, default: locationNull]
            "KPLIB_production_assessment" - the add cap debit assessment [SCALAR, default: KPLIB_productionCO_addCap_success]

    Returns:
        The string table key reporting on the assessment [STRING]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

private _debug = [
    [
        {KPLIB_param_productionCO_getCapNotificationKey_debug}
        , {_namespace getVariable ["KPLIB_param_productionCO_getCapNotificationKey_debug", false]}
        , {_changeOrder getVariable ["KPLIB_param_productionCO_getCapNotificationKey_debug", false]}
    ]
] call KPLIB_fnc_productionCO_debug;

([_namespace, [
    ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
];

([_changeOrder, [
    ["KPLIB_production_assessment", KPLIB_productionCO_addCap_success]
]] call KPLIB_fnc_namespace_getVars) params [
    "_assessment"
];

if (_debug) then {
    [format ["[fn_productionCO_getCapNotificationKey] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

private _key = switch (_assessment) do {
    case KPLIB_productionCO_addCap_exists: {
        "STR_KPLIB_PRODUCTION_ADD_CAPABILITY_EXISTS";
    };
    case KPLIB_productionCO_addCap_insufficientSumFob;
    case KPLIB_productionCO_addCap_insufficientSumSector: {
        "STR_KPLIB_PRODUCTION_INSUFFICIENT_RES";
    };
    case KPLIB_productionCO_addCap_success: {
        "STR_KPLIB_PRODUCTION_ADDED_CAPABILITY";
    };
    // case KPLIB_productionCO_addCap_elementNotFound: {
    //     "STR_KPLIB_PRODUCTION_CANNOT_ADD_CAPABILITY";
    // };
    default {
        "STR_KPLIB_PRODUCTION_CANNOT_ADD_CAPABILITY";
    };
};

if (_debug) then {
    [format ["[fn_productionCO_getCapNotificationKey] Finished: [_key]: %1"
        , str [_key]], "PRODUCTIONCO", true] call KPLIB_fnc_common_log;
};

_key;
