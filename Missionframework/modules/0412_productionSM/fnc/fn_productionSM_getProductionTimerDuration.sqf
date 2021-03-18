/*
    KPLIB_fnc_productionSM_getProductionTimerDuration

    File: fn_productionSM_getProductionTimerDuration.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 19:23:53
    Last Update: 2021-03-17 19:23:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns with the 'KPLIB_param_productionSM_preemptiveLeadTimeDuration',
        especially as filtered by the 'KPLIB_param_productionSM_preemptLeadTime',
        starting with the narrowest namespace and workout out to larger namespaces,
        if possible. Defaults to 'KPLIB_param_production_leadTime' when no candidates
        were successfully identified.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The most appropriate 'KPLIB_param_productionSM_preemptiveLeadTimeDuration'
        or 'KPLIB_param_production_leadTime' by default [SCALAR]
 */

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _debug = [
    [
        {KPLIB_param_productionSM_getProductionTimerDuration_debug}
        , {_objSM getVariable ["KPLIB_param_productionSM_getProductionTimerDuration_debug", false]}
    ]
] call KPLIB_fnc_productionSM_debug;

// Distill candidate lead times from the namespaces starting with the most specific
private _allCandidates = [_namespace, _objSM, missionNamespace] apply {
    [
        _x getVariable ["KPLIB_param_productionSM_preemptLeadTime", false]
        , _x getVariable ["KPLIB_param_productionSM_preemptiveLeadTimeDuration", -1]
    ];
};

// Default to fall back on failing any of the leading candidates
private _defaultIndex = _allCandidates pushBack [true, KPLIB_param_production_leadTime];

private _candidates = _allCandidates select { (_x#0) && (_x#1) > 0 };

// Should always have at least one
(_candidates#0#1);
