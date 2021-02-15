/*
    KPLIB_fnc_core_canBuildFob

    File: fn_core_canBuildFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-11
    Last Update: 2021-01-27 14:22:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether '_player' can build FOB from box or truck.

    Parameter(s):
        _boxOrTruck - FOB box or truck [OBJECT, default: objNull]
        _player - the player trying to build FOB [OBJECT, default: objNull]

    Returns:
        True if '_boxOrTruck' meets the criteria [BOOL]
*/

private _debug = false && ([] call KPLIB_fnc_build_debug);

params [
    ["_boxOrTruck", objNull, [objNull]]
    , ["_player", objNull, [objNull]]
];

// Take the maximum of either of these two values in order that either does not overlap
private _minSectorDist = KPLIB_param_fobRange max KPLIB_param_sectorCapRange;

if (_debug) then {
    [format ["[fn_core_canBuildFob] Entering: [isNull _boxOrTruck, typeOf _boxOrTruck, typeOf _player, KPLIB_param_fobRange, KPLIB_param_sectorCapRange]: %1"
        , str [isNull _boxOrTruck, typeOf _boxOrTruck, typeOf _player, KPLIB_param_fobRange, KPLIB_param_sectorCapRange]], "BUILD", true] call KPLIB_fnc_common_log;
};

/* Keep it simple, REALLY simple... Whether '_boxOrTruck' is...
 * 1. not null
 * 2. alive
 * 3. sufficiently at rest, i.e. not in motion
 * 4. not within range of ANY target markers; 'any' meaning ALL, effectively
 */
!(isNull _boxOrTruck)
    && alive _boxOrTruck
    && abs (speed _boxOrTruck) < 5
    && !([_boxOrTruck, _minSectorDist] call KPLIB_fnc_common_getTargetMarkerInRange);
