/*
    KPLIB_fnc_logisticsCO_onMissionAbortEntering

    File: fn_logisticsCO_onMissionAbortEntering.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 12:22:34
    Last Update: 2021-03-06 12:22:36
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
        {KPLIB_param_logisticsCO_onMissionAbortEntering_debug}
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

[
    [_namespace, KPLIB_logistics_status_unloading] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_aborting] call KPLIB_fnc_logistics_checkStatus
    , [_namespace, KPLIB_logistics_status_ambushed] call KPLIB_fnc_logistics_checkStatus
] params [
    "_unloading"
    , "_aborting"
    , "_ambushed"
];

/* May be "forced", i.e. when responding during automated MISSION COMPLETE scenarios, etc.
 * For good measure, we also verify that the STATUS was actually UNLOADING... */

((_cid < 0) && _unloading) || !(_aborting || _ambushed);
