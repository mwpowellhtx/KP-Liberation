/*
    KPLIB_fnc_productionsm_onNextChangeOrder

    File: fn_productionsm_onNextChangeOrder.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 12:17:17
    Last Update: 2021-02-18 12:17:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Abstractly handles lifting a '_sourceVariable' from '_namespace', applying the
        '_onCalculateValue' callback to it, given '_targetValue', and dropping that result
        back in '_namespace' afterward. It is assumed that the callback does the heavy
        lifting of the calculation and any mission critical or change order specific
        notifications.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

        _changeOrder - each change order follows the pattern:
            _cid - the client identifier [SCALAR, default: -1]
            _sourceVariable - the '_namespace' source variable specification, in the form:
                - _sourceVariableName - the source variable name [STRING, default: ""]
                - _sourceDefaultValue - a source default value, if applicable [ANY, default: nil]
            _targetValue - a target or intermediate value used to inform the '_onCalculateValue'
                callback [ARRAY, default: []]
            _onCalculateValue - a variable change order callback [CODE, default: { (_this#1); }]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _debug = [
    [
        "KPLIB_param_productionsm_changeOrders_debug"
        , "KPLIB_param_productionsm_nextChangeOrder_debug"
        , "KPLIB_param_productionsm_raiseAddCap_debug"
        , "KPLIB_param_productionsm_raiseChangeQueue_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_changeOrders_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_nextChangeOrder_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_raiseAddCap_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_raiseChangeQueue_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _changeOrder = [_namespace] call KPLIB_fnc_productionsm_dequeueChangeOrder;

if (_changeOrder isEqualTo []) exitWith {
    if (_debug) then {
        [format ["[fn_productionsm_onNextChangeOrder] Finished: [_changeOrder]: %1"
            , str [_changeOrder]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

_changeOrder params [
    ["_cid", -1, [0]]
    , ["_sourceVariable", "", ["", []]]
    , ["_targetValue", [], [[]]]
    , ["_onCalculateValue", { (_this#1); }, [{}]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_onNextChangeOrder] Entering: [_markerName, _sourceVariable, _targetValue]: %1"
        , str [_markerName, _sourceVariable, _targetValue]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Wrap the spec when all we got was the variable name
if (typeName _sourceVariable isEqualTo "STRING") then {
    _sourceVariable = [_sourceVariable];
};

// TODO: TBD: what else to do here, is an internal inconsistency, log it and exit with...
if (!(typeName _sourceVariable isEqualTo "ARRAY")) exitWith {
    if (_debug) then {
        [format ["[fn_productionsm_onNextChangeOrder] Source variable error: [typeName _sourceVariable]: %1"
            , str [typeName _sourceVariable]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

_sourceVariable params [
    ["_sourceVariableName", "", [""]]
    , "_sourceDefaultValue"
];

private _sourceValue = if (isNil "_sourceDefaultValue") then {
    _namespace getVariable _sourceVariableName;
} else {
    _namespace getVariable _sourceVariable;
};

private _candidateValue = [_namespace, _sourceValue, _targetValue, _cid] call _onCalculateValue;

if (!(_candidateValue isEqualTo _sourceValue)) then {
    _namespace setVariable [_sourceVariableName, _candidateValue];
    private _onChangeOrderComplete = _namespace getVariable ["_onChangeOrderComplete", {}];
    [] call _onChangeOrderComplete;
    // Replace with innocuous no-op callback
    _namespace setVariable ["_onChangeOrderComplete", {}];
};

if (_debug) then {
    [format ["[fn_productionsm_onNextChangeOrder] Finished: [_sourceVariableName, _sourceValue, _targetValue, _candidateValue, _cid]: %1"
        , str [_sourceVariableName, _sourceValue, _targetValue, _candidateValue, _cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
