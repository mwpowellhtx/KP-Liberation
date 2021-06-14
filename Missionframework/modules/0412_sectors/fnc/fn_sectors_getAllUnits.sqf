#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getAllUnits

    File: fn_sectors_getAllUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 17:45:13
    Last Update: 2021-06-14 16:49:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns an array of all UNITS currently considered in the sector. Also sets
        a variable on the namespace itself for the total set of objects. Caller may
        provide an associative array of filter options used to include only certain
        of those objects in the result. The full set of objects is set on the namespace.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _radius - RADIUS about which to consider [SCALAR, default: KPLIB_param_sectors_actRange]
        _options - ASSOCIATIVE ARRAY of OPTIONS used to filter [ARRAY, default: []]
        _varName - a VARIABLE NAME in which to record the result [STRING, default: 'KPLIB_sectors_allUnits']

    Returns:
        An array of objects aligned to the fitler options [ARRAY]

    References:
        https://community.bistudio.com/wiki/vehicles
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_radius), MPARAM(_actRange), [0]]
    , [Q(_options), [], [[]]]
    , [Q(_varName), QMVAR(_allUnits), [""]]
];

private _debug = MPARAM(_getAllUnits_debug)
    || (_sector getVariable [QMVAR(_getAllUnits_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_getAllUnits] Entering: [_markerName, markerText _markerName, _options, _radius]: %1"
        , str [_markerName, markerText _markerName, _options, _radius]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: allDeadMen includes spawn system units? may not want that one after all...
private _allUnits = allUnits; // + allDeadMen;

private _units = [_sector, _radius, _options, _allUnits, _varName] call MFUNC(_getAllObjects);

if (_debug) then {
    [format ["[fn_sectors_getAllUnits] Fini: [count _allUnits, count _units]: %1"
        , str [count _allUnits, count _units]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_units;
