/*
    KPLIB_fnc_logisticsCO_onMissionConfirmEntering

    File: fn_logisticsCO_onMissionConfirmEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 15:13:15
    Last Update: 2021-03-06 15:13:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Entering logistics change order activity, this is the moment when that subsystem
        activity may be prohibited.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _changeOrder - a CBA change order namespace [LOCATION, default: locationNull]

    Returns:
        Whether the change order may be further processed [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onMissionConfirmEntering_debug}
    ]
] call KPLIB_fnc_logisticsCO_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_changeOrder", locationNull, [locationNull]]
];

([_changeOrder, [
    ["KPLIB_logistics_cid", -1]
]] call KPLIB_fnc_namespace_getVars) params [
    "_cid"
];

if (_cid < 0) exitWith {
    // TODO: TBD: do some logging...
    true;
};

([_namespace, [
    ["KPLIB_logistics_status", KPLIB_logistics_status_standby]
]] call KPLIB_fnc_namespace_getVars) params [
    "_status"
];

// LOGISTICS MANAGER may only CONFIRM MISSION when in STANDBY
_status == KPLIB_logistics_status_standby;
