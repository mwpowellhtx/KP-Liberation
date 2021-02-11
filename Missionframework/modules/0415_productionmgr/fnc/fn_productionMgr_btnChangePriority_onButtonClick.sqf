/*
    KPLIB_fnc_productionMgr_btnChangePriority_onButtonClick

    File: fn_productionMgr_btnChangePriority_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 19:17:51
    Last Update: 2021-02-10 19:17:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Apply the pending changes to the server for consideration.

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull, unused]
        _direction - the direction of change, increase or decrease, two values are accepted [SCALAR, default: 0]
            [1] increase in priority, move the value up one position in the queue
            [-1] decrease in priority, move the value down one position in the queue

    Returns:
        NONE

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_ctrl", controlNull, [controlNull]]
    , ["_args", [], [[]]]
];

_args params [
    ["_direction", 0, [0]]
];

if (_debug) then {
    [format ["[fn_productionMgr_btnChangePriority_onButtonClick] Entering: _args: %1"
        , str _args], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    ["[fn_productionMgr_btnChangePriority_onButtonClick] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
