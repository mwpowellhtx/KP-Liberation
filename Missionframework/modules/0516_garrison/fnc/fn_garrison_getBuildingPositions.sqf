#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getBuildingPositions

    File: fn_garrison_getBuildingPositions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-04 01:43:59
    Last Update: 2021-06-04 01:44:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the BUILDING POSITIONS useful when deciding where to create
        objects, units, etc.

    Parameter(s):
        _buildings - zero or more OBJECTS [OBJECT|ARRAY, default: []]
        _shuffle - whether to SHUFFLE the result prior to returning [BOOL, default: true]
        _similar - allowing for multiple similar locations to be presented [ARRAY, default: [0, 1]]

    Returns:
        An array of POSITIONS available in all of the BUILDINGS [ARRAY]

    References:
        https://community.bistudio.com/wiki/buildingPos
        https://community.bistudio.com/wiki/BIS_fnc_buildingPositions
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
 */

params [
    [Q(_buildings), [], [[]]]
    , [Q(_shuffle), true, [true]]
    , [Q(_similar), [0, 1], [[]]]
    //              ^^^^^^
];

// Normalizes a SINGLE BUILDING OBJECT or an ARRAY of them
_buildings = flatten [_buildings];

private _allPositions = [];

{
    private _building = _x;
    // TODO: TBD: assuming that this means 'all' positions
    private _positions = [_building] call BIS_fnc_buildingPositions;
    _allPositions append _positions;
} forEach _buildings;

private _positions = +_allPositions;

// Allowing for additional SIMILAR POSITIONS, does not matter what the array was
{ _allPositions append (_positions apply { _x getPos [1, random 360]; }); } forEach _similar;
//                                                                       See above: ^^^^^^^^

// Reducing from any duplicates to DISTINCT POSITIONS
_allPositions = _allPositions arrayIntersect _allPositions;

if (!_shuffle) exitWith {
    _allPositions;
};

_allPositions call BIS_fnc_arrayShuffle;
