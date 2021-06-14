#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getAllObjects

    File: fn_sectors_getAllObjects.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 17:39:39
    Last Update: 2021-06-14 16:49:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns an array of all OBJECTS currently considered in the sector. Also sets
        a variable on the namespace itself for the total set of objects. Caller may
        provide an associative array of filter options used to include only certain
        of those objects in the result. The full set of objects is set on the namespace.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _radius - RADIUS about which to consider [SCALAR, default: KPLIB_param_sectors_actRange]
        _options - ASSOCIATIVE ARRAY of OPTIONS used to filter [ARRAY, default: []]
        _source - SOURCE ARRAY of the objects being considered [ARRAY, default: allUnits + allDeadMen]
        _varName - an optional VARIABLE NAME in which to record the result [STRING, default: '']

    Returns:
        An array of objects aligned to the fitler options [ARRAY]

    References:
        https://community.bistudio.com/wiki/allUnits
        https://community.bistudio.com/wiki/allDeadMen
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_radius), MPARAM(_actRange), [0]]
    , [Q(_options), [], [[]]]
    , [Q(_source), [], [[]]]
    , [Q(_varName), "", [""]]
];

private _debug = MPARAM(_getAllObjects_debug)
    || (_sector getVariable [QMVAR(_getAllObjects_debug), false])
    ;

private _sectorPos = position _sector;
private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_getAllObjects] Entering: [_markerName, markerText _markerName, _radius, _options]: %1"
        , str [_markerName, markerText _markerName, _radius, _options]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// This could be a 'filters' option, but this is just as simple
private _objects = _source select { _sectorPos distance _x <= _radius; };

if (_varName != "") then {
    _sector setVariable [_varName, _objects];
};

private _objects = _objects select { [_x, _options] call KPLIB_fnc_common_filterObject; };

if (_debug) then {
    [format ["[fn_sectors_getAllObjects] Fini: [_varName, count _source, count _objects]: %1"
        , str [_varName, count _source, count _objects]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_objects;
