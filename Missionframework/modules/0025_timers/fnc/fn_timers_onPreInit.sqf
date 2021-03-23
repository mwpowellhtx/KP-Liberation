/*
    KPLIB_fnc_timers_onPreInit

    File: fn_timers_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-03 15:36:44
    Last Update: 2021-02-03 15:36:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:

    Parameter(s):

    Returns:

    Reference:
*/

if (isServer) then {
    [format ["[fn_timers_onPreInit] Initializing..."], "PRE] [TIMERS", true] call KPLIB_fnc_common_log;
};

if (isServer) then {
    // Probably dangerous to wait in such a tight loop
    while {serverTime <= 0} do {};
};

// Negative, or -1, when timer bits are considered inactive or disabled
KPLIB_timers_disabled = -1;

// Specification for the default timers tuple; verbose, yes, and self-documenting
private _default = [] call {
    params [
        ["_duration", KPLIB_timers_disabled, [0]]
        , ["_startTime", [] call KPLIB_fnc_timers_now, [0]]
        , ["_elapsedTime", 0, [0]]
        , ["_timeRemaining", 0, [0]]
    ];
    [_duration, _startTime, _elapsedTime, _timeRemaining];
};

// TODO: TBD: we may only need/want timers on the server end of things...
// TODO: TBD: which informs things such as production, logistics timers...
// TODO: TBD: little to none of which we think has anything to do with client side anything...
// TODO: TBD: except perhaps rendering timer bits to dialogs, etc... so... consider carefully.
KPLIB_timers_default = +_default;

if (hasInterface) then {
    KPLIB_timers_renderedNotRunning = localize "STR_KPLIB_PRODUCTIONMGR_TXTTIMEREM_IDLE";
};

if (isServer) then {
    [format ["[fn_timers_onPreInit] Initialized"], "PRE] [TIMERS", true] call KPLIB_fnc_common_log;
};

true
