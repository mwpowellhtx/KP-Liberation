/*
    KPLIB_fnc_logistics_namespaceToArray

    File: fn_logistics_namespaceToArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 21:08:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns with a logistics tuple array given the '_namespace'. May return
        empty array (i.e. []) for locationNull arguments.

    Parameters:
        _namespace - A CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        An array corresponding to the namespace [ARRAY]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

if (isNull _namespace) exitWith { []; };

private _varSpecs = [
    ["KPLIB_logistics_uuid", [] call KPLIB_fnc_uuid_create_string]
    , ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , ["KPLIB_logistics_timer", +KPLIB_timers_default]
    , ["KPLIB_logistics_endpoints", []]
    , ["KPLIB_logistics_transportValues", []]
];

private _onGetVariableValue = {
    _x params [
        ["_variableName", "", [""]]
        "_defaultValue"
    ];
    private _value = _namespace getVariable [_variableName, _defaultValue];
    _value;
};

private _logistic = +(_varSpecs apply _onGetVariableValue);

if ((count _logistic) == (count _varSpecs)) then {
    // TODO: TBD: add some logging here...
} else {
    // TODO: TBD: add some logging here...
};

// Then further append the telemetry elements
private _telemetry = [_namespace] call KPLIB_fnc_logistics_getTelemetryArray;
_logistic pushBack _telemetry;

_logistic;
