/*
    KPLIB_fnc_production_namespaceToArray

    File: fn_production_namespaceToArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 09:00:35
    Last Update: 2021-05-25 11:49:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Converts a CBA production '_namespace' to an SQF ARRAY.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        A newly minted SQF ARRAY representation of the CBA production namespace [ARRAY]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

// Respond with empty array when the namespace is unexpected...
if (!([_namespace] call KPLIB_fnc_production_verifyNamespace)) exitWith {
    [];
};

([_namespace, [
    ["KPLIB_production_markerName", ""]
    , ["KPLIB_production_baseMarkerText", ""]
    , ["KPLIB_production_timer", +KPLIB_timers_default]
    , ["KPLIB_production_capability", ([] call KPLIB_fnc_production_getDefaultCapability)]
    , ["KPLIB_production_queue", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_markerName"
    , "_baseMarkerText"
    , "_timer"
    , "_cap"
    , "_queue"
];

// TODO: TBD: the factoring here could perhaps be better...
private _storageContainers = [
    markerPos _markerName
    , KPLIB_param_sectors_capRange
    , KPLIB_resources_factoryStorageClasses
] call KPLIB_fnc_resources_getStorages;

private _storageValue = [
        KPLIB_resources_storageValueDefault
        , (_storageContainers apply { [_x] call KPLIB_fnc_resources_getStorageValue; })
        , {
            params [
                ["_g", KPLIB_resources_storageValueDefault, [[]], 3]
                , ["_y", KPLIB_resources_storageValueDefault, [[]], 3]
            ];
            KPLIB_resources_indexes apply {
                private _resourceIndex = _x;
                (_g select _resourceIndex) + (_y select _resourceIndex);
            };
    }] call KPLIB_fnc_linq_aggregate;

// TODO: TBD: see above note, would want to factor at least through here, and probably extending to the setVariable just below: L57
[_namespace, [
    ["KPLIB_resources_storageValue", _storageValue]
]] call KPLIB_fnc_namespace_setVars;

// Bundle the PRODUCTION tuple and return
private _productionElem = +[
    [_markerName, _baseMarkerText]
    , _timer
    , [_cap, _storageValue, _queue]
];

_productionElem;
