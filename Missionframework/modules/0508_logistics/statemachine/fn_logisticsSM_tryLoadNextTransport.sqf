/*
    KPLIB_fnc_logisticsSM_tryLoadNextTransport

    File: fn_logisticsSM_tryLoadNextTransport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:27:37
    Last Update: 2021-03-05 00:01:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the '_namespace' timer has elapsed.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The array of CBA logistics namespaces [ARRAY]
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_tryLoadNextTransport_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_tryLoadNextTransport] Entering: [isNull _namespace]: %1"
        , str [isNull _namespace]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (isNull _namespace) exitWith {
    false;
};

private _transportIndex = [_namespace] call KPLIB_fnc_logistics_findNextTransportIndex;

// // TODO: TBD: probably do not need to check the _transportIndex here...
// // TODO: TBD: meaning, if we are "here" then we are "supposed" to be here
// if (_debug) then {
//     [format ["[fn_logisticsSM_tryLoadNextTransport] Loading: [_transportIndex]: %1"
//         , str [_transportIndex]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
// };

// if (_transportIndex < 0) exitWith { true; };

([_namespace, [
    ["KPLIB_logistics_endpoints", []]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_endpoints"
    , "_convoy"
];

// So that we are indeed working with a genuine copy
private _loadedConvoy = +_convoy;

_endpoints params [
    ["_alpha", [], [[]], 4]
    , ["_bravo", [], [[]], 4]
];

_alpha params [
    ["_alphaPos", +KPLIB_zeroPos, [[]], 3]
    , ["_alphaMarker", "", [""]]
    , ["_alphaMarkerText", "", [""]]
    , ["_alphaBillValue", +KPLIB_resources_storageValueDefault, [[]], 3]
];

// Nothing billed to ALPHA
if (_alphaBillValue isEqualTo KPLIB_resources_storageValueDefault) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_tryLoadNextTransport] Nothing billed: [_alphaBillValue]: %1"
            , str [_alphaBillValue]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    true;
};

private _loadValue = [_namespace] call KPLIB_fnc_logisticsSM_getLoadVolumes;

// Unable to bill
if (_loadValue isEqualTo KPLIB_resources_storageValueDefault) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_tryLoadNextTransport] Unable to bill: [_alphaBillValue, _loadValue]: %1"
            , str [_alphaBillValue, _loadValue]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

if (!([_alphaMarker, _loadValue, KPLIB_fnc_resources_pay] call KPLIB_fnc_logisticsSM_onApplyTransaction)) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_tryLoadNextTransport] Unable to pay: [_alphaBillValue, _loadValue]: %1"
            , str [_alphaBillValue, _loadValue]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

_loadedConvoy set [_transportIndex, _loadValue];

// Bill value less load value, in LINQ zip manner...
private _remainingValue = [_alphaBillValue, _loadValue, {(_this#0) - (_this#1)}] call KPLIB_fnc_linq_zip;
// TODO: TBD: probably unnecessary to set so much here...
private _loadedEndpoints = +[[_alphaPos, _alphaMarker, _alphaMarkerText, _remainingValue], _bravo];

[_namespace, [
    ["KPLIB_logistics_endpoints", _loadedEndpoints]
    , [KPLIB_logistics_convoy, _loadedConvoy]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsSM_tryLoadNextTransport] Fini: [_endpoints, _loadedEndpoints, _convoy, _loadedConvoy]: %1"
        , str [_endpoints, _loadedEndpoints, _convoy, _loadedConvoy]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
