/*
    KPLIB_fnc_logisticsMgr_endpointCtrls_onReload

    File: fn_logisticsMgr_endpointCtrls_onReload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-09 00:43:02
    Last Update: 2021-03-09 00:43:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _endpoint - the ENDPOINT for which to reload the group controls [ARRAY]
        _endpointKey - the ENDPOINT key designating which controls to prefer [STRING, default: "alpha"]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsMgr_endpointCtrls_onReload_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_endpoint", [], [[]]]
    , ["_endpointKey", "alpha", [""]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_endpointCtrls_onReload] Entering: [_endpoint, _endpointKey]"
        , str [_endpoint, _endpointKey]], "POST] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_endpoint params [
    ["_pos", +KPLIB_zeroPOs, [[]], 3]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
    , ["_billValue", +KPLIB_resources_storageValueDefault, [[]], 3]
];

_endpointKey = toUpper _endpointKey;

private _cboEndpointKey = KPLIB_logisticsMgr_cboEndpointHashMap get _endpointKey;

if (_debug) then {
    [format ["[fn_logisticsMgr_endpointCtrls_onReload] Selecting endpoint: [_endpoint, _endpointKey, _cboEndpointKey]"
        , str [_endpoint, _endpointKey, _cboEndpointKey]], "POST] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// (Re-)select the ENDPOINT combobox
[uiNamespace getVariable _cboEndpointKey] call {
    params ["_cboEndpoint"];
    private _cboViewData = [_cboEndpoint] call KPLIB_fnc_logisticsMgr_cboEndpoints_getViewData;
    // Assuming a first UNSELECTED row
    private _markerIndex = _cboViewData findIf { (_x#1) isEqualTo _markerName; };

    if (_debug) then {
        [format ["[fn_logisticsMgr_endpointCtrls_onReload::call] Selecting endpoint: [isNull _cboEndpoint, _endpoint, _endpointKey, _cboEndpointKey, _markerIndex]"
            , str [isNull _cboEndpoint, _endpoint, _endpointKey, _cboEndpointKey, _markerIndex]], "POST] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };

    _cboEndpoint lbSetCurSel _markerIndex;
};

// Then (re-)popupate the ENDPOINT resource editors
private _onReloadResource = {
    params ["_resourceIndex"];
    private _ctrlKey = KPLIB_logisticsMgr_edtEndpointHashMap get [_endpointKey, _resourceIndex];
    private _ctrl = uiNamespace getVariable [_ctrlKey, controlNull];
    private _text = str (_billValue select _resourceIndex);

    if (_debug) then {
        [format ["[fn_logisticsMgr_endpointCtrls_onReload::_onReloadResource] Setting resource: [_endpointKey, _resourceIndex, _ctrlKey, _text]"
            , str [_endpointKey, _resourceIndex, _ctrlKey, _text]], "POST] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };

    _ctrl ctrlSetText _text;
};

{ [_x] call _onReloadResource; } forEach KPLIB_resources_indexes;

if (_debug) then {
    ["[fn_logisticsMgr_endpointCtrls_onReload] Fini", "POST] [LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
