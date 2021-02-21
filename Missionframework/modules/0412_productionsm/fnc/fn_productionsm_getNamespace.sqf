/*
    KPLIB_fnc_productionsm_getNamespace

    File: fn_productionsm_getNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 18:53:34
    Last Update: 2021-02-19 18:53:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the CBA production '_namespace' corresponding with the '_targetMarker'.

    Parameter(s):
        _targetMarker - the target factory sector, i.e. '_markerName', affected by the request [STRING, default: ""]

    Returns:
        The CBA production '_namespace' corresponding with the '_targetMarker' [LOCATION, default: locationNull]
 */

private _debug = [
    [
        "KPLIB_param_productionsm_calculators_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_targetMarker", "", [""]]
];

if (_debug) then {
    [format ["[fn_productionsm_getNamespace] Entering: [_targetMarker]: %1"
        , str [_targetMarker]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: should be its own function...
private _namespaces = KPLIB_production_namespaces select {
    // We trap "cap exists" use cases later on, actually...
    private _markerName = _x getVariable ["_markerName", KPLIB_production_markerNameDefault];
    _markerName isEqualTo _targetMarker;
};

private _namespace = if (count _namespaces isEqualTo 1) then {
    (_namespaces#0);
} else {
    locationNull;
};

if (_debug) then {
    [format ["[fn_productionsm_getNamespace] Finished: [isNull _namespace]: %1"
        , str [isNull _namespace]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_namespace;
