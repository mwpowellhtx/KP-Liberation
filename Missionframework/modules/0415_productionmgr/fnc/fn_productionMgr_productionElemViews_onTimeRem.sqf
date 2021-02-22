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

private _debug = [
    [
        "KPLIB_param_productionMgr_timer_debug"
    ]
] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_productionElemViews_onTimeRem] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_ident", [], [[]], 2]
    , ["_timer", [], [[]], 4]
];

_ident params [
    ["_markerName", "", [""]]
];

private _viewData = _timer call KPLIB_fnc_timers_renderTimeRemainingString;

if (_debug) then {
    [format ["[fn_productionMgr_productionElemViews_onTimeRem] Fini: [_viewData, _markerName]: %1"
        , str [_viewData, _markerName]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

[_viewData, _markerName];
