/*
    KPLIB_fnc_production_getNamespaceByMarker

    File: fn_production_getNamespaceByMarker.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 18:53:34
    Last Update: 2021-03-17 07:24:22
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
        {KPLIB_param_production_getNamespace_debug}
    ]
] call KPLIB_fnc_production_debug;

params [
    ["_targetMarker", "", [""]]
];

if (_debug) then {
    [format ["[fn_productionsm_getNamespace] Entering: [_targetMarker]: %1"
        , str [_targetMarker]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _namespaces = [{
    ([_x, [
        ["KPLIB_production_markerName", KPLIB_production_markerNameDefault]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_markerName"
    ];
    _markerName isEqualTo _targetMarker;
}] call KPLIB_fnc_production_getAllNamespaces;

private _namespace = if (count _namespaces isEqualTo 1) then {
    (_namespaces#0);
} else {
    locationNull;
};

if (_debug) then {
    [format ["[fn_productionsm_getNamespace] Fini: [isNull _namespace]: %1"
        , str [isNull _namespace]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_namespace;
