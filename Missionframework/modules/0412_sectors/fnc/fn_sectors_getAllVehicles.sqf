#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getAllVehicles

    File: fn_sectors_getAllVehicles.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 15:43:52
    Last Update: 2021-06-14 16:50:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns an array of all VEHICLES currently considered in the sector. Also sets
        a variable on the namespace itself for the total set of objects. Caller may
        provide an associative array of filter options used to include only certain
        of those objects in the result. The full set of objects is set on the namespace.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _radius - RADIUS about which to consider [SCALAR, default: KPLIB_param_sectors_actRange]
        _options - ASSOCIATIVE ARRAY of OPTIONS used to filter [ARRAY, default: []]
        _varName - a VARIABLE NAME in which to record the result [STRING, default: 'KPLIB_sectors_allVehicles']

    Returns:
        An array of objects aligned to the fitler options [ARRAY]

    References:
        https://community.bistudio.com/wiki/vehicles
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_radius), MPARAM(_actRange), [0]]
    , [Q(_options), [["kinds", MPRESET(_landVehicleKinds)]], [[]]]
    , [Q(_varName), QMVAR(_allVehicles), [""]]
];

private _debug = MPARAM(_getAllVehicles_debug)
    || (_sector getVariable [QMVAR(_getAllVehicles_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_getAllVehicles] Entering: [_markerName, markerText _markerName, _radius, _options]: %1"
        , str [_markerName, markerText _markerName, _radius, _options]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _allVehicles = vehicles;

private _vehicles = [_sector, _radius, _options, _allVehicles, _varName] call MFUNC(_getAllObjects);

if (_debug) then {
    [format ["[fn_sectors_getAllVehicles] Fini: [_varName, count _allVehicles, count _vehicles]: %1"
        , str [_varName, count _allVehicles, count _vehicles]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_vehicles;
