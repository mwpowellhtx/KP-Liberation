/*
    KPLIB_fnc_respawn_getRespawns

    File: fn_respawn_getRespawns.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-12
    Last Update: 2021-01-27 14:04:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns an array of currenty available spawn points.

    Parameters:
        NONE

    Returns:
        Array of spawn point tuples [ARRAY]
            - spawn point tuple shape: [_fullName, _target]
*/

private _spawns = KPLIB_sectors_edens apply {
    [(_x#1), (_x#4)] params ["_markerText", "_pos"];
    [
        format ["%1 - %2", mapGridPosition _pos, _markerText]
        , _pos
    ];
};

_spawns append (KPLIB_sectors_fobs apply {
    // TODO: TBD: see: i.e. [_forEachIndex] call KPLIB_fnc_common_indexToMilitaryAlpha
    // Assumes that the FOB markers have already been refreshed; see docs for the tuple specs.
    [(_x#1), (_x#4)] params ["_markerText", "_pos"];
    [
        format ["%1 - %2", mapGridPosition _pos, _markerText]
        , _pos
    ];
});

// Add mobile respawns to the spawn list if parameter is not disabled
if (KPLIB_param_mobileRespawn) then {

    _spawns append (([] call KPLIB_fnc_core_getMobSpawns) apply {
        [
            // Get the display name from the vehicle configs and append.
            getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName")
            , getPos _x
        ] params [
            "_displayName"
            , "_pos"
        ];

        [
            format ["%1 - %2", mapGridPosition _pos, _displayName]
            , _pos
        ];
    });
};

_spawns
