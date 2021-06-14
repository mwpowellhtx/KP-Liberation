#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_allowBuildingDestruction

    File: fn_garrison_allowBuildingDestruction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 22:37:28
    Last Update: 2021-06-14 17:11:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether BUILDING DESTRUCTION is allowed.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        Whether BUILDING DESTRUCTION is allowed [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_allowBuildingDestruction_debug)
    || (_sector getVariable [QMVAR(_allowBuildingDestruction_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

private _allowedPrefixes = [
    KPLIB_preset_eden_cityPrefix
    , KPLIB_preset_eden_metropolisPrefix
];

private _markerPrefix = _markerName select [
    0
    , (count _markerName) min (count (_allowedPrefixes#0))
];

_markerPrefix in _allowedPrefixes;
