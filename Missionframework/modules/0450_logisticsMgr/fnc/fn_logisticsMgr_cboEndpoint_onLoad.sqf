/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_onLoad

    File: fn_logisticsMgr_cboEndpoint_onLoad.sqf
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
        https://community.bistudio.com/wiki/displayNull
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/keys
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_onLoad_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onLoad] Entering: [isNull _cboEndpoint, isNull _config]: %1"
        , str [isNull _cboEndpoint, isNull _config]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _endpointName = toUpper (getText (_config >> "endpoint"));

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onLoad] Identifying ENDPOINT variable: [_endpointName]: %1"
        , str [_endpointName]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// Sets the appropriate namespace CBO variable depending on ALPHA or BRAVO config...
private _varName = if (!(_endpointName in KPLIB_logisticsMgr_cboEndpointHashMap)) then {""} else {
    (KPLIB_logisticsMgr_cboEndpointHashMap get _endpointName);
};

if (_varName isEqualTo "") exitWith {
    if (_debug) then {
        ["[fn_logisticsMgr_cboEndpoint_onLoad] Unknown endpoint", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
    false;
};

uiNamespace setVariable [_varName, _cboEndpoint];

// TODO: TBD: could probably refactor this whole thing...
private _hasLoadedBothEndpointControls = {
    params [
        ["_keys", [], [[]]]
    ];
    private _variableNames = _keys apply { KPLIB_logisticsMgr_cboEndpointHashMap get _x; };
    private _onGetEndpointCtrl = { uiNamespace getVariable [_x, controlNull]; };
    private _whereNotNull = { !isNull _x; };
    private _ctrls = _variableNames apply _onGetEndpointCtrl select _whereNotNull;
    count _ctrls == 2;
};

// When both ENDPOINT comboboxes have loaded, then request server publication
if ([keys KPLIB_logisticsMgr_cboEndpointHashMap] call _hasLoadedBothEndpointControls) then {
    [KPLIB_logisticsSM_publishEndpoints, [clientOwner]] call CBA_fnc_serverEvent;
};

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onLoad] Fini: [_varName]: %1"
        , str [_varName]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;