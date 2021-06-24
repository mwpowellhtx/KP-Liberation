#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorTearDown

    File: fn_garrison_onSectorTearDown.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 00:44:25
    Last Update: 2021-06-24 12:47:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Tears down the UNITS+ASSETS+RESOURCES which were allocated to the SECTOR.
        Leaves any that are still ALIVE and 'KPLIB_captured' alone, but deletes
        the rest.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorTearDown_debug)
    || (_sector getVariable [QMVAR(_onSectorTearDown_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _blufor = _sector getVariable [Q(KPLIB_sectors_blufor), false];

if (_debug) then {
    [format ["[fn_garrison_onSectorTearDown] Entering: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "GARRISON"] call KPLIB_fnc_common_log;
};

private _garrisonMap = _sector getVariable [QMVAR(_garrisonMap), createHashMap];

[
    _garrisonMap getOrDefault [QMVAR(_units), []]
    , _garrisonMap getOrDefault [QMVAR(_assets), []]
    , _garrisonMap getOrDefault [QMVAR(_resources), []]
] params [
    Q(_units)
    , Q(_assets)
    , Q(_resources)
];

// TODO: TBD: there could probably be a separate dead object GC service...
private _whereShouldTearDown = {
    !(
        alive _this
            && (_this getVariable [Q(KPLIB_captured), false])
    );
};

// TODO: TBD: debatable whether we include RESOURCES in this mix...
// TODO: TBD: more than likely, similar to 'intel' we should leave resources alone
private _unitsToTearDown = _units select { _x call _whereShouldTearDown; };
private _assetsToTearDown = _assets select { _x call _whereShouldTearDown; };
private _resourcesToTearDown = _resources;

{ _garrisonMap set _x; } forEach [
    [QMVAR(_units), _units - _unitsToTearDown]
    , [QMVAR(_assets), _units - _assetsToTearDown]
    , [QMVAR(_resources), []]
];

// GC all units and resources alike
{ deleteVehicle _x; } forEach _unitsToTearDown;
{ deleteVehicle _x; } forEach _resourcesToTearDown;

// GC crew of uncaptured vehicles, regardless whether each crew was captured
{
    private _vehicle = _x;
    private _crew = crew _x select { !isPlayer _x; };
    { _vehicle deleteVehicleCrew _x; } forEach _crew;
    deleteVehicle _vehicle;
} forEach _assetsToTearDown;

if (_debug) then {
    ["[fn_garrison_onSectorTearDown] Fini", "GARRISON"] call KPLIB_fnc_common_log;
};

true;
