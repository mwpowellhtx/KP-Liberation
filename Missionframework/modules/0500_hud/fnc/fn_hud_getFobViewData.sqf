#include "script_component.hpp"
/*
    KPLIB_fnc_hud_getFobViewData

    File: fn_hud_getFobViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The view data corresponding to the OVERLAY HASHMAP variable name
        and lifted values associated with the view data keys.

    Parameters:
        _mapVariableName - variable name of a HASHMAP in the name space
            [STRING, default: QMVAR(_overlayMap)]
        _viewDataKeys - the view data keys
            [ARRAY, default: KPLIB_hudDispatchSM_lnbFob_viewDataKeys]

    Returns:
        The values in the map associated with the keys [ARRAY]
 */

private _debug = [
    [
        {MPARAM(_getFobViewData_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_mapVariableName), QMVAR(_overlayMap), [""]]
    , [Q(_viewDataKeys), KPLIB_hudDispatchSM_lnbFob_viewDataKeys, [[]]]
];

if (_debug) then {
    ["[fn_hud_getFobViewData] Entering", "HUD", true] call KPLIB_fnc_common_log;
};

private _overlayMap = uiNamespace getVariable [_mapVariableName, emptyHashMap];

// TODO: TBD: may further transform the expected results with a custom ONAPPLY callback...
// TODO: TBD: i.e. which shape would potentially be very different extending from FOB HUD to SECTOR HUD...
// Lift the VIEW DATA from the current OVERLAY MAP
private _viewData = _viewDataKeys apply {
    // Key:         ^^^^^^^^^^^^^
    private _values = _x apply { _overlayMap get _x; };
    _values params [
        [Q(_report), "", [""]]
        , [Q(_imagePath), "", [""]]
        , [Q(_color), [], [[]]]
    ];
    private _retval = [_report, _imagePath];
    // Result shape may or may not have color
    if (count _color == 4) then { _retval pushBack _color; };
    _retval;
};

if (_debug) then {
    ["[fn_hud_getFobViewData] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

_viewData;
