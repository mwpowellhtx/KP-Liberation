/*
    KPLIB_fnc_logisticsMgr_onUnload

    File: fn_logisticsMgr_onUnload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-27 15:14:54
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

// Announce to the server...
["KPLIB_logiticsSM_onLogisticsMgrClosed", [clientOwner]] call CBA_fnc_serverEvent;

// And unload bits from the 'uiNamespace' ...
uiNamespace setVariable ["KPLIB_logisticsMgr_display", nil];

uiNamespace setVariable ["KPLIB_logisticsMgr_lnbLines", nil];

uiNamespace setVariable ["KPLIB_logisticsMgr_lnbTelemetry", nil];

// // TODO: TBD: do not know if there is a way to clear or delete a hashmap once it is created
// // TODO: TBD: but since it is effectively a singleton useful for one purpose only, should be fine...
// // TODO: TBD: will leave it in for now...
//uinamespace setVariable ["KPLIB_logisticsMgr_telemetryReport", nil];

uiNamespace setVariable ["KPLIB_logisticsMgr_lnbConvoy", nil];

uiNamespace setVariable ["KPLIB_logisticsMgr_cboAlpha", nil];
uiNamespace setVariable ["KPLIB_logisticsMgr_cboBravo", nil];

true;
