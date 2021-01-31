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
    [_x select 2 select 1, _x select 3 select 1] params ["_pos", "_markerText"];
    [
        format ["%1 - %2", mapGridPosition _pos, _markerText]
        , _pos
    ];
};

{
    // TODO: TBD: see: i.e. [_forEachIndex] call KPLIB_fnc_common_indexToMilitaryAlpha
    // Assumes that the FOB markers have already been refreshed; see docs for the tuple specs.
    [_x select 2 select 1, _x select 3 select 1] params ["_pos", "_markerText"];

    _spawns pushBack [
        // TODO: TBD: allowing the bits to all identify themselves in position and marker text...
        // TODO: TBD: which gets us much closder to a repeatable, deterministic pattern...
        format ["%1 - %2", mapGridPosition _pos, _markerText]
        , _pos
    ];
} forEach KPLIB_sectors_fobs;

// Add mobile respawns to the spawn list if parameter is not disabled
if (KPLIB_param_mobileRespawn) then {
    {
        [
            // Get the display name from the vehicle configs and append.
            getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName")
            , getPos _x
        ] params [
            "_displayName"
            , "_pos"
        ];

        _spawns pushBack [
            format ["%1 - %2", mapGridPosition _pos, _displayName]
            , _pos
        ];
    } forEach ([] call KPLIB_fnc_core_getMobSpawns);
};

_spawns
