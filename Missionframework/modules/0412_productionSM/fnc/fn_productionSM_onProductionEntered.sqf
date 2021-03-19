/*
    KPLIB_fnc_productionSM_onProductionEntered

    File: fn_productionSM_onProductionEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 17:06:52
    Last Update: 2021-03-19 10:22:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Produces the next resource in QUEUE. Simply tries to produce the next resource in
        QUEUE, and that is all. Any further scheduling is handled as a result of state
        transition from PRODUCTION back to PENDING.

    Parameter(s):
        _namespace - a CBA PRODUCTION namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_callerName", "fn_productionSM_onProductionEntered", [""]]
];

// Simply "try producing the resource" and that is all
[_namespace] call KPLIB_fnc_productionSM_tryResourceProduction;
