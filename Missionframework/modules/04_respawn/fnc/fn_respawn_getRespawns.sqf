/*
    KPLIB_fnc_respawn_getRespawns

    File: fn_respawn_getRespawns.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-12
    Last Update: 2021-01-25 18:35:03
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

private _spawns = KPLIB_init_startbases apply {
    _x params ["_0", "_proxy", "_markerName"];
    
    [
        format ["%1 - %2", mapGridPosition getPos _proxy, markerText _markerName]
        , _proxy
    ];
};

{
    _spawns pushBack [
        // TODO: TBD: if there is not a function that gets an arbitrary index or count in "KPLIB_preset_alphabetF" terms, there needs to be...
        // TODO: TBD: while we would never expect a FOB like Alpha Bravo, for instance, we should at least expect more of an alphabet functional interface...
        // TODO: TBD: especially for later when we start enumerating logistics lines, for instance; that **IS** entirely plausible...
        format ["%1 - FOB %2", mapGridPosition getMarkerPos _x, [_forEachIndex] call KPLIB_fnc_common_indexToMilitaryAlpha]
        , _x
    ];
} forEach KPLIB_sectors_fobs;

// Add mobile respawns to the spawn list if parameter is not disabled
if (KPLIB_param_mobileRespawn) then {
    {
        // Get the display name from the vehicle configs and append.
        private _cfgDisplayName = getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName");

        _spawns pushBack [
            format ["%1 - %2", mapGridPosition getPos _x, _cfgDisplayName]
            , _x
        ];
    } forEach ([] call KPLIB_fnc_core_getMobSpawns);
};

_spawns
