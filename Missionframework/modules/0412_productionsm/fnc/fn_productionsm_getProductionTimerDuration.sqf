/*
    KPLIB_fnc_productionsm_getProductionTimerDuration

    File: fn_productionsm_getProductionTimerDuration.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-23 13:04:39
    Last Update: 2021-02-23 13:04:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns with the 'KPLIB_param_productionsm_preemptiveLeadTimeDuration',
        especially as filtered by the 'KPLIB_param_productionsm_preemptLeadTime',
        starting with the narrowest namespace and workout out to larger namespaces,
        if possible. Defaults to 'KPLIB_param_production_leadTime' when no candidates
        were successfully identified.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The most appropriate 'KPLIB_param_productionsm_preemptiveLeadTimeDuration'
        or 'KPLIB_param_production_leadTime' by default [SCALAR]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _objSM = KPLIB_productionsm_objSM;

// Distill candidate lead times from the namespaces starting with the most specific
private _candidates = [_namespace, _objSM, missionNamespace] apply {
    [
        _x getVariable ["KPLIB_param_productionsm_preemptLeadTime", false]
        , _x getVariable ["KPLIB_param_productionsm_preemptiveLeadTimeDuration", -1]
    ];
} select { (_x#0) && (_x#1) > 0 };

if (!(_candidates isEqualTo [])) exitWith {
    _candidates#0#1;
};

KPLIB_param_production_leadTime;
