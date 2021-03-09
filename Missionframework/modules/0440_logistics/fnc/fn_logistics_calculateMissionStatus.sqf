/*
    KPLIB_fnc_logistics_calculateMissionStatus

    File: fn_logistics_calculateMissionStatus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-08 09:48:38
    Last Update: 2021-03-08 09:48:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Calculates a TRANSIT PLAN given the ALPHA+BRAVO ENDPOINTS, consisting
        of both STATUS and TIMER. Always from the perspective of either, continue
        LOADING the CONVOY TRANSPORTS, or transition to EN_ROUTE when fully loaded.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        TRANSIT PLAN consisting of: [STATUS, TIMER] [ARRAY]
 */

// TODO: TBD: sprinkle in debugging, entering, fini, reports...
private _debug = [
    [
        {KPLIB_param_logistics_calculateMissionStatus_debug}
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

// Always LOADING, always...
private _status = KPLIB_logistics_status_loading;

_status;
