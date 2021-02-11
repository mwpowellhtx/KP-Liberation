#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_txtTimeRem_onLoad

    File: fn_productionMgr_txtTimeRem_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 00:59:57
    Last Update: 2021-02-10 01:00:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module formatted time remaining label onLoad event handler.

    Parameter(s):
        _lblTimeRemainingFormatted - the label control [CONTROL]

    Returns:
        Module event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_txtTimeRem_onLoad] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_lblTimeRemainingFormatted", controlNull, [controlNull]]
];

private _defaultView = [KPLIB_timers_renderedNotRunning, ""];

private _view = _lblTimeRemainingFormatted getVariable ["_view", _defaultView];

_lblTimeRemainingFormatted ctrlSetText (_view#0);

if (_debug) then {
    [format ["[fn_productionMgr_txtTimeRem_onLoad] Finished: [_view]: %1"
        , str [_view]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
