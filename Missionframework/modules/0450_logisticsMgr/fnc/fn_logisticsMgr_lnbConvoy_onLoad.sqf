/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onLoad

    File: fn_logisticsMgr_lnbConvoy_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:57:10
    Last Update: 2021-02-28 09:57:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to the CONVOY LISTNBOX 'onLoad' event.

    Parameters:
        _lnbConvoy - the logistics convoy LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_lnbConvoy_onLoad_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_lnbConvoy", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbConvoy_onLoad] Entering: [isNull _lnbConvoy, isNull _config]: %1"
        , str [isNull _lnbConvoy, isNull _config]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// Always 'clear' the LISTNBOX so to speak, regardless... just for UI presentation, consistency, etc
if (!([_lnbConvoy] call KPLIB_fnc_logisticsMgr_lnbConvoy_onClear)) exitWith {
    false;
};

uiNamespace setVariable ["KPLIB_logisticsMgr_lnbConvoy", _lnbConvoy];

if (_debug) then {
    ["[fn_logisticsMgr_lnbConvoy_onLoad] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
