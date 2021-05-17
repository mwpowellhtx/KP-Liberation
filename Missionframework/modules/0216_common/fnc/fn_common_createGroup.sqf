/*
    KPLIB_fnc_common_createGroup

    File: fn_common_createGroup.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:40:23
    Last Update: 2021-05-03 16:41:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates a GROUP at given SIDE with UNITS according to given array of classnames
        and raises the 'KPLIB_group_created' event.

    Parameter(s):
        _classNames - array of classnames to spawn as group members [ARRAY, default: []]
        _spawnPos - POSITION to spawn the group and units [POSITION, default: KPLIB_zeroPos]
        _side - SIDE of the group [SIDE, default: KPLIB_preset_sideE]
        _special - the SPECIAL argument for unit creation [STRING, default: "NONE"]

    Returns:
        A created GROUP [GROUP]
 */

private _debug = [
    [
        {KPLIB_param_common_createGroup_debug}
    ]
] call KPLIB_fnc_common_debug;

params [
    ["_classNames", [], [[]]]
    , ["_spawnPos", KPLIB_zeroPos, [[]], 3]
    , ["_side", KPLIB_preset_sideE, [sideEmpty]]
    , ["_special", "NONE", [""]]
];

if (_debug) then {
    [format ["[fn_common_createGroup] Entering: [count _classNames, _spawnPos, _side, _special]: %1"
        , str [count _classNames, _spawnPos, _side, _special]], "COMMON", true] call KPLIB_fnc_common_log;
};

private _grp = createGroup [_side, true];
private _units = _classNames apply { [_grp, _x, _spawnPos, _special] call KPLIB_fnc_common_createUnit; };

["KPLIB_group_created", [_grp]] call CBA_fnc_globalEvent;

if (_debug) then {
    [format ["[fn_common_createGroup] Fini: [count _units]: %1"
        , str [count _units]], "COMMON", true] call KPLIB_fnc_common_log;
};

_grp;
