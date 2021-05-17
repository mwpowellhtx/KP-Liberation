/*
    KPLIB_fnc_productionMgr_btnRefresh_onButtonClick

    File: fn_productionMgr_btnRefresh_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 21:27:15
    Last Update: 2021-02-09 21:27:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Refresh button onButtonClick event handler.

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull]

    Returns:
        Event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_btnRefresh_onButtonClick] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_ctrl", controlNull, [controlNull]]
];

// 'Forced' is implied now, by the fact that a manager dialog has been announced to the server
[KPLIB_productionSM_productionMgrOpened, [true, clientOwner]] call CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_productionMgr_btnRefresh_onButtonClick] Fini", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
