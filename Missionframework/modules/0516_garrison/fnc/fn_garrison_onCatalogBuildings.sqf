#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onCatalogBuildings

    File: fn_garrison_onCatalogBuildings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-01 17:00:39
    Last Update: 2021-06-14 17:13:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to the 'KPLIB_sectors_activating' server side CBA event. Catalogs
        the buildings in the sector for purposes of supporting GARRISON, as well as
        potentially evaluating CIVILIAN REPUTATION scoring following sector resolution.

    Parameters:
        _sector - the CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/damage
        https://community.bistudio.com/wiki/nearestObjects
        https://community.bistudio.com/wiki/BIS_fnc_buildingPositions
        https://community.bistudio.com/wiki/buildingPos
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onCatalogBuildings_debug)
    || (_sector getVariable [QMVAR(_onCatalogBuildings_debug), false])
    ;

private _sectorPos = position _sector;
private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    [format ["[fn_garrison_onCatalogBuildings] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _buildings = nearestObjects [_sectorPos, [Q(Building)], KPLIB_param_sectors_capRange];

private _damageThreshold = PCT(MPARAM(_buildingDamageThreshold));

// This is a much clearer definition as to which buildings count for destruction
private _buildingsToCatalog = _buildings select {
    damage _x <= _damageThreshold
        && ([_x] call BIS_fnc_buildingPositions) isNotEqualTo [];
};

// Ensures that BUILDINGS are always SHUFFLED when they are discovered
_sector setVariable [QMVAR(_buildings), _buildingsToCatalog call BIS_fnc_arrayShuffle];

if (_debug) then {
    [format ["[fn_garrison_onCatalogBuildings] Fini: [count _buildingsToCatalog]: %1"
        , str [count _buildingsToCatalog]], "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
