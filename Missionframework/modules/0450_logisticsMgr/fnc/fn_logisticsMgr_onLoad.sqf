/*
    KPLIB_fnc_logisticsMgr_onLoad

    File: fn_logisticsMgr_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:51:44
    Last Update: 2021-02-28 09:51:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The display 'onUnload' event handler.

    Parameters:
        _display - The display [DISPLAY, default: displayNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/displayNull
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
 */

params [
    ["_display", displayNull, [displayNull]]
];

uiNamespace setVariable ["KPLIB_logisticsMgr_display", _display];

// And announce to the server...
["KPLIB_logiticsSM_onLogisticsMgrOpened", [clientOwner]] call CBA_fnc_serverEvent;

true;
