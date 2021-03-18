#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onLoad

    File: fn_productionMgr_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-20 12:38:22
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

private _eids = [];

{
    _x params [
        ["_eventName", "", [""]]
        , ["_callback", {}, [{}]]
    ];
    // Client is "here" because production manager dialog is open
    private _eid = [_eventName, _callback] call CBA_fnc_addEventHandler;
    _eids pushBack _eid;
    _display setVariable [_eventName, _eid];
} forEach [
    // TODO: TBD: so... production elem needs to be the one and only add/update handler...
    // TODO: TBD: due to the framework/scaffold of the running production statemachine...
    // TODO: TBD: i.e. when dlg opens, request would be for "all" ...
    // TODO: TBD: or when one changes and/or publisher timer elapsed, server posts to mgr automatically

    // // TODO: TBD: also rename 'KPLIB_fnc_productionMgr_client_onProductionResponse' to '...productionClient...'
    //["KPLIB_productionClient_onProductionResponse", KPLIB_fnc_productionMgr_client_onProductionResponse]
    //,

    // TODO: TBD: we will use the one response, either adds 'new' (to the mgr dlg) production elements, or updates existing ones
    // TODO: TBD: mgr dlg should BIS_fnc_sortBy 'parseNumber _gridref' ... ascending, by default...
    // TODO: TBD: although would be interesting to indicate sort order up or down... i.e. when clicking a title row, let's say...

    [KPLIB_productionMgr_productionStatePublished, KPLIB_fnc_productionMgr_onProductionStatePublished]
];

private _btnRefresh = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_BTNREFRESH;

// This is the first thing that happens when entering the dialog...
[_btnRefresh] spawn KPLIB_fnc_productionMgr_btnRefresh_onButtonClick;
// Use spawn because we are invoking such within the scope of an event handler.

if (_debug) then {
    [format ["[fn_productionMgr_onLoad] Fini: [_eids]: %1", str [_eids]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
