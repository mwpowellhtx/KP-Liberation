#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onReport

    File: fn_hud_onReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 11:18:59
    Last Update: 2021-06-14 17:01:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Facilitates the general HUD pattern in three simple steps.
            1. Raise a UUID specific request for 'KPLIB_hud_reporting'
            2. Raise a UUID specific request for 'KPLIB_hud_report'
            3. Schedule for the next HUD report period

        The 'KPLIB_hud_reporting' event is the subscriber opportunity to measure and record
        any details that might be important for the subscribing HUD feature to do its work.

        The 'KPLIB_hud_report' event is the HUD update itself. This is the moment when
        subscribers should evaluate whether to cut in or out whatever resources are necessary
        in order to present or hide their respective HUD elements, do any refreshes of the same,
        and so forth.

        Last but not least, schedule a next report period to be invoked.

    Parameters:
        _report - REPORT for which the sequence occurred [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

params [
    [Q(_report), locationNull, [locationNull]]
];

private _player = player;

private _debug = MPARAM(_onReport_debug)
    || (_player getVariable [QMVAR(_onReport_debug), false])
    || (_report getVariable [QMVAR(_onReport_debug), false])
    ;

if (_debug) then {
    [format ["[fn_hud_onReport] Reporting: [isNull _report, isNull _player]: %1"
        , str [isNull _report, isNull _player]], "HUD", true] call KPLIB_fnc_common_log;
};

[QMVAR(_reporting), [_player, _report]] call CBA_fnc_localEvent;

if (_debug) then {
    [format ["[fn_hud_onReport] Report: [isNull _report, isNull _player]: %1"
        , str [isNull _report, isNull _player]], "HUD", true] call KPLIB_fnc_common_log;
};

[QMVAR(_report), [_player, _report]] call CBA_fnc_localEvent;

if (_debug) then {
    [format ["[fn_hud_onReport] WAE Next: [%1]: %2"
        , QMPARAM(_reportPeriod)
        , str [MPARAM(_defaultPeriod)]
        ], "HUD", true] call KPLIB_fnc_common_log;
};

[
    { _this call MFUNC(_onReport); }
    , [_report]
    , _report getVariable [QMVAR(_reportPeriod), MPARAM(_defaultPeriod)]
] call CBA_fnc_waitAndExecute;

if (_debug) then {
    ["[fn_hud_onReport] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
