/*
    KPLIB_fnc_logisticsMgr_onEndpointsPublished

    File: fn_logisticsMgr_onEndpointsPublished.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 17:24:55
    Last Update: 2021-02-28 17:24:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Client side 'KPLIB_logisticsMgr_onRefreshLogistics' event handler.

    Parameters:
        _endpoints - an array of the logistics ENDPOINT tuples [ARRAY, default: []]
        _abandonedEps - an array of the abandoned ENDPOINT tuples [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsMgr_onEndpointsPublished_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_endpoints", [], [[]]]
    , ["_abandonedEps", [], [[]]]
];

// TODO: TBD: fill in the ABANDONED gap...
if (_debug) then {
    [format ["[fn_logisticsMgr_onEndpointsPublished] Entering: [count _endpoints, count _abandonedEps, _endpoints, _abandonedEps]: %1"
        , str [count _endpoints, count _abandonedEps, _endpoints, _abandonedEps]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// (Re-)set the '_lines' in the 'uiNamespace' and (re-)load the LINES LISTNBOX accordingly...
uiNamespace setVariable ["KPLIB_logisticsMgr_endpoints", _endpoints];
uiNamespace setVariable ["KPLIB_logisticsMgr_abandonedEps", _abandonedEps];

// Dissect the views and present them starting with the logistics lines LISTNBOX control
private _onReloadEndpointCombo = {
    params ["_cboEndpoint"];
    [_cboEndpoint] call KPLIB_fnc_logisticsMgr_cboEndpoint_onReload;
};

private _endpointCtrls = (keys KPLIB_logisticsMgr_cboEndpointHashMap) apply {
    KPLIB_logisticsMgr_cboEndpointHashMap get _x;
} apply {
    uiNamespace getVariable [_x, controlNull];
};

{ [_x] call _onReloadEndpointCombo; } forEach _endpointCtrls;

if (_debug) then {
    ["[fn_logisticsMgr_onEndpointsPublished] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
