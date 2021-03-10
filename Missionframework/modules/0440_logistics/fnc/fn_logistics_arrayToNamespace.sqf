/*
    KPLIB_fnc_logistics_arrayToNamespace

    File: fn_logistics_arrayToNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 21:11:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Converts the '_logistic' tuple array to a CBA logistic namespace.

    Parameters:
        _logistic - a logistic tuple array shape [ARRAY, default: []]

    Returns:
        A CBA logistic namespace, or 'locationNull' for invalid tuples.

    References:
        https://community.bistudio.com/wiki/locationNull
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createNamespace-sqf.html
 */

params [
    ["_logistic", [], [[]]]
];

private _namespace = locationNull;

if (!([_logistic] call KPLIB_fnc_logistics_verifyArray)) exitWith {
    _namespace;
};

_namespace = [] call CBA_fnc_createNamespace;

_logistic params [
    ["_uuid", "", [""]]
    , ["_status", KPLIB_logistics_status_standby, [0]]
    , ["_timer", +KPLIB_timers_default, [[]]]
    , ["_endpoints", [], [[]]]
    , ["_convoy", [], [[]]]
    , ["_telemetry", [], [[]]]
];

private _varSpecs = [
    ["KPLIB_logistics_uuid", _uuid]
    , ["KPLIB_logistics_status", _status]
    , [KPLIB_logistics_timer, _timer]
    , ["KPLIB_logistics_endpoints", _endpoints]
    , [KPLIB_logistics_convoy, _convoy]
];

private _onInstallVarSpec = {
    _x params [
        ["_variableName", "", [""]]
        , "_value"
    ];
    _namespace setVariable [_variableName, _value];
    private _lowerVarName = toLower _variableName;
    private _namespaceVars = allVariables _namespace;
    _lowerVarName in _namespaceVars;
};

private _installed = _varSpecs select _onInstallVarSpec;

if (_installed isEqualTo _varSpecs) then {
    // TODO: TBD: may do some logging here...
} else {
    // TODO: TBD: may do some logging here...
};

// And we further set the telemetry elements...
if (!([_namespace, _telemetry] call KPLIB_fnc_logistics_setTelemetry)) then {
    // TODO: TBD: do some logging, there was a problem setting TELEMETRY...
};

_namespace;
