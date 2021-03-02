/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_getSelectedEndpoint

    File: fn_logisticsMgr_cboEndpoint_getSelectedEndpoint.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 18:50:27
    Last Update: 2021-03-01 18:50:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the ENDPOINT tuple corresponding to the '_cboEndpoint' selection.

    Parameters:
        _cboEndpoint - the logistics ENDPOINT CT_COMBO control [CONTROL, default: controlNull]

    Returns:
        The ENDPOINT tuple corresponding to the '_cboEndpoint' control [ENDPOINT]

    References:
        https://community.bistudio.com/wiki/lbCurSel
        https://community.bistudio.com/wiki/lbData
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_getSelectedEndpoint_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]
];

private _endpoints = uiNamespace getVariable ["KPLIB_logisticsMgr_endpoints", []];

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Entering: [isNull _cboEndpoint, count _endpoints]: %1"
        , str [isNull _cboEndpoint, count _endpoints]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _selectedIndex = lbCurSel _cboEndpoint;

private _defaultEndpoint = [];

if (_selectedIndex < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Combo not selected: [_selectedIndex, count _endpoints]: %1"
            , str [_endpointIndex, count _endpoints]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
    _defaultEndpoint;
};

private _endpointMarker = _cboEndpoint lbData _selectedIndex;

private _alignedToEndpointMarker = {
    private _markerName = (_x#1);
    !(_endpointMarker isEqualTo "")
        && (_markerName isEqualTo _endpointMarker);
};

private _endpointIndex = _endpoints findIf _alignedToEndpointMarker;

if (_endpointIndex < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Endpoint not found: [_endpointMarker, _endpointIndex, count _endpoints]: %1"
            , str [_endpointMarker, _endpointIndex, count _endpoints]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
    _defaultEndpoint;
};

private _retval = _endpoints select _endpointIndex;

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Fini: [_retval]: %1"
        , str [_retval]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_retval;
