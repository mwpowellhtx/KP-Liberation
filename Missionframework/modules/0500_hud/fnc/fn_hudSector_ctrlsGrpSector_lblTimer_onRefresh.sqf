#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_ctrlsGrpSector_lblTimer_onRefresh

    File: fn_hudSector_ctrlsGrpSector_lblTimer_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the SECTOR HUD overlay timer.

    Parameters:
        _lblTimer - a timer control [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

private _debug = [
    [
        {MPARAM2(Sector,_ctrlsGrpSector_lblTimer_onRefresh_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblTimer), controlNull, [controlNull]]
];

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblTimer_onRefresh] Entering: [isNull _lblTimer]: %1"
        , str [isNull _lblTimer]], "HUD", true] call KPLIB_fnc_common_log;
};

if (isNull _lblTimer) exitWith {
    false;
};

([nil, KPLIB_hudDispatchSM_sectorReport_lnbTimerText_viewDataKeys] call MFUNC2(Sector,_getViewData)) params [
    [Q(_timer), [], [[]]]
    , [Q(_timerColor), [0, 0, 0, 0], [[]]]
];

[
    _timer call KPLIB_fnc_timers_isRunning
    , _timer call KPLIB_fnc_timers_renderComponentString
] params [
    Q(_running)
    , Q(_renderedTimerText)
];

_lblTimer ctrlSetText _renderedTimerText;
_lblTimer ctrlSetTextColor _timerColor;
_lblTimer ctrlShow _running;
_lblTimer ctrlCommit 0;

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblTimer_onRefresh] Fini: [ctrlIDC _lblTimer, _timer, _running, _renderedTimerText, _timerColor]: %1"
        , str [ctrlIDC _lblTimer, _timer, _running, _renderedTimerText, _timerColor]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
