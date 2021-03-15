/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_setViewData

    File: fn_logisticsMgr_cboEndpoint_setViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-09 00:43:02
    Last Update: 2021-03-09 00:43:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _ep - the ENDPOINT for which to reload the group controls [ARRAY]
        _epKey - the ENDPOINT key designating which controls to prefer [STRING, default: "alpha"]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_param_logisticsMgr_cboEndpoint_setViewData_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_ep", [], [[]]]
    , ["_epKey", "alpha", [""]]
];

// TODO: TBD: lift the COMBO view dat afrom the control, and compare it against the known data after selectkion...

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_setViewData] Entering: [_ep, _epKey]"
        , str [_ep, _epKey]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_ep params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
    , ["_billValue", +KPLIB_resources_storageValueDefault, [[]], 3]
];

_epKey = toUpper _epKey;

private _cboEndpointKey = KPLIB_logisticsMgr_cboEndpointHashMap get _epKey;

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_setViewData] Selecting endpoint: [_ep, _epKey, _cboEndpointKey]"
        , str [_ep, _epKey, _cboEndpointKey]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _onReselectEndpoint = {
    params ["_cboEndpoint"];
    private _cboViewData = [_cboEndpoint] call KPLIB_fnc_logisticsMgr_cboEndpoints_getViewData;
    // Assuming a first UNSELECTED row
    private _markerIndex = _cboViewData findIf { (_x#1) isEqualTo _markerName; };

    if (_debug) then {
        [format ["[fn_logisticsMgr_cboEndpoint_setViewData::call] Selecting endpoint: [isNull _cboEndpoint, _ep, _epKey, _cboEndpointKey, _markerIndex]: %1"
            , str [isNull _cboEndpoint, _ep, _epKey, _cboEndpointKey, _markerIndex]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };

    _cboEndpoint lbSetCurSel _markerIndex;
};

// (Re-)select the ENDPOINT combobox
[uiNamespace getVariable _cboEndpointKey] call _onReselectEndpoint;

// Then (re-)popupate the ENDPOINT resource editors
private _onReloadResource = {
    params ["_resourceIndex"];
    private _ctrlKey = KPLIB_logisticsMgr_edtEndpointHashMap get [_epKey, _resourceIndex];
    private _ctrl = uiNamespace getVariable [_ctrlKey, controlNull];
    private _text = str (_billValue select _resourceIndex);

    if (_debug) then {
        [format ["[fn_logisticsMgr_cboEndpoint_setViewData::_onReloadResource] Setting resource: [_epKey, _resourceIndex, _ctrlKey, _text]: %1"
            , str [_epKey, _resourceIndex, _ctrlKey, _text]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };

    _ctrl ctrlSetText _text;
};

{ [_x] call _onReloadResource; } forEach KPLIB_resources_indexes;

if (_debug) then {
    ["[fn_logisticsMgr_cboEndpoint_setViewData] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
