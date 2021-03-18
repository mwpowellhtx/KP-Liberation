/*
    KPLIB_fnc_production_arrayToNamespace

    File: fn_production_arrayToNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 09:00:35
    Last Update: 2021-02-17 09:00:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Converts the PRODUCTION ARRAY to a corresponding CBA namespace.

    Parameter(s):
        _productionElem - an PRODUCTION element array [ARRAY, default: KPLIB_production_default]

    Returns:
        A newly converted CBA PRODUCTION namespace [NAMESPACE]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createNamespace-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_deleteNamespace-sqf.html
 */

params [
    ["_productionElem", +KPLIB_production_default, [[]]]
];

private _namespace = [] call CBA_fnc_createNamespace;

// Will have already been verified above, so only decon what we must...
_productionElem params [
    ["_ident", [], [[]]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
    , ["_info", [], [[]]]
];

_ident params [
    ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
];

_info params [
    ["_capability", +([] call KPLIB_fnc_production_getDefaultCapability), [[]], 3]
    , ["_storageValue", +KPLIB_resources_storageValueDefault, [[]], 3]
    , ["_queue", [], [[]]]
];

[_namespace, [
    ["KPLIB_production_markerName", _markerName]
    , ["KPLIB_production_baseMarkerText", _baseMarkerText]
    , ["KPLIB_production_timer", _timer]
    , ["KPLIB_production_capability", _capability]
    , ["KPLIB_production_queue", _queue]
    , ["KPLIB_resources_storageValue", _storageValue]
]] call KPLIB_fnc_namespace_setVars;

_namespace;
