/*
    KPLIB_fnc_logisticsMgr_onEnableOrDisableCtrls

    File: fn_logisticsMgr_onEnableOrDisableCtrls.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-02 08:47:45
    Last Update: 2021-03-02 08:47:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Presents controls that should be enabled or disabled. Only operates when
        the manager display is open and registered in the UI namespace.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        ...
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_onEnableOrDisableCtrls_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

private _display = uiNamespace getVariable ["KPLIB_logisticsMgr_display", displayNull];

if (isNull _display) exitWith {
    ["KPLIB_logisticsMgr_disabledIdcs", "KPLIB_logisticsMgr_enabledIdcs"] select {
        if (toLower _x in allVariables uiNamespace) then {
            uiNamespace setVariable [_x, nil];
        };
        true;
    };
    false;
};

([] call KPLIB_fnc_logisticsMgr_calculateToEnableOrDisable) params [
    ["_toEnable", [], [[]]]
    , ["_toDisable", [], [[]]]
];

if (_debug) then {
    //if (!((_toEnable + _toDisable) isEqualTo [])) then {
    //    systemChat format ["[%1] [fn_logisticsMgr_onEnableOrDisableCtrls] Enable: %2, disable: %3", time, str _toEnable, str _toDisable];
    //};
    [format ["[fn_logisticsMgr_onEnableOrDisableCtrls] Enabling/disabling controls: [_toEnable, _toDisable]: %1"
        , str [_toEnable, _toDisable]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _onEnableCtrl = {
    params [
        ["_idc", -1, [0]]
        , ["_enable", true, [true]]
    ];
    ctrlEnable [_idc, _enable];
    true;
};

{ [_x] call _onEnableCtrl; } forEach _toEnable;
{ [_x, false] call _onEnableCtrl; } forEach _toDisable;

if (_debug) then {
    [format ["[fn_logisticsMgr_onEnableOrDisableCtrls] Fini: [_toEnable, _toDisable]: %1"
        , str [_toEnable, _toDisable]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_retval;
