/*
    KPLIB_fnc_productionMgr_getSelectedMarkerName

    File: fn_productionMgr_getSelectedMarkerName.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 21:27:15
    Last Update: 2021-02-09 21:27:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the currently selected production manager marker name, if possible.

    Parameter(s):
        _displayOrCtrl - the display or control used to diagnose the currently selected marker

    Returns:
        The currently selected marker name, if possible [STRING, default: ""]
*/

params [
    "_displayOrCtrl"
];

private _markerName = "";

if (isNil "_displayOrCtrl") then {
    _displayOrCtrl = findDisplay KPLIB_IDD_PRODUCTIONMGR;
    if (_display isEqualTo displayNull) exitWith {
        _markerName;
    };
};

_displayOrCtrl = switch (typeName _displayOrCtrl) do {
    case "DISPLAY": { _displayOrCtrl displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBSECTORS; };
    case "CONTROL": { _displayOrCtrl; };
    default { controlNull; };
};

if (_displayOrCtrl isEqualTo controlNull) exitWith {
    _markerName;
};

private _i = lnbCurSelRow _ctrl;

if (_i < 0) exitWith {
    _markerName;
};

_markerName = _ctrl lnbData [_i, 0];

_markerName;
