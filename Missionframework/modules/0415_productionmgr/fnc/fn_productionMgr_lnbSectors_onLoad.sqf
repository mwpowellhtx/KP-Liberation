#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbSectors_onLoad

    File: fn_productionMgr_lnbSectors_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-09 21:41:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module sectors list box onLoad event handler.

    Parameter(s):
        _lnbSectors - the list box control [CONTROL]

    Returns:
        Module event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_lnbSectors_onLoad] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_lnbSectors", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _production = _display getVariable ["_production", []];

if (_debug) then {
    [format ["[fn_productionMgr_lnbSectors_onLoad] [count _production]: %1"
        , str [count _production]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

lnbClear _lnbSectors;

// TODO: TBD: which, to some degree, we may half expect events to more or less work themselves out
private _productionView = _production apply {
    private _pos = markerPos (_x#0#0);
    [(_x#0#0), [mapGridPosition _pos, (_x#0#1)]];
};

{
    _x params [
        ["_markerName", "", [""]]
        , ["_view", [], [[]]]
    ];
    private _rowIndex = _lnbSectors lnbAddRow _view;
    _lnbSectors lnbSetData [[_rowIndex, 0], _markerName];
} forEach _productionView;

if (_debug) then {
    [format ["[fn_productionMgr_lnbSectors_onLoad] Finished: [count _productionView]: %1"
        , str [count _productionView]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
