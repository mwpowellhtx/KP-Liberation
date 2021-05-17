/*
    KPLIB_fnc_logisticsCO_onMissionAbandoned

    File: fn_logisticsCO_onMissionAbandoned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-13 13:02:33
    Last Update: 2021-03-15 12:47:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The screening 'onChangeOrderEntered' callback has already cleared for the
        'onChangeOrder', so just do it here; i.e. set the ABANDONED STATUS flag.

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

// Just go ahead and set the ABANDONED flag
[_namespace, KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_setStatus;

if (_debug) then {
    ["[fn_logisticsCO_onMissionAbandoned] Fini", "LOGISTICSCO", true] call KPLIB_fnc_common_log;
};

true;
