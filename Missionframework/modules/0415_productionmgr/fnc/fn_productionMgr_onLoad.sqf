#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onLoad

    File: fn_productionMgr_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-09 21:16:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module display onLoad event handler.

    Parameter(s):
        _display - the display [DISPLAY]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/spawn
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_onLoad] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_display", displayNull, [displayNull]]
];

// Used to identify the actual storage location
createMarkerLocal ["_productionMgrStorage", KPLIB_zeroPos];

{
    _x params [
        ["_eventName", "", [""]]
        , ["_callback", {}, [{}]]
    ];
    // Client is "here" because production manager dialog is open
    private _eid = [_eventName, _callback] call CBA_fnc_addEventHandler;
    _display setVariable [_eventName, _eid];
} forEach [
    ["KPLIB_productionMgr_onProductionResponse", KPLIB_fnc_productionMgr_client_onProductionResponse]
    , ["KPLIB_productionMgr_onProductionElemResponse", KPLIB_fnc_productionMgr_client_onProductionElemResponse]
];

private _btnRefresh = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_BTNREFRESH;

// This is the first thing that happens when entering the dialog...
[_btnRefresh] spawn KPLIB_fnc_productionMgr_btnRefresh_onButtonClick;
// Use spawn because we are invoking such within the scope of an event handler.

if (_debug) then {
    [format ["[fn_productionMgr_onLoad] Finished: [_eid]: %1", str [_eid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
