/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_onLoad

    File: fn_logisticsMgr_cboEndpoint_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:52:40
    Last Update: 2021-02-28 09:52:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The display 'onUnload' event handler.

    Parameters:
        _display - The display [DISPLAY, default: displayNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/displayNull
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
 */

params [
    ["_lnbEndpoint", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

// TODO: TBD: and maybe some logging...
private _endpoint = getText (_config >> "endpoint");

// Sets the appropriate namespace CBO variable depending on ALPHA or BRAVO config...
switch (toUpper _endpoint) do {
    case "ALPHA": {
        uiNamespace setVariable ["KPLIB_logisticsMgr_cboAlpha", _lnbEndpoint];
    };
    case "BRAVO": {
        uiNamespace setVariable ["KPLIB_logisticsMgr_cboBravo", _lnbEndpoint];
    };
};

// TODO: TBD: anything else to do 'onLoad'?

true;