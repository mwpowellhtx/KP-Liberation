/*
    KPLIB_fnc_productionMgr_getProductionElement

    File: fn_productionMgr_getProductionElement.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 21:27:15
    Last Update: 2021-02-09 21:27:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the production element associated with the currently selected
        marker name, if possible.

    Parameter(s):
        _displayOrCtrl - the display or control corresponding with the event request
            to get the '_productionElem' associated with the current selection
        _markerName - the marker name for which we want production [STRING, default: ""]

    Returns:
        The '_productionElem' tuple associated with the currently selected '_markerName' [ARRAY, default: []]
*/

params [
    "_displayOrCtrl"
    , ["_markerName", "", [""]]
];

private _productionElem = [];

if (isNil "_displayOrCtrl") exitWith {
    _productionElem;
};

// Because we want the display parent from the list box control
_displayOrCtrl = switch (typeName _displayOrCtrl) do {
    case "CONTROL": { findDisplay KPLIB_IDD_PRODUCTIONMGR; };
    case "DISPLAY": { _displayOrCtrl; };
    default: { displayNull; }
};

if (_displayOrCtrl isEqualTo displayNull) exitWith {
    _productionElem;
};

_productionElem = _displayOrCtrl getVariable ["_productionElem", []];

_productionElem;
