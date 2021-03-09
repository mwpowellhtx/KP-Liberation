/*
    KPLIB_fnc_logistics_calculateTransitWindow

    File: fn_logistics_calculateTransitWindow.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 12:35:02
    Last Update: 2021-03-07 12:35:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Calculates the TRANSIT WINDOW, the minimum and maximum times during the route
        when enemy sector blockage, insurgent ambush, and destination endpoint arrival,
        may be determined. This occurs as a function of the logistics time and speed
        parameters, as well as 'KPLIB_param_fobRange'.

    Parameters:
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The time window for use throughout the logistics transit evaluation [ARRAY, default: [MIN, MAX]]
 */

// TODO: TBD: sprinkle in debugging, entering, fini, reports...
private _debug = [
    [
        {KPLIB_param_logistics_calculateTransitWindow_debug}
    ]
] call KPLIB_fnc_logistics_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_timer", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timer"
];

_timer params ["_duration"];

private _fobRangeSeconds = [] call KPLIB_fnc_logistics_calculateFobRangeSeconds;

[_fobRangeSeconds, _duration - _fobRangeSeconds];
