/*
    KPLIB_fnc_logisticsSM_tryUnloadNextTransport

    File: fn_logisticsSM_tryUnloadNextTransport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:27:37
    Last Update: 2021-03-05 01:12:09
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
        {KPLIB_param_logisticsSM_tryUnloadNextTransport_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_tryUnloadNextTransport] Entering: [isNull _namespace]: %1"
        , str [isNull _namespace]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (isNull _namespace) exitWith { false; };

private _transportIndex = [_namespace] call KPLIB_fnc_logistics_findNextTransportIndex;

if (_debug) then {
    [format ["[fn_logisticsSM_tryUnloadNextTransport] May unload: [_transportIndex]: %1"
        , str [_transportIndex]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// Nothing further to unload in any event
if (_transportIndex < 0) exitWith { true; };

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
    , [KPLIB_logistics_timer, []]
    , ["KPLIB_logistics_endpoints", []]
    , [KPLIB_logistics_convoy, []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
    , "_timer"
    , "_endpoints"
    , "_convoy"
];

// Make a genuine copy of the array
private _unloadedConvoy = +_convoy;

_endpoints params [
    ["_alpha", [], [[]], 4]
    , ["_bravo", [], [[]], 4]
];

_bravo params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
];

private _transportValue = _unloadedConvoy select _transportIndex;

if (!([_markerName, _transportValue] call KPLIB_fnc_logisticsSM_onApplyTransaction)) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsSM_tryUnloadNextTransport] Unable to apply transaction: [_markerName, _transportValue]: %1"
            , str [_markerName, _transportValue]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

_unloadedConvoy set [_transportIndex, +KPLIB_resources_storageValueDefault];

[_namespace, [
    [KPLIB_logistics_convoy, _unloadedConvoy]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsSM_tryUnloadNextTransport] Unable to apply transaction: [_markerName, _transportIndex, _convoy, _unloadedConvoy]: %1"
        , str [_markerName, _transportIndex, _convoy, _unloadedConvoy]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
