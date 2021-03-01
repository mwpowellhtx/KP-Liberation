/*
    KPLIB_fnc_logisticsMgr_btnTransportRequest_onButtonClick

    File: fn_logisticsMgr_btnTransportRequest_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 11:58:41
    Last Update: 2021-03-01 11:58:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Posts a request to the server to request transport action to the currently selected LINES LISTNBOX.

    Parameters:
        _btnTransportRequest - the Request Transport CT_BUTTON [CONTROL, default: controlNull]
        _serverEventName - the server event name being addressed by the requested [STRING, default: KPLIB_logisticsSM_transportRequest_build]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbCurSelRow
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_btnTransportAdd_onButtonClick_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_btnTransportAdd", controlNull, [controlNull]]
    , ["_serverEventName", KPLIB_logisticsSM_transportRequest_build, [""]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_btnTransportRequest_onButtonClick] Entering: [isNull _btnTransportAdd, _serverEventName]: %1"
        , str [isNull _btnTransportAdd, _serverEventName]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _line = uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []];

_line params [
    ["_lineUuid", "", [""]]
];

if (_lineUuid isEqualTo "") exitWith {
    if (_debug) then {
        ["[fn_logisticsMgr_btnTransportRequest_onButtonClick] Line not selected", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
    [localize "STR_KPLIB_LOGISTICS_MSG_TRANSPORT_REQUEST_LINE_NOT_SELECTED"] spawn KPLIB_fnc_notification_hint;
    false;
};

private _fobMarker = [] call KPLIB_fnc_common_getPlayerFob;

if (_debug) then {
    [format ["[fn_logisticsMgr_btnTransportRequest_onButtonClick] Request: [_lineUuid, _fobMarker, _serverEventName]: %1"
        , str [_lineUuid, _fobMarker, _serverEventName]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// The build/recycle request is identical otherwise...
[_serverEventName, [_lineUuid, _fobMarker, clientOwner]] call CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_logisticsMgr_btnTransportRequest_onButtonClick] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
