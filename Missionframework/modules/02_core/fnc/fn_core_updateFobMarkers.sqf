/*
    KPLIB_fnc_core_updateFobMarkers

    File: fn_core_updateFobMarkers.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell
    Created: 2018-05-13
    Last Update: 2021-01-26 17:48:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Updates the _markerText [_i = 4] of the FOB tuples

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

{
    // Updates the _markerText for the FOB tuple
    _x select 3 set [1, format [
        "FOB %1"
        , [_forEachIndex] call KPLIB_fnc_common_indexToMilitaryAlpha
    ]];

    (_x select 3) params ["_markerName", "_markerText"];

    _markerName setMarkerText _markerText;

} forEach KPLIB_sectors_fobs;

true
