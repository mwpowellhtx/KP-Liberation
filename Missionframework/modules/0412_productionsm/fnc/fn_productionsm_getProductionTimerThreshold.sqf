/*
    KPLIB_fnc_productionsm_getProductionTimerThreshold

    File: fn_productionsm_getProductionTimerThreshold.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-22 21:28:56
    Last Update: 2021-02-22 21:28:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns with the 'KPLIB_productionsm_productionTimerThresholdSecondsDebug',
        starting with the narrowest namespace and workout out to larger namespaces.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The most appropriate 'KPLIB_productionsm_productionTimerThresholdSecondsDebug' [SCALAR]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _objSM = KPLIB_productionsm_objSM;

// Get the first available timer threshold preferring the narrowest scope first
[[_namespace, _objSM, missionNamespace]] call {
    params [
        ["_targets", [], [[]]]
    ];
    private _default = 0;
    private _thresholds = _targets apply {
        _x getVariable ["KPLIB_productionsm_productionTimerThresholdSecondsDebug", (_default - 1)];
    } select {
        _x > _default;
    };
    if (_thresholds isEqualTo []) then {
        (_default - 1);
    } else {
        (_thresholds#0);
    }
};
