#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onCatalogRoads

    File: fn_sectors_onCatalogRoads.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-01 17:00:39
    Last Update: 2021-06-14 17:13:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to the 'KPLIB_sectors_activating' server side CBA event. Catalogs
        the roads in the sector for purposes of supporting GARRISON, as well as
        potentially evaluating CIVILIAN REPUTATION scoring following sector resolution.

    Parameters:
        _sector - the CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/getRoadInfo#Syntax
        https://community.bistudio.com/wiki/nearestTerrainObjects#Syntax
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onCatalogRoads_debug)
    || (_sector getVariable [QMVAR(_onCatalogRoads_debug), false])
    ;

private _sectorPos = position _sector;
private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_onCatalogRoads] Entering: [_markerName, markerText _markerName, %1]: %2"
        , QMPRESET(_roadTypes)
        , str [_markerName, markerText _markerName, MPRESET(_roadTypes)]
        ], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Should work just fine with a LOCATION provided we have aligned its POSITION with the map
private _roadsToCatalog = nearestTerrainObjects [_sectorPos, MPRESET(_roadTypes), KPLIB_param_sectors_capRange];

_sector setVariable [QMVAR(_roads), _roadsToCatalog call BIS_fnc_arrayShuffle];

if (_debug) then {
    [format ["[fn_sectors_onCatalogRoads] Fini: [count _roadsToCatalog]: %1"
        , str [count _roadsToCatalog]], "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
