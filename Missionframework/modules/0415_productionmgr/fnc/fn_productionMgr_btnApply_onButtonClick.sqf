/*
    KPLIB_fnc_productionMgr_btnApply_onButtonClick

    File: fn_productionMgr_btnApply_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 19:17:51
    Last Update: 2021-02-10 19:17:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Apply the pending changes to the server for consideration.

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull, unused]

    Returns:
        NONE

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_btnApply_onButtonClick] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: much to consider here...
// TODO: TBD: during this sprint? ... maybe... at least for a "direct" change order...
// TODO: TBD: however, in the coming next sprint(s), consider a change order queue, FSM processing, etc...
// TODO: TBD: additionally, what UI segments can be incrementally posted by the server, i.e. running timer, while leaving queue alone, unless there has been a change in the queue...

if (_debug) then {
    ["[fn_productionMgr_btnApply_onButtonClick] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
