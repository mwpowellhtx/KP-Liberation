/*
    KPLIB_fnc_productionMgr_productionElemViews_onTimeRem

    File: fn_productionMgr_productionElemViews_onTimeRem.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 14:52:53
    Last Update: 2021-02-10 14:52:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a view based on the '_productionElem' tuple.

    Parameter(s):
        _this - the production element tuple [ARRAY, default: []]

    Returns:
        The view based on the '_productionElement' tuple.
*/

private _productionElem = _this;

[
    (_productionElem#0#0)
    , (_productionElem#1)
] params [
    "_markerName"
    , "_timer"
];

private _viewData = _timer call KPLIB_fnc_timers_renderTimeRemainingString;

[_viewData, _markerName];
