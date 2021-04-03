#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_getViewData

    File: fn_hudSector_getViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Lifts the view data from the overlap hashmap corresponding to the keys.

    Parameters:
        _mapVariableName - the OVERLAY HASHMAP variable name [STRING, default: QMVAR(_overlayMap)]
        _viewDataKeys - the view data keys which values are being lifted from the OVERLAP HASHMAP
            [ARRAY, default: []]

    Returns:
        The view data [ARRAY]
 */

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
