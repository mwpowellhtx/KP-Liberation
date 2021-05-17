/*
    KPLIB_fnc_logisticsMgr_onLoad

    File: fn_logisticsMgr_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:51:44
    Last Update: 2021-05-17 18:56:01
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
    [format ["[fn_logisticsMgr_onLoad] Entering: [isNull _display]: %1"
        , str [isNull _display]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

uiNamespace setVariable ["KPLIB_logisticsMgr_display", _display];

// And announce to the server...
[KPLIB_logisticsSM_onLogisticsMgrOpened, [clientOwner]] call CBA_fnc_serverEvent;

[{
    params ["", "_pfhHandle"];

    private _display = uiNamespace getVariable ["KPLIB_logisticsMgr_display", displayNull];

    if (isNull _display) exitWith {
        [_pfhHandle] call CBA_fnc_removePerFrameHandler;
    };

    ([] call KPLIB_fnc_logisticsMgr_calculateToEnableOrDisable) params [
        ["_toEnable", [], [[]]],
        ["_toDisable", [], [[]]]
    ];

    {
        _x params ["_idcs", "_state"];
        { _display displayCtrl _state; } forEach _idcs;
    } forEach [
        [_toEnable, true]
        , [_toDisable, false]
    ];

}, KPLIB_param_logisticsMgr_enableOrDisablePeriod, []] call CBA_fnc_addPerFrameHandler;

if (_debug) then {
    ["[fn_logisticsMgr_onLoad] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
