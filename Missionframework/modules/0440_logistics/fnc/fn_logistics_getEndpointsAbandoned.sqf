/*
    KPLIB_fnc_logistics_getEndpointsAbandoned

    File: fn_logistics_getEndpointsAbandoned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-14 20:35:50
    Last Update: 2021-03-14 20:35:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns all the ABANDONED ENDPOINTS that are represented in the current
        LOGISTICS LINES, which NOT currently alive and well in the known set of
        ENDPOINTS.

    Parameters:
        _namespaces - a set of known CBA logistics namespaces [ARRAY, default: KPLIB_logistics_namespaces]

    Returns:
        ... [ARRAY]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

params [
    ["_namespaces", KPLIB_logistics_namespaces, [[]]]
];

private _knownEpMarkers = [[] call KPLIB_fnc_logistics_getEndpoints] call {
    params [
        ["_ep", [], [[]]]
    ];
    _ep apply { (_x#1); };
};

private _allEpCandidates = [] call {
    private _allEps = [];

    {
        ([_x, [
            ["KPLIB_logistics_endpoints", []]
        ]] call KPLIB_fnc_namespace_getVars) params [
            "_eps"
        ];
        { _allEps pushBackUnique _x; } forEach _eps;
    } forEach _namespaces;

    _allEps;
};

private _abandanedEps = _allEpCandidates select { !((_x#1) in _knownEpMarkers); };

if (count _abandanedEps > 1) exitWith {
    private _gridRefAlgo = { parseNumber (mapGridPosition _this); };
    [_abandanedEps, [], { (_x#0) call _gridRefAlgo; }] call BIS_fnc_sortBy;
};

_abandanedEps apply {
    // Drop the "bill value" element from the tuple for use with the other ENDPOINTS
    _x params ["_pos", "_markerName", "_baseMarkerText"];
    [_pos, _markerName, _baseMarkerText]
};
