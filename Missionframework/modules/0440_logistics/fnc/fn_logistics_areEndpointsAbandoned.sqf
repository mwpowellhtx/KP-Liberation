/*
    KPLIB_fnc_logistics_areEndpointsAbandoned

    File: fn_logistics_areEndpointsAbandoned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-14 10:50:25
    Last Update: 2021-03-14 10:50:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether either of the ENDPOINTS can be considered ABANDONED.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        Whether either of the ENDPOINTS can be considered ABANDONED [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logistics_areEndpointsAbandoned_debug}
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
];

private _allEndpoints = [] call KPLIB_fnc_logistics_getEndpoints;

private _whereInAllEndpoints = {
    _x params ["_0", "_endpointMarker"];
    private _endpointIndex = _allEndpoints findIf {
        _x params ["_4", "_candidateMarker"];
        _endpointMarker isEqualTo _candidateMarker;
    };
    _endpointIndex >= 0;
};

private _abandonedCount = _whereInAllEndpoints count _endpoints;

_abandonedCount > 0;
