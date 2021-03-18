/*
    KPLIB_fnc_productionSM_onNoOp

    File: fn_productionSM_onNoOp.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-18 01:06:54
    Last Update: 2021-03-18 01:06:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_stateOrTransit", "", [""]]
];

private _debug = [
    [
        {KPLIB_param_productionSM_onNoOp_debug}
        , { _namespace getVariable ["KPLIB_param_productionSM_onNoOp_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

([_namespace, [
    ["KPLIB_production_markerName", ""]
    , ["KPLIB_production_baseMarkerText", ""]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_baseMarkerText"
];

if (_debug) then {
    [format ["[fn_productionSM_onNoOp] Entering: [isNull _namespace, _markerName, _baseMarkerText, _stateOrTransit]: %1"
        , str [isNull _namespace, _markerName, _baseMarkerText, _stateOrTransit]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    [format ["[fn_productionSM_onNoOp] Fini: [isNull _namespace, _markerName, _baseMarkerText, _stateOrTransit]: %1"
        , str [isNull _namespace, _markerName, _baseMarkerText, _stateOrTransit]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
