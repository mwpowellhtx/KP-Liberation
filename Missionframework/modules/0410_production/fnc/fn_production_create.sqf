/*
    KPLIB_fnc_production_create

    File: fn_production_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 17:29:44
    Last Update: 2021-02-17 11:10:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a newly created CBA production namespace given at least a '_markerName'
        production tuple shape. May simply be the '_markerName' or the complete '_production'
        tuple shape.

    Parameter(s):
        _markerName - the marker name of the discovered 'KPLIB_sectors_factory' site [STRING, default: ""]

    Returns:
        A newly minted CBA production namespace corresponding to the '_markerName' input.
        When invalid returns a default empty namespace.
*/

params [
    ["_markerName", "", [""]]
];

if (!(_markerName call KPLIB_fnc_production_markerExists)) exitWith {
    [] call CBA_fnc_createNamespace;
};

private _namespace = [] call KPLIB_fnc_production_arrayToNamespace;

/* We shall defer the discovery of the _markerText until after reconciling
 * saved data with the current 'KPLIB_sectors_factory' discovery. */

// Personlize the namespace given the marker name and corresponding text
_namespace setVariable ["_markerName", _markerName];
_namespace setVariable ["_baseMarkerText", (markerText _markerName)];

// We do need to initialize capability given a default, random starting capability
_namespace setVariable ["_capability", ([] call KPLIB_fnc_production_getDefaultCapability)];

_namespace;
