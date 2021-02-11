/*
    KPLIB_fnc_productionMgr_btnDequeue_onButtonClick

    File: fn_productionMgr_btnDequeue_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 19:17:51
    Last Update: 2021-02-10 19:17:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Dequeues the currently selected resource in the queue. Dequeuing the pending
        resource means necessarily resetting the timer after server processing has
        completed.

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull, unused]

    Returns:
        The module event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_ctrl", controlNull, [controlNull]]
];

if (_debug) then {
    ["[fn_productionMgr_btnDequeue_onButtonClick] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    ["[fn_productionMgr_btnDequeue_onButtonClick] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
