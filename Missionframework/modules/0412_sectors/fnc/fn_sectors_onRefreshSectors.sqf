#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onRefreshSectors

    File: fn_sectors_onRefreshSectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 23:40:19
    Last Update: 2021-06-14 16:52:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REFRESH key bits of the CBA SECTOR namespace. The next thing we need to do
        is to determine whether the NEAREST TOWER and MILITARY sectors are aligned
        with this sector SIDE.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]

    References:
        https://en.wikipedia.org/wiki/Maginot_Line
        https://en.wikipedia.org/wiki/Line_in_the_sand
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _sectorPos = position _sector;
private _blufor = _sector getVariable [QMVAR(_blufor), false];

// Which overall sectors are aligned with this one
private _alignedSectors = [[] call MFUNC(_getOpforSectors), MVAR(_blufor)] select _blufor;

private _getSectorDistance = { markerPos _this distance2D _sectorPos; };

private _allNearestSectors = [MVAR(_tower), MVAR(_military)] apply {
    [_x, [], { _x call _getSectorDistance; }] call BIS_fnc_sortBy;
};

// We do not want to filter them out
_allNearestSectors params [
    Q(_allNearestTower)
    , Q(_allNearestMilitary)
];

// Rather set them when they are aligned
_allNearestTower params [
    [Q(_nearestTower), "", [""]]
];

_allNearestMilitary params [
    [Q(_nearestMilitary), "", [""]]
];

// Which will set (or unset) depending on their alignment
{ _sector setVariable _x; } forEach [
    [QMVAR(_nearestTower), if (_nearestTower in _alignedSectors) then { _nearestTower; }]
    , [QMVAR(_nearestMilitary), if (_nearestMilitary in _alignedSectors) then { _nearestMilitary; }]
];

true;
