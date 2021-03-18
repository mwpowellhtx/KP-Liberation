/*
    KPLIB_fnc_productionSM_onProductionEntered

    File: fn_productionSM_onProductionEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 17:06:52
    Last Update: 2021-03-17 18:52:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Produces the next resource in queue. Updates the queue and schedules the timer
        upon successful production.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_callerName", "fn_productionSM_onProductionEntered", [""]]
];

// Update queue and schedule the timer when resource production successful
if ([_namespace] call KPLIB_fnc_productionSM_tryResourceProduction) then {
    {
        [_namespace] call _x;
    } forEach [
        KPLIB_fnc_productionSM_onUpdateQueue
        , KPLIB_fnc_productionSM_onScheduleTimer
    ];
};

true;
