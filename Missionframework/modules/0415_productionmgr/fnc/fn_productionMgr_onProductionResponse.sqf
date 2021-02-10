#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_onProductionResponse

    File: fn_productionMgr_onProductionResponse.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 21:06:42
    Last Update: 2021-02-09 21:06:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _display
        _args - [_production]

    Returns:
        onProductionResponse finished [BOOL]
*/

params [
    ["_display", displayNull, [displayNull]]
    , ["_args", [], [[]]]
];

_args params [
    ["_production", [], [[]]]
];

private _lnbSectors = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBSECTORS;

_display setVariable ["_production", _production];

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
    _lnbSectors lnbSetValue [[_rowIndex, 0], _markerName];
} forEach _productionView;
