/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_getMarkerPos

    File: fn_logisticsMgr_cboEndpoint_getMarkerPos.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-14 23:51:57
    Last Update: 2021-03-14 23:52:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the ENDPOINT or ABANDONED POSITION corresponding to the selected COMBO ENDPOINT MARKER.

    Parameters:
        _epMarker - the selected COMBO ENDPOINT or ABANDONED MARKER [STRING, default: ""]

    Returns:
        The POSITION corresponding to the selected COMBO ENDPOINT MARKER [POSITION]
 */

params [
    ["_epMarker", "", [""]]
];

private _eps = uiNamespace getVariable ["KPLIB_logisticsMgr_endpoints", []];
private _abandonedEps = uiNamespace getVariable ["KPLIB_logisticsMgr_abandonedEps", []];

private _allEps = _eps + _abandonedEps;

private _epIndex = _allEps findIf { ((_x#1) isEqualTo _epMarker); };

if (_epIndex < 0) exitWith {
    // TODO: TBD: do some logging...
    +KPLIB_zeroPos;
};

private _ep = _allEps select _epIndex;

+(_ep#0);
