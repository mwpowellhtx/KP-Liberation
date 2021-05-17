/*
    KPLIB_fnc_init_sortSectors

    File: fn_init_sortSectors.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-02-03 12:33:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Checks all map markers and sort them inside the specific sector arrays.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

private ["_tempMarker"];

{
    private _tempMarker = toArray _x;
    _tempMarker resize 12;

    // Fetch the main mission sectors and spawn points
    switch (toString _tempMarker) do {
        case "KPLIB_eden_a": {
            KPLIB_sectors_airspawn pushBack _x;
        };
        case "KPLIB_eden_b": {
            KPLIB_sectors_military pushBack _x;
        };
        case "KPLIB_eden_c": {
            KPLIB_sectors_city pushBack _x;
        };
        case "KPLIB_eden_f": {
            KPLIB_sectors_factory pushBack _x;
        };
        case "KPLIB_eden_m": {
            KPLIB_sectors_metropolis pushBack _x;
        };
        case "KPLIB_eden_s": {
            KPLIB_sectors_spawn pushBack _x;
        };
        case "KPLIB_eden_t": {
            KPLIB_sectors_tower pushBack _x;
        };
    };
} forEach allMapMarkers;

// TODO: TBD: may consider consolidating 'markers' in terms of the sectors tuple...
{
    (_x#0) setMarkerText (_x#1);
} forEach (KPLIB_sectors_tower apply {
    [_x, format ["%1 - %2", mapGridPosition (markerPos _x), markerText _x]]
});

{KPLIB_sectors_all append _x} forEach [
    KPLIB_sectors_military
    , KPLIB_sectors_city
    , KPLIB_sectors_factory
    , KPLIB_sectors_metropolis
    , KPLIB_sectors_tower
];

// Send filled arrays to clients
{publicVariable _x} forEach [
    "KPLIB_sectors_airspawn"
    , "KPLIB_sectors_spawn"
    , "KPLIB_sectors_military"
    , "KPLIB_sectors_city"
    , "KPLIB_sectors_metropolis"
    , "KPLIB_sectors_factory"
    , "KPLIB_sectors_tower"
    , "KPLIB_sectors_all"
];

true
