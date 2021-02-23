/*
    KPLIB_fnc_productionsm_tryProducingResource

    File: fn_productionsm_tryProducingResource.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 18:24:36
    Last Update: 2021-02-22 18:24:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Tries to produce the next resource in the CBA production statemachine '_queue'.

    Parameter(s):
        _namespace - a CBA production namespace, not strictly used here apart from association [LOCATION, default: locationNull]
        _targetStorage - the target storage container into which production should occur [OBJECT, default: objNull]
        _resourceIndex - a resource index, should be one of 'KPLIB_resources_indexes' [SCALAR, default: KPLIB_resources_i_sup]

    Returns:
        Whether the resource was successfully produced and stored [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_targetStorage", objNull, [objNull]]
    , ["_resourceIndex", KPLIB_resources_i_sup, [0]]
];

private _debug = [
    [
        "KPLIB_param_productionsm_producer_debug"
        , "KPLIB_param_productionsm_changeOrders_debug"
        , "KPLIB_param_productionsm_tryProducingResource_debug"
        , "KPLIB_param_productionsm_onProducingResourceRaised_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_producer_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_changeOrders_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_tryProducingResource_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_onProducingResourceRaised_debug", false]; }
        , { _targetStorage getVariable ["KPLIB_param_productionsm_producer_debug", false]; }
        , { _targetStorage getVariable ["KPLIB_param_productionsm_changeOrders_debug", false]; }
        , { _targetStorage getVariable ["KPLIB_param_productionsm_tryProducingResource_debug", false]; }
        , { _targetStorage getVariable ["KPLIB_param_productionsm_onProducingResourceRaised_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _baseMarkerText = _namespace getVariable ["_baseMarkerText", ""];
private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_tryProducingResource] Entering: [_markerName, _baseMarkerText, isNull _namespace, isNull _targetStorage, _resourceIndex]: %1"
        , str [_markerName, _baseMarkerText, isNull _namespace, isNull _targetStorage, _resourceIndex]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _cratePos = [getPos _targetStorage] call {
    (_this#0) getPos [20, random 360];
};

private _resourceClassName = KPLIB_resources_resourceKinds select _resourceIndex;

// TODO: TBD: may need some algo here to identify a "clear" spot to place the produced crate...
private _crate = [_resourceClassName, _cratePos] call KPLIB_fnc_resources_createCrate;

// Null crate is a genuine problem, returning 'false'
if (isNull _crate) exitWith {
    // TODO: TBD: log that there was a problem during production...
    false;
};

// TODO: TBD: do we need to put any locks on the storage while we do this (?)
if (!([_crate, _targetStorage] call KPLIB_fnc_resources_storeCrate)) exitWith {
    // TODO: TBD: log problem storing the crate itself in the target storage...
    // [...] call KPLIB_fnc_common_log

    // Crate production did occur even though it was not stored properly
    true;
};

if (_debug) then {
    [format ["[fn_productionsm_tryProducingResource] Fini: [_markerName, _baseMarkerText]: %1"
        , str [_markerName, _baseMarkerText]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
