/*
    KPLIB_fnc_logisticsMgr_onLoad

    File: fn_logisticsMgr_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:51:44
    Last Update: 2021-02-28 09:51:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The display 'onLoad' event handler.

    Parameters:
        _display - The display [DISPLAY, default: displayNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/displayNull
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_onLoad_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_display", displayNull, [displayNull]]
];

if (_debug) then {
    ["[fn_logisticsMgr_onLoad] Entering", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

uiNamespace setVariable ["KPLIB_logisticsMgr_display", _display];

// And announce to the server...
[KPLIB_logisticsSM_onLogisticsMgrOpened, [clientOwner]] call CBA_fnc_serverEvent;

[
    {
        ([] call KPLIB_fnc_logisticsMgr_calculateToEnableOrDisable) params [
            ["_toEnable", [], [[]]]
            , ["_toDisable", [], [[]]]
        ];

        { _x ctrlEnable true; } forEach (_toEnable apply { _display displayCtrl _x; });
        { _x ctrlEnable false; } forEach (_toDisable apply { _display displayCtrl _x; });
    }
    , KPLIB_param_logisticsMgr_enableOrDisablePeriod
    , []
    , {}
    , {}
    , {
        _display = uiNamespace getVariable ["KPLIB_logisticsMgr_display", displayNull];
        !isNull _display;
    }
    , {
        _display = uiNamespace getVariable ["KPLIB_logisticsMgr_display", displayNull];
        isNull _display;
    }
    , [
        "_display"
    ]
] call CBA_fnc_createPerFrameHandlerObject;

if (_debug) then {
    ["[fn_logisticsMgr_onLoad] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
