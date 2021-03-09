/*
    KPLIB_fnc_logisticsSM_onConfirmReturn

    File: fn_logisticsSM_onConfirmReturn.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 17:00:45
    Last Update: 2021-03-07 12:28:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Confirms the [BRAVO, ALPHA] return mission.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [ARRAY]
 */

// TODO: TBD: add logging, etc
private _debug = [
    [
        {KPLIB_param_logisticsSM_onConfirmReturnMission_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_uuid", ""]
    , ["KPLIB_logistics_endpoints", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
    , "_endpoints"
];

// CONTINUE MISSION, swap the ENDPOINTS, BRAVO becomes ALPHA, and vice versa...
private _swapped = [_endpoints] call KPLIB_fnc_logistics_swapEndpoints;

// ...then request 'automated' MISSION CONFIRM, i.e. did not originate from client
[_targetUuid, _swapped] call KPLIB_fnc_logisticsCO_onRequestMissionConfirm;
