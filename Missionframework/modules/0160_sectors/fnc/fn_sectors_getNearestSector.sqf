#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getNearestSector

    File: fn_sectors_getNearestSector.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 20:20:03
    Last Update: 2021-04-15 16:24:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Gets the NEAREST SECTOR aligned to the same SIDE.

    Parameter(s):
        _markerName - the MARKER NAME under consideration [STRING, default: ""]
        _candidateMarkers - the CANDIDATE sector MARKERS under consideration [ARRAY, default: []]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

params [
    [Q(_markerName), "", [""]]
    , [Q(_candidateMarkers), MVAR(_all), [[]]]
];

[
    markerPos _markerName
    , _candidateMarkers - [_markerName]
] params [
    Q(_markerPos)
    , Q(_selectedMarkers)
];

private _sortedMarkers = [_selectedMarkers, [], { (markerPos _x) distance2D _markerPos; }] call BIS_fnc_sortBy;

_sortedMarkers params [
    [Q(_nearestMarker), "", [""]]
];

_nearestMarker;
