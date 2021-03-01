/*
    KPLIB_fnc_logisticsMgr_lnbLines_onLoad

    File: fn_logisticsMgr_lnbLines_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-27 15:14:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _lnbLines - the logistics lines LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_lnbLines_onLoad_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_lnbLines", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbLines_onLoad] Entering: [isNull _lnbLines]: %1"
        , str [isNull _lnbLines]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// We are really for only for the bookkeeping, which the actual row updates occur via sister callbacks
uiNamespace setVariable ["KPLIB_logisticsMgr_lnbLines", _lnbLines];

["KPLIB_logisticsSM_publishLines", [clientOwner]] call CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_logisticsMgr_lnbLines_onLoad] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
