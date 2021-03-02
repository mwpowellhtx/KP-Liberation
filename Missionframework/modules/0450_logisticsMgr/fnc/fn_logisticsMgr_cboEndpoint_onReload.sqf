/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_onReload

    File: fn_logisticsMgr_cboEndpoint_onReload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 19:53:08
    Last Update: 2021-03-01 19:53:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the ENDPOINT tuple corresponding to the '_cboEndpoint' selection.

    Parameters:
        _cboEndpoint - the logistics ENDPOINT CT_COMBO control [CONTROL, default: controlNull]

    Returns:
        The ENDPOINT tuple corresponding to the '_cboEndpoint' control [ENDPOINT]

    References:
        https://community.bistudio.com/wiki/lbAdd
        https://community.bistudio.com/wiki/lnbSetData
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_onReload_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]
];

private _endpoints = uiNamespace getVariable ["KPLIB_logisticsMgr_endpoints", []];

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onReload] Entering: [isNull _cboEndpoint, count _endpoints]: %1"
        , str [isNull _cboEndpoint, count _endpoints]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

if (isNull _cboEndpoint) exitWith {
    false;
};

lnbClear _cboEndpoint;

private _onAddEndpoint = {
    _x params [
        ["_pos", +KPLIB_zeroPos, [[]], 3]
        , ["_markerName", "", [""]]
        , ["_baseMarkerText", "", [""]]
    ];
    private _text = format ["%1 - %2", mapGridPosition _pos, _baseMarkerText];
    private _rowIndex = _cboEndpoint lbAdd _text;
    _cboEndpoint lbSetData [_rowIndex, _markerName];
    true;
};

private _added = _endpoints select _onAddEndpoint;
private _retval = (count _added) == (count _endpoints);

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onReload] Fini: [_retval, count _added, count _endpoints]: %1"
        , str [_retval, count _added, count _endpoints]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_retval;
