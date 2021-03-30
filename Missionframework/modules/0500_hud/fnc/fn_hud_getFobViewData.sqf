#include "script_component.hpp"

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
