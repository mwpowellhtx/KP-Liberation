/*
    KPLIB_fnc_logisticsSM_onTransition_toUnloadingEntered

    File: fn_logisticsSM_onTransition_toUnloadingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 18:37:17
    Last Update: 2021-03-05 18:00:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
];

// ([_namespace, [
//     ["KPLIB_logistics_uuid", ""]
//     , ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
//     , ["KPLIB_logistics_endpoints", []]
// ]] call KPLIB_fnc_namespace_getVars) params [
//     "_targetUuid"
//     , "_status"
//     , "_endpoints"
// ];

private _transportIndex = [_namespace] call KPLIB_fnc_logistics_findNextTransportIndex;
private _tried = [_namespace, _transportIndex] call KPLIB_fnc_logisticsSM_tryUnloadNextTransport;

// TODO: TBD: if we can get a more diagnostic result then do so...
_status = if (_tried) then {
    // Continue mission UNLOADING, or complete either ABORT (STANDBY) or CONFIRM (SWAP ENDPOINTS), as determined by the PLAN
    [_namespace] call KPLIB_fnc_logistics_calculateUnloadingStatus;
} else {
    // UNLOADING blocked due to NO_SPACE, then park it...
    [_status, KPLIB_logistics_status_noSpace] call KPLIB_fnc_logistics_setStatus;
};

// Do not re-set any TIMER, allow it to continue running until NO_RESOURCE has cleared
[_namespace, [
    ["KPLIB_logistics_status", _status]
]] call KPLIB_fnc_namespace_setVars;

true;
