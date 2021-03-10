/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_onLBSelChanged

    File: fn_logisticsMgr_cboEndpoint_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:52:40
    Last Update: 2021-03-01 20:06:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The '_cboEndpoint' 'onLoad' event handler. Pretty much the only thing this
        event handler does is to handle some UI bookkeeping, staging controls for
        event handlers, callbacks, etc, later on.

    Parameters:
        _cboEndpoint - the ENDPOINT CT_COMBO control [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/controlNull
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_onLBSelChanged_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onLBSelChanged] Entering: [isNull _cboEndpoint, _selectedIndex]: %1"
        , str [isNull _cboEndpoint, _selectedIndex]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

if (_selectedIndex < 0) exitWith {
    if (_debug) then {
        ["[fn_logisticsMgr_cboEndpoint_onLBSelChanged] Row not selected", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _endpointMarker = _cboEndpoint lbData _selectedIndex;

[markerPos _endpointMarker] spawn KPLIB_fnc_logisticsMgr_ctrlMap_onReload;

[] call KPLIB_fnc_logisticsMgr_onCalculateEstimatedDuration;

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onLBSelChanged] Fini: [_endpointMarker]: %1"
        , str [_endpointMarker]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;