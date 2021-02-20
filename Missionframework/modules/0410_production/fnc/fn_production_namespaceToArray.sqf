/*
    KPLIB_fnc_production_namespaceToArray

    File: fn_production_namespaceToArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 09:00:35
    Last Update: 2021-02-19 16:44:05
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
if (!(_namespace call KPLIB_fnc_production_verifyNamespace)) exitWith {
    [];
};

private _ident = [
    _namespace getVariable ["_markerName", ""]
    , _namespace getVariable ["_baseMarkerText", ""]
];

private _timer = _namespace getVariable ["_timer", KPLIB_timers_default];

private _info = [
    _namespace getVariable ["_capability", ([] call KPLIB_fnc_production_getDefaultCapability)]
    , _namespace getVariable ["KPLIB_resources_storageValue", (KPLIB_resources_indexes apply {0})]
    , _namespace getVariable ["_queue", []]
];

private _productionElem = +[
    _ident
    , _timer
    , _info
];

_productionElem;
