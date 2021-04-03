#include "script_component.hpp"

// ...
// TODO: TBD: using cutRsc, no opportunity for onUnload...
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
// https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload

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
