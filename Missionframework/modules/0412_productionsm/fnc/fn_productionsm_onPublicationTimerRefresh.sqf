/*
    KPLIB_fnc_productionsm_onPublicationTimerRefresh

    File: fn_productionsm_onPublicationTimerRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-21 13:52:24
    Last Update: 2021-02-21 13:52:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes or creates the timer afresh, depending on the conditions.

    Parameter(s):
        _period - the timer period [SCALAR, default: KPLIB_param_productionsm_publisherPeriodSeconds]
        _restart - whether to restart the timer entirely [BOOL, default: false]

    Returns:
        The event handler is fini [BOOL]
 */

params [
    ["_restart", false, [false]]
    , ["_period", KPLIB_param_productionsm_publisherPeriodSeconds, [0]]
];

private _objSM = KPLIB_productionsm_objSM;

private _publicationTimer = _objSM getVariable ["KPLIB_productionsm_publicationTimer", []];

private _newTimer = if (_restart || !(_publicationTimer call KPLIB_fnc_timers_isRunning)) then {
    [_period] call KPLIB_fnc_timers_create;
} else {
    _publicationTimer call KPLIB_fnc_timers_refresh;
};

_objSM setVariable ["KPLIB_productionsm_publicationTimer", _newTimer];

true;
