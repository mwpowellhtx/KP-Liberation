#include "script_component.hpp"

private _debug = [
    [
        {MPARAM2(Sector,_getViewData_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_mapVariableName), QMVAR(_overlayMap), [""]]
    , [Q(_viewDataKeys), [], [[]]]
];

if (_debug) then {
    [format ["[fn_hudSector_getViewData] Entering: [count _viewDataKeys]: %1"
        , str [count _viewDataKeys]], "HUD", true] call KPLIB_fnc_common_log;
};

private _overlayMap = uiNamespace getVariable [_mapVariableName, emptyHashMap];

// TODO: TBD: may want to detect whether array, 'RGBA', string, etc...
private _viewData = _viewDataKeys apply {
    private _viewDatum = _overlayMap get _x;
    _viewDatum;
};

if (_debug) then {
    [format ["[fn_hudSector_getViewData] Fini: [count _viewData]: %1"
        , str [count _viewData]], "HUD", true] call KPLIB_fnc_common_log;
};

_viewData;
