#include "defines.hpp"
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

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    "_displayOrCtrl"
    , ["_markerName", "", [""]]
];

if (_debug) then {
    [format ["[fn_productionMgr_getProductionElement] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

private _default = +KPLIB_productionMgr_productionElem_default;

if (isNil "_displayOrCtrl") exitWith {

    if (_debug) then {
        [format ["[fn_productionMgr_getProductionElement] Finished: [_markerName, isNil 'displayOrCtrl']: %1"
            , str [_markerName, isNil "_displayOrCtrl"]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };

    _default;
};

// Because we want the display parent from the list box control
_displayOrCtrl = switch (typeName _displayOrCtrl) do {
    case "CONTROL": { findDisplay KPLIB_IDD_PRODUCTIONMGR; };
    case "DISPLAY": { _displayOrCtrl; };
    default { displayNull; };
};

if (_displayOrCtrl isEqualTo displayNull) exitWith {

    if (_debug) then {
        [format ["[fn_productionMgr_getProductionElement] Finished: [_markerName, _displayOrCtrl isEqualTo displayNull]: %1"
            , str [_markerName, _displayOrCtrl isEqualTo displayNull]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };

    _default;
};

private _productionState = _displayOrCtrl getVariable ["_productionState", []];

private _selected = _productionState select { (_x#0#0) isEqualTo _markerName; };

if (_selected isEqualTo []) exitWith {

    if (_debug) then {
        [format ["[fn_productionMgr_getProductionElement] Finished: [_markerName, _default, count _productionState]: %1"
            , str [_markerName, _default, count _productionState]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };

    _default;
};

private _productionElem = (_selected#0);

if (_debug) then {
    [format ["[fn_productionMgr_getProductionElement] Finished: [_markerName, _productionElem]: %1"
        , str [_markerName, _productionElem]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

_productionElem;
