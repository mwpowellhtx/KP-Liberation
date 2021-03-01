/*
    KPLIB_fnc_logisticsMgr_btnRefresh_onButtonClick

    File: fn_logisticsMgr_btnRefresh_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 16:59:53
    Last Update: 2021-02-28 16:59:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Refresh button 'onButtonClick' event handler.

    Parameters:
        _btnRefresh - the button control [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_btnRefresh_onButtonClick_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_btnRefresh", controlNull, [controlNull]]
];

if (_debug) then {
    ["[fn_logisticsMgr_btnRefresh_onButtonClick] Entering", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// Request logistics lines publication from the server and get out of the way ASAP
["KPLIB_logisticsSM_publishLines", [clientOwner]] call CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_logisticsMgr_btnRefresh_onButtonClick] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
