/*
    KPLIB_fnc_logisticsCO_onMissionAbandoned

    File: fn_logisticsCO_onMissionAbandoned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 13:02:33
    Last Update: 2021-03-13 13:02:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The response here is light, simply setting the flag when we determine that
        the mission was in fact ABANDONED during the ENTERING screening callback.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionAbandoned_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandoned] Entering: [isNull _namespace, isNull _changeOrder]: %1"
        , str [isNull _namespace, isNull _changeOrder]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
];

_status = [_status, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_setStatus;

[_namespace, [
    ["KPLIB_logistics_status", _status]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    [format ["[fn_logisticsCO_onMissionAbandoned] Fini: [_status]: %1"
        , str [_status]], "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

true;
