/*
    KPLIB_fnc_respawn_getRespawns

    File: fn_respawn_getRespawns.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-12
    Last Update: 2021-05-24 22:26:29
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

private _allSpawns = [];

// TODO: TBD: may be able to fold mobile spawns in as well...
{
    private _markers = _x;
    private _offset = [0, 0, 0.1];
    private _spawnsToAppend = _markers apply {
        private _marker = _x;
        private _object = missionNamespace getVariable [_marker, objNull];
        private _markerText = _object getVariable ["KPLIB_sectors_markerText", markerText _marker];
        private _pos = if (!isNull _object) then { getPosATL _object; } else { markerPos _marker; };
        [
            format ["%1 - %2", mapGridPosition _pos, _markerText]
            , _pos vectorAdd _offset
        ];
    };
    _allSpawns append _spawnsToAppend;
} forEach [
    missionNamespace getVariable ["KPLIB_sectors_startbases", []]
    , missionNamespace getVariable ["KPLIB_sectors_fobs", []]
];

// TODO: TBD: we can probably manage a set of "KPLIB_sectors_mobileRespawns" as well...
/* Add mobile respawns to the spawn list if parameter is not disabled.
 * Get the display name from the vehicle configs and append. */
if (KPLIB_param_mobileRespawn) then {
    [[] call KPLIB_fnc_core_getMobSpawns] call {
        params ["_mobile"];
        private _mobileSpawnsToAppend = _mobile apply {
            private _pos = getPosATL _x;
            [
                format ["%1 - %2", mapGridPosition _pos
                    , getText (configFile >>  "CfgVehicles" >> (typeOf _x) >> "displayName")]
                , _pos
            ];
        };
        _allSpawns append _mobileSpawnsToAppend;
    };
};

_allSpawns;
