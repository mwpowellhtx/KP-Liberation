#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_allowBuildingDestruction

    File: fn_enemy_allowBuildingDestruction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 22:37:28
    Last Update: 2021-05-05 10:46:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether BUILDING DESTRUCTION is allowed.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        Whether BUILDING DESTRUCTION is allowed [BOOL]
 */

private _debug = MPARAM(_allowBuildingDestruction_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [Q(KPLIB_sectors_markerName), ""];

private _allowedPrefixes = [
    KPLIB_preset_eden_cityPrefix
    , KPLIB_preset_eden_metropolisPrefix
];

private _markerPrefix = _markerName select [
    0
    , (count _markerName) min (count (_allowedPrefixes#0))
];

_markerPrefix in _allowedPrefixes;
