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
    , "_candidates"
];

if (_debug) then {
    // TODO: TBD: add logging...
};

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_lineEps"
];

// Obtain the ENDPOINT INDEXES with or without the CANDIDATES
private _lineEpIndexes = if (isNil "_candidates") then {
    [_namespace] call KPLIB_fnc_logistics_getEndpointIndexes;
} else {
    [_namespace, _candidates] call KPLIB_fnc_logistics_getEndpointIndexes;
};

private _lineEpCount = { (_x >= 0); } count _lineEpIndexes;

if (_debug) then {
    // TODO: TBD: add logging...
};

_lineEpCount < (count _lineEps);
