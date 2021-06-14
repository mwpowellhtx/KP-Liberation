#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onTearDownObjects

    File: fn_sectors_onTearDownObjects.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 22:53:12
    Last Update: 2021-06-14 16:52:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        TEAR DOWN the OBJECTS, 'units', 'assets', or 'resources', garrisoned for
        the SECTOR, if any.

    Parameter(s):
        _sector - a CBA SECTOR namespace being torn down [LOCATION, default: locationNull]
        _suffix - 

    Returns:
        The event handler has finished [BOOL]
 */

// TODO: TBD: refactor as a proper PRESETS...
private _tearDownSuffixes = ["_units", "_assets", "_resources"];

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_suffix), _suffix select 2, [""]]
];

private _debug = MPARAM(_tearDownObjects_debug)
    || (_sector getVariable [QMVAR(_tearDownObjects_debug), false])
    ;

if (_debug) then {
    [format ["[fn_sectors_onTearDownObjects] Entering: [_markerName, markerText _markerName, _suffix]: %1"
        , str [_markerName, markerText _markerName, _suffix]], "SECTORS"] call KPLIB_fnc_common_log;
};

if (_tearDownSuffixes findIf { _x == _suffix; } < 0) exitWith {
    false;
};

private _varName = format ["KPLIB_sectors%1", _suffix];
private _objects = _sector getVariable [_varName, []];

if (_debug) then {
    [format ["[fn_sectors_onTearDownObjects] Objects: [_varName, count _objects]: %1"
        , str [_varName, count _objects]], "SECTORS"] call KPLIB_fnc_common_log;
};

// TODO: TBD: for now assuming 'all' OBJECTS are 'captured'...
// TODO: TBD: will need to revisit with the OBJECTS actions, 'capturing' them...
private _whereNotCaptured = { !(_this getVariable [Q(KPLIB_captured), true]); };
//                                                                    ^^^^

private _objectsToDelete = _objects select { _x call _whereNotCaptured; };

if (_debug) then {
    [format ["[fn_sectors_onTearDownObjects] Deleting: [count _objectsToDelete]: %1"
        , str [count _objectsToDelete]], "SECTORS"] call KPLIB_fnc_common_log;
};

{ deleteVehicle _x; } forEach _objectsToDelete;

_sector setVariable [_varName, nil];

if (_debug) then {
    ["[fn_sectors_onTearDownObjects] Fini", "SECTORS"] call KPLIB_fnc_common_log;
};

true;
