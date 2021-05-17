/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_getSelectedEndpoint

    File: fn_logisticsMgr_cboEndpoint_getSelectedEndpoint.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 18:50:27
    Last Update: 2021-03-15 01:15:31
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

private _eps = uiNamespace getVariable ["KPLIB_logisticsMgr_endpoints", []];
private _abandonedEps = uiNamespace getVariable ["KPLIB_logisticsMgr_abanonedEps", []];

private _allEps = _eps + _abandonedEps;

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Entering: [isNull _cboEndpoint, count _eps, count _abandonedEps]: %1"
        , str [isNull _cboEndpoint, count _eps, count _abandonedEps]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _curSel = lbCurSel _cboEndpoint;

private _defaultEp = [];

if (_curSel < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Combo not selected: [_selectedIndex, count _eps, count _abandonedEps]: %1"
            , str [_epIndex, count _eps, count _abandonedEps]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
    _defaultEp;
};

private _curSelMarker = _cboEndpoint lbData _curSel;

private _whereAlignedToEpMarker = {
    private _epMarker = (_x#1);
    !(_curSelMarker isEqualTo "")
        && (_epMarker isEqualTo _curSelMarker);
};

private _epIndex = _allEps findIf _whereAlignedToEpMarker;

if (_epIndex < 0) exitWith {
    if (_debug) then {
        [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Endpoint not found: [_curSelMarker, _epIndex, count _eps, count _abandonedEps]: %1"
            , str [_curSelMarker, _epIndex, count _eps, count _abandonedEps]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
    };
    _defaultEp;
};

private _retval = _allEps select _epIndex;

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_getSelectedEndpoint] Fini: [_retval]: %1"
        , str [_retval]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_retval;
