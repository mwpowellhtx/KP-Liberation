/*
    KPLIB_fnc_logistics_getEndpointOrNearest

    File: fn_logistics_getEndpointOrNearest.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 15:33:50
    Last Update: 2021-03-13 15:33:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Does the work of identifying the next nearest ENDPOINT that is not the OTHER,
        and appending the current BILL VALUE.

    Parameters:
        _endpoint - an ENDPOINT tuple [ARRAY, default: []]
        _otherEndpoint - an OTHER ENDPOINT tuple [ARRAY, default: []]
        _isEndpoint - whether the ENDPOINT is in fact an endpoint [BOOL, default: false]
        _allEndpoints - an array of candidate ENDPOINTS, or callback that returns the same [ARRAY || CODE, default: {...}]

    Returns:
        The nearest ENDPOINT to the given one, or itself when one could not be identified [ARRAY]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

private _debug = [
    [
        {KPLIB_param_logistics_getEndpointOrNearest_debug}
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_endpoint", [], [[]], 4]
    , ["_otherEndpoint", [], [[]], 4]
    , ["_isEndpoint", false, [false]]
    , ["_allEndpoints", { [] call KPLIB_fnc_logistics_getEndpoints; }, [[], {}]]
];

if (_isEndpoint) exitWith {
    _endpoint;
};

// De-con the ENDPOINT for subsequent use
_endpoint params [
    ["_endpointPos", +KPLIB_zeroPos, [[]], 3]
    , ["_1", "", [""]]
    , ["_2", "", [""]]
    , ["_billValue", +KPLIB_resources_storageValueDefault, [[]], 3]
];

// '_4' leaving room for ENDPOINT bits
_otherEndpoint params [
    ["_4", +KPLIB_zeroPos, [[]], 3]
    , ["_otherMarker", "", [""]]
];

_allEndpoints = switch (true) do {
    case (_allEndpoints isEqualType {}): { [] call _allEndpoints; };
    case (_allEndpoints isEqualType []): { _allEndpoints; };
    default { []; };
};

// Find all other candidates NOT corresponding to the OTHER ENDPOINT
private _allCandidates = _allEndpoints select {
    !([_x, _otherEndpoint] call KPLIB_fnc_logistics_areEndpointsEqual);
};

// If no other ENDPOINTS then we must maintain that one until one frees up
if (_allCandidates isEqualTo []) exitWith {
    _endpoint;
};

// TODO: TBD: what to do if we can no longer identify candidates?
// TODO: TBD: for now assuming we have at least one...
private _candidate = if (count _allCandidates isEqualTo 1) then {
    _allCandidates#0;
} else {
    private _allSorted = [_allCandidates, [], { ((_x#0) distance2D _endpointPos); }] call BIS_fnc_sortBy;
    _allSorted#0;
};

// De-con the selected CANDIDATE and respond
_candidate param [
    ["_candidatePos", +KPLIB_zeroPos, [[]], 3]
    , ["_candidateMarker", "", [""]]
    , ["_candidateMarkerText", "", [""]]
];

// We are "okay" with duplicate lines at this point, there is very little other choice
+[_candidatePos, _candidateMarker, _candidateMarkerText, _billValue];
