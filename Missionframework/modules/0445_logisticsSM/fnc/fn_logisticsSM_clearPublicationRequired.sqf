/*
    KPLIB_fnc_logisticsSM_clearPublicationRequired

    File: fn_logisticsSM_clearPublicationRequired.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 11:21:09
    Last Update: 2021-03-04 11:21:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Clears the CBA logistics namespace 'KPLIB_logistics_publicationRequired' flag.
        Also re-sets the 'KPLIB_logistics_broadcastTimer' upon this visiting operator.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [ARRAY]
 */

private _debug = [
    [
        {KPLIB_logisticsSM_clearBroadcastRequired_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

param [
    ["_namespace", locationNull, [locationNull]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_clearPublicationRequired] Entering: []: %1"
        , str [isNull _namespace]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (isNull _namespace) exitWith {
    if (_debug) then {
        ["[fn_logisticsSM_clearPublicationRequired] Null and done", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _required = _namespace getVariable ["KPLIB_logistics_publicationRequired", "nil"];
private _broadcastTimer = _namespace getVariable ["KPLIB_logistics_publicationTimer", []]

if (_debug) then {
    [format ["[fn_logisticsSM_clearPublicationRequired] Optimize: [_required, _broadcastTimer call KPLIB_fnc_timers_hasElapsed, _broadcastTimer]: %1"
        , str [_required, _broadcastTimer call KPLIB_fnc_timers_hasElapsed, _broadcastTimer]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_namespace setVariable ["KPLIB_logistics_publicationRequired", false];

_namespace setVariable ["KPLIB_logistics_publicationTimer"
    , [KPLIB_param_logistics_publicationTimerPeriod] call KPLIB_fnc_timers_create];

if (_debug) then {
    ["[fn_logisticsSM_clearPublicationRequired] Fini", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
