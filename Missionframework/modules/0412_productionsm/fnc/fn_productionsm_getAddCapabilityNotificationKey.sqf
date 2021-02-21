/*
    KPLIB_fnc_productionsm_getAddCapabilityNotificationKey

    File: fn_productionsm_getAddCapabilityNotificationKey.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 10:04:07
    Last Update: 2021-02-18 10:04:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Raises the 'KPLIB_productionsm_onAddCapability' event with the CBA production statemachine.

    Parameter(s):
        _debitAssessment - a tuple in the form:
            _assessment - the add capability debit assessment [SCALAR, default: KPLIB_productionsm_addCap_success]
            _cost - the resource cost associated with the requested operation [ARRAY, default: KPLIB_production_sum_default]
            _baseMarkerText - the base marker text associated with the requested operation [STRING, default: ""]

    Returns:
        The string table key reporting on the 'KPLIB_productionsm_raiseAddCapability' assessment [STRING]
 */

private _debug = [
    [
        "KPLIB_param_productionsm_calculators_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_assessment", KPLIB_productionsm_addCap_success, [0]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_getAddCapabilityNotificationKey] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _key = switch (_assessment) do {
    case KPLIB_productionsm_addCap_exists: {
        "STR_KPLIB_PRODUCTION_ADD_CAPABILITY_EXISTS";
    };
    case KPLIB_productionsm_addCap_insufficientSumFob;
    case KPLIB_productionsm_addCap_insufficientSumSector: {
        "STR_KPLIB_PRODUCTION_INSUFFICIENT_RES";
    };
    case KPLIB_productionsm_addCap_success: {
        "STR_KPLIB_PRODUCTION_ADDED_CAPABILITY";
    };
    //case KPLIB_productionsm_addCap_elementNotFound: {
    //    "STR_KPLIB_PRODUCTION_CANNOT_ADD_CAPABILITY";
    //};
    default {
        "STR_KPLIB_PRODUCTION_CANNOT_ADD_CAPABILITY";
    };
};

if (_debug) then {
    [format ["[fn_productionsm_getAddCapabilityNotificationKey] Finished: [_key]: %1"
        , str [_key]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_key;
