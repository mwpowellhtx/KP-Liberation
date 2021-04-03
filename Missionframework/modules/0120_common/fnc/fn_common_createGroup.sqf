/*
    KPLIB_fnc_common_createGroup

    File: fn_common_createGroup.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:40:23
    Last Update: 2021-04-02 14:40:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates a group at given side with units according to given array of classnames and fires the Liberation group created event.

    Parameter(s):
        _units      - Array of classnames to spawn as group members [ARRAY, defaults to []]
        _spawnPos   - Position to spawn the group and units         [POSITION, defaults to KPLIB_zeroPos]
        _side       - Side of the group                             [SIDE, defaults to KPLIB_preset_sideE]
        _addition   - Additional argument for unit creation         [STRING, defaults to "NONE"]

    Returns:
        Created group [GROUP]
*/

private _debug = [
    [
        {KPLIB_param_common_createGroup_debug}
    ]
] call KPLIB_fnc_common_debug;

params [
    ["_units", [], [[]]]
    , ["_spawnPos", KPLIB_zeroPos, [[]], 3]
    , ["_side", KPLIB_preset_sideE, [sideEmpty]]
    , ["_addition", "NONE", [""]]
];

if (_debug) then {
    [format ["[fn_common_createGroup] Entering: [count _units, _spawnPos, _side, _addition]: %1"
        , str [count _units, _spawnPos, _side, _addition]], "COMMON", true] call KPLIB_fnc_common_log;
};

private _grp = createGroup [_side, true];

{
    [_grp, _x, _spawnPos, _addition] call KPLIB_fnc_common_createUnit;
} forEach _units;

["KPLIB_group_created", [_grp]] call CBA_fnc_globalEvent;

if (_debug) then {
    ["[fn_common_createGroup] Fini", "COMMON", true] call KPLIB_fnc_common_log;
};

_grp;
