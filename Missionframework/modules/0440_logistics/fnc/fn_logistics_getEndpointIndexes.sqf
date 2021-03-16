/*
    KPLIB_fnc_logistics_getEndpointIndexes

    File: fn_logistics_getEndpointIndexes.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-15 13:15:07
    Last Update: 2021-03-15 13:15:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the current ENDPOINT indexes given the known set of endpoints CANDIDATES.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        An array of ENDPOINT INDEXES based on the current set of CANDIDATES [ARRAY]
 */

private _debug = [
    [
        {KPLIB_param_logistics_getEndpointIndexes_debug}
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , "_candidates"
];

// Now with the advent of ABANDONED ENDPOINTS, technically no longer "all" ENDPOINTS
_candidates = if (!isNil "_candidates") then { _candidates; } else {
    [] call KPLIB_fnc_logistics_getEndpoints;
};

// And slice the MARKERS for comparison...
private _canMarkers = _candidates apply { (_x#1); };

if (_debug) then {
    // TODO: TBD: add logging...
};

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_lineEps"
];

if (_debug) then {
    // TODO: TBD: add logging...
};

// Predicate comparing ENDPOINT MARKER with CANDIDATE MARKERS
private _onGetEpIndex = {
    _x params [
        ["_epPos", +KPLIB_zeroPos, [[]], 3]
        , ["_epMarker", "", [""]]
    ];
    private _epIndex = _canMarkers findIf {
        !(_epMarker isEqualTo "")
            && (_x isEqualTo _epMarker);
    };
    _epIndex;
};

private _epIndexes = _lineEps apply _onGetEpIndex;

if (_debug) then {
    // TODO: TBD: add logging...
};

_epIndexes