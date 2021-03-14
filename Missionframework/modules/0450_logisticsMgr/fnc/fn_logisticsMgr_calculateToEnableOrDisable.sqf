/*
    KPLIB_fnc_logisticsMgr_calculateToEnableOrDisable

    File: fn_logisticsMgr_calculateToEnableOrDisable.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-02 08:47:45
    Last Update: 2021-03-14 18:06:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Calculates the controls that should be enabled or disabled given the current
        LINE status and state of the UI.

    Parameters:
        _line - the logistics LINE tuple [ARRAY, default: []]
        _lines - also the logistics LINES [ARRAY, default: []]

    Returns:
        The set of control IDCs to enable or disable [['_toEnable', '_toDisable']]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_bitflagsCheck
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_calculateToEnableOrDisable_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_line", uiNamespace getVariable ["KPLIB_logisticsMgr_selectedLine", []], [[]]]
    , ["_lines", uiNamespace getVariable ["KPLIB_logisticsMgr_lines", []], [[]]]
];

private _display = uiNamespace getVariable ["KPLIB_logisticsMgr_display", displayNull];

_line params [
    ["_lineUuid", "", [""]]
    , ["_status", KPLIB_logistics_status_na, [0]]
    , ["_timer", [], [[]], 4]
    , ["_endpoints", [], [[]]]
    , ["_convoy", [], [[]]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_calculateToEnableOrDisable] Entering: [_lineUuid, _status, _timer, count _endpoints, count _convoy, count _lines]: %1"
        , str [_lineUuid, _status, _timer, count _endpoints, count _convoy, count _lines]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _toEnable = [];
private _toDisable = [];

private _transportCount = count _convoy;
private _loadedTransportCount = ({ !(_x isEqualTo KPLIB_resources_storageValueDefault); } count _convoy);

// In layout order from top-left to bottom-right...
private _mayRemoveLine = KPLIB_logisticsMgr_ctrls_mayRemoveLine;
private _mayManageConvoyTransports = KPLIB_logisticsMgr_ctrls_mayManageConvoyTransports;
private _mayBuildConvoyTransports = KPLIB_logisticsMgr_ctrls_mayBuildConvoyTransports;
private _mayRecycleConvoyTransports = KPLIB_logisticsMgr_ctrls_mayRecycleConvoyTransports;
private _endpointGrps = KPLIB_logistics_ctrls_endpointGrps;
private _mayConfigureAlpha = KPLIB_logisticsMgr_ctrls_mayConfigureAlpha;
private _mayConfigureBravo = KPLIB_logisticsMgr_ctrls_mayConfigureBravo;
private _mayConfirm = KPLIB_logisticsMgr_ctrls_mayConfirm;
private _mayReroute = KPLIB_logisticsMgr_ctrls_mayReroute;
private _mayAbort = KPLIB_logisticsMgr_ctrls_mayAbort;

if (_debug) then {
    [format ["[fn_logisticsMgr_calculateToEnableOrDisable] Evaluating: [_status, _transportCount, _loadedTransportCount]: %1"
        , str [_status, _transportCount, _loadedTransportCount]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _onShouldEnable = {
    params [
        ["_idcs", [], [[]]]
        , ["_enable", true, [true]]
    ];
    if (_enable) then {
        { _toEnable pushBackUnique _x; } forEach _idcs;
        _toDisable = _toDisable - _idcs;
    } else {
        { _toDisable pushBackUnique _x; } forEach _idcs;
        _toEnable = _toEnable - _idcs;
    };
};

private _areEndpointCurSelEqual = {
    params [
        ["_cboAlpha", controlNull, [controlNull]]
        , ["_cboBravo", controlNull, [controlNull]]
    ];
    private _curSel = [lbCurSel _cboAlpha, lbCurSel _cboBravo];
    (_curSel#0) == (_curSel#1);
};

private _areEndpointsBothSelected = {
    params [
        ["_cboAlpha", controlNull, [controlNull]]
        , ["_cboBravo", controlNull, [controlNull]]
    ];
    private _curSel = [lbCurSel _cboAlpha, lbCurSel _cboBravo];
    ({ _x >= 0; } count _curSel) == 2;
};

private _hasConfiguredBill = {
    params [
        ["_idcs", [], [[]]]
    ];
    private _default = +KPLIB_resources_storageValueDefault;
    private _bill = _idcs apply { parseNumber (ctrlText _x); };
    (count _bill) == (count _default) && !(_bill isEqualTo _default);
};

// For shorthand and consistency throughout
private _areEndpointsUnique = KPLIB_fnc_logistics_areEndpointsUnique;

// Calculate STANDBY or not STANDBY, or not selected, rolls it all up here...
switch (true) do {
    case (_status < KPLIB_logistics_status_standby): {

        [_mayRemoveLine, false] call _onShouldEnable;
        [_mayManageConvoyTransports, false] call _onShouldEnable;
        [_endpointGrps, false] call _onShouldEnable;
        [_mayConfirm, false] call _onShouldEnable;
        [_mayReroute, false] call _onShouldEnable;
        [_mayAbort, false] call _onShouldEnable;
    };
    case (_status > KPLIB_logistics_status_standby): {

        [_mayRemoveLine, false] call _onShouldEnable;

        private _mayBuildTransports = [_status, KPLIB_logistics_status_loadingUnloading] call KPLIB_fnc_logistics_checkStatus;

        private _mayRecycleTransports = switch (true) do {
            case ([_status, KPLIB_logistics_status_loading] call KPLIB_fnc_logistics_checkStatus): {
                // LOADING maintains a "lock" on the next available UNLOADED transport
                (_transportCount > 0) && ((_transportCount - _loadedTransportCount) > 1);
            };
            case ([_status, KPLIB_logistics_status_unloading] call KPLIB_fnc_logistics_checkStatus): {
                // Whereas UNLOADING has already CLEARED all of the unloaded transports
                (_transportCount > 0) && ((_transportCount - _loadedTransportCount) > 0);
            };
            default { false; };
        };

        [_mayBuildConvoyTransports, _mayBuildTransports] call _onShouldEnable;
        // TODO: TBD: loading recycle: maintain N+1 transports, where N are the loaded transports, "lock" on the next one being loaded
        // TODO: TBD: unloading recycling: maintain N transports, all unloaded transports are clear to recycle
        [_mayRecycleConvoyTransports, _mayRecycleTransports] call _onShouldEnable;

        // Yes, we enable the endpoints controls, but we disable the groups...
        [_mayConfigureAlpha, true] call _onShouldEnable;
        [_mayConfigureBravo, true] call _onShouldEnable;
        [_endpointGrps, false] call _onShouldEnable;

        [_mayConfirm, false] call _onShouldEnable;

        // Only REROUTE running lines when 1+ ENDPOINTS determined to have been ABANDONED
        [
            _mayReroute
            , [_status, KPLIB_logistics_status_abandonedAmbushed] call KPLIB_fnc_logistics_checkStatus
        ] call _onShouldEnable;

        // May always ABORT running lines as long as neither ABORTING nor AMBUSHED...
        [
            _mayAbort
            , !([_status, KPLIB_logistics_status_abortingAmbushed] call KPLIB_fnc_logistics_checkStatus)
        ] call _onShouldEnable;
    };
    default {

        [_mayRemoveLine, _transportCount == 0] call _onShouldEnable;
        [_mayBuildConvoyTransports] call _onShouldEnable;
        [_mayRecycleConvoyTransports, _transportCount > 0] call _onShouldEnable;

        private _endpointCtrls = ["KPLIB_logisticsMgr_cboAlpha", "KPLIB_logisticsMgr_cboBravo"] apply {
            uiNamespace getVariable [_x, controlNull];
        };

        private _endpoint = _endpointCtrls apply {
            [_x] call KPLIB_fnc_logisticsMgr_cboEndpoint_getSelectedEndpoint;
        };

        private _endpointsAreBothSelected = _endpointCtrls call _areEndpointsBothSelected;
        private _endpointsAreEqual = _endpointCtrls call _areEndpointCurSelEqual;
        private _endpointsAreUnique = [_endpoint, _lines] call _areEndpointsUnique;
        private _endpointsAreInConflict = _endpointsAreEqual || !_endpointsAreUnique;
        private _endpointCtrlCurSels = _endpointCtrls apply { (lbCurSel _x); };

        if (_debug) then {
            [format ["[fn_logisticsMgr_calculateToEnableOrDisable] Evaluating: [_status, _endpointsAreBothSelected, _endpointsAreEqual, _endpointsAreUnique, _endpointsAreInConflict, _endpointCtrlCurSels]: %1"
                , str [_status, _endpointsAreBothSelected, _endpointsAreEqual, _endpointsAreUnique, _endpointsAreInConflict, _endpointCtrlCurSels]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
        };

        [_endpointGrps] call _onShouldEnable;

        [_mayConfigureAlpha, (_endpointCtrlCurSels#0) >= 0] call _onShouldEnable;
        [_mayConfigureBravo, (_endpointCtrlCurSels#1) >= 0] call _onShouldEnable;

        private _configuredCount = { [_x] call _hasConfiguredBill; } count [_mayConfigureAlpha, _mayConfigureBravo];

        // In order to confirm, must have transports, both selected, not in conflict, and at least one configured bill...
        [_mayConfirm, (_transportCount > 0) && _endpointsAreBothSelected && !_endpointsAreInConflict && _configuredCount > 0] call _onShouldEnable;
        [_mayReroute, false] call _onShouldEnable;
        [_mayAbort, false] call _onShouldEnable;
    };
};

if (_debug) then {
    [format ["[fn_logisticsMgr_calculateToEnableOrDisable] Fini: [_toEnable, _toDisable]: %1"
        , str [_toEnable, _toDisable]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// Calculations finished, fini with the recommendations
[_toEnable, _toDisable];
