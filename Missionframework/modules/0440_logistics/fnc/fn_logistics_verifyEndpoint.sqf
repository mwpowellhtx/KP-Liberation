/*
    KPLIB_fnc_logistics_verifyEndpoint

    File: fn_logistics_verifyEndpoint.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 15:28:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the '_candidate' tuple is valid.

    Parameters:
        _candidate - a candidate endpoint tuple, which can come in one of two forms [ARRAY, default: []]
            unassigned form: [_pos, _markerName, _baseMarkerText]
            assigned form: [_pos, _markerName, _baseMarkerText, _billValues]

    Returns:
        Whether the '_candidate' is valid [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_logistics_verificationDebug"
        , "KPLIB_param_logistics_endpointVerificationDebug"
    ]
] call KPLIB_fnc_logistics_debug;

// TODO: TBD: we are doing a lot of point by point verification here...
// TODO: TBD: it might even make sense to do implement a general purpose recursive "shape verification"

params [
    ["_candidate", [], [[]]]
    // // TODO: TBD: this will be a performance hog, will need to optimize the lookup for available endpoints...
    //, ["_endpoints", ([] call KPLIB_fnc_logistics_getEndpoints), [[]]]
];

if (!(typeName _candidate isEqualTo "ARRAY")) exitWith {
    if (_debug) then {
        [format ["[KPLIB_fnc_logistics_verifyEndpoint] Candidate is not an ARRAY: [typeName _candidate]: %1"
            , str [typeName _candidate]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Verify the types, either a fully assigned EP, or an unassigned EP
private _candidateTypes = _candidate apply { typeName _x; };

// Unassigned endpoints do not include a BILL yet
if (!(
        (_candidateTypes isEqualTo ["ARRAY", "STRING", "STRING"])
            || (_candidateTypes isEqualTo ["ARRAY", "STRING", "STRING", "ARRAY"])
    )) exitWith {

    if (_debug) then {
        [format ["[KPLIB_fnc_logistics_verifyEndpoint] Invalid tuple shape: [_candidateTypes]: %1"
            , str [_candidateTypes]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };

    false;
};

// TODO: TBD: may also verify whether marker name is valid, but this can change, i.e. repackaged scenarios...

// Candidate may or may not include bill, i.e. when it has not yet been assigned to an operating logistic line
_candidate params [
    ["_pos", [], [[]]]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
    , ["_bill", KPLIB_resources_storageValueDefault, [[]]]
];

// Position must be verified in this shape
if (!(_pos isEqualTypeArray KPLIB_zeroPos)) exitWith {
    if (_debug) then {
        [format ["[KPLIB_fnc_logistics_verifyEndpoint] Invalid position: [_pos]: %1"
            , str [_pos]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Bill may be "default", but this is fine for verification purposes
if (!(_bill isEqualTypeArray KPLIB_resources_storageValueDefault)) exitWith {
    if (_debug) then {
        [format ["[KPLIB_fnc_logistics_verifyEndpoint] Invalid bill: [_bill]: %1"
            , str [_bill]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

true;
