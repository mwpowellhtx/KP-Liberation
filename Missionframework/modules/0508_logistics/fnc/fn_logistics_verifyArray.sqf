/*
    KPLIB_fnc_logistics_verifyArray

    File: fn_logistics_verifyArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 14:47:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the '_candidate' tuple is valid.

    Parameters:
        _candidate - a logistic tuple [ARRAY, default: []]

    Returns:
        Whether the '_candidate' is valid [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_logistics_verificationDebug"
        , "KPLIB_param_logistics_arrayVerificationDebug"
    ]
] call KPLIB_fnc_logistics_debug;

params [
    "_candidate"
];

if (!(typeName _candidate isEqualTo "ARRAY")) exitWith {
    if (_debug) then {
        [format ["[fn_logistics_verifyArray] Candidate is not an ARRAY: [typeName _candidate]: %1"
            , str [typeName _candidate]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _candidateTypes = _candidate apply { (typeName _x); };

if (!(_candidateTypes isEqualTo ["STRING", "SCALAR", "ARRAY", "ARRAY", "ARRAY"])) exitWith {
    if (_debug) then {
        [format ["[fn_logistics_verifyArray] Invalid tuple shape: [_candidateTypes]: %1"
            , str [_candidateTypes]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Now we know that candidate tuple at least has this shape...
_candidate params [
    ["_uuid", "", [""]]
    , ["_status", 0, [0]]
    , ["_timer", [], [[]]]
    , ["_endpoints", [], [[]]]
    , ["_convoy", [], [[]]]
];

[
    [_uuid] call KPLIB_fnc_uuid_verify_string
    , _status >= 0
    , _timer call KPLIB_fnc_timers_verify
    , count _endpoints
    , _convoy select { (_x isEqualTypeArray KPLIB_resources_storageValueDefault); }
] params [
    ["_uuidValid", false, [false]]
    , ["_statusValid", false, [false]]
    , ["_timerValid", false, [false]]
    , ["_endpointCount", 0, [0]]
    , ["_validConvoy", [], [[]]]
];

// TODO: TBD: perhaps other bits we can verify here...
if (!_uuidValid) exitWith {
    if (_debug) then {
        [format ["[fn_logistics_verifyArray] Invalid UUID: [_uuid]: %1"
            , str [_uuid]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

if (!_statusValid) exitWith {
    if (_debug) then {
        [format ["[fn_logistics_verifyArray] Invalid status: [_uuid, _status]: %1"
            , str [_uuid, _status]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

if (!_timerValid) exitWith {
    if (_debug) then {
        [format ["[fn_logistics_verifyArray] Invalid status: [_uuid, _status, _timer]: %1"
            , str [_uuid, _status, _timer]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

// TODO: TBD: should also verify that the endpoints themselves are not equal...
if (!(
        (_endpointCount == 0)
        || ([2, 2] isEqualTo [
            _endpointCount
            , { [_x] call KPLIB_fnc_logistics_verifyEndpoint; } count _endpoints
        ])
    )) exitWith {

    if (_debug) then {
        [format ["[fn_logistics_verifyArray] Invalid endpoints: [_uuid, _status, _timer, _endpoints]: %1"
            , str [_uuid, _status, _timer, _endpoints]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };

    false;
};

if (!(_validConvoy isEqualTo _convoy)) exitWith {
    if (_debug) then {
        [format ["[fn_logistics_verifyArray] Invalid transports: [_uuid, _status, _timer, _endpoints, _convoy]: %1"
            , str [_uuid, _status, _timer, _endpoints, _convoy]], "LOGISTICS", true] call KPLIB_fnc_common_log;
    };
    false;
};

true;
