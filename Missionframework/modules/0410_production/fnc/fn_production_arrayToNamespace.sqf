/*
    KPLIB_fnc_production_arrayToNamespace

    File: fn_production_arrayToNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 09:00:35
    Last Update: 2021-02-17 09:00:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Converts the SQF ARRAY to a corresponding CBA namespace.

    Parameter(s):
        _this - an SQF production array [ARRAY]

    Returns:
        A newly converted CBA production namespace [NAMESPACE]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createNamespace-sqf.html
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_deleteNamespace-sqf.html
 */

// TODO: TBD: because of snafus in the transition period, was: []
private _production = _this;

private _namespace = [] call CBA_fnc_createNamespace;

//// TODO: TBD: ideally I think we should be able to verify, but let's not for the time being...
// if (_production call KPLIB_fnc_production_verifyArray) exitWith {
//     _namespace;
// };

// Will have already been verified above, so only decon what we must...
_production params [
    ["_ident", [], [[]], 2]
    , ["_timer", KPLIB_timers_default, [[]], 4]
    , ["_info", [], [[]], 3]
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

_namespace setVariable ["_markerName", _markerName];
_namespace setVariable ["_baseMarkerText", _baseMarkerText];

_namespace setVariable ["_timer", (+_timer)];

_namespace setVariable ["_capability", (+_capability)];
_namespace setVariable ["_queue", (+_queue)];

// 'KPLIB_resources_storageValue' in keeping with recent resources improvements
_namespace setVariable ["KPLIB_resources_storageValue", (+_storageValue)];

_namespace;
