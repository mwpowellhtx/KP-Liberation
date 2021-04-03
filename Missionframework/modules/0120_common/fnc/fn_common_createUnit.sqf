/*
    KPLIB_fnc_common_createUnit

    File: fn_common_createUnit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:40:46
    Last Update: 2021-04-02 14:40:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates a unit of given classnames and fires the Liberation unit created event.

    Parameter(s):
        _grp        - Group for the unit to join            [GROUP, defaults to grpNull]
        _classname  - Classname of the unit to spawn        [STRING, defaults to ""]
        _spawnPos   - Position to spawn the unit            [POSITION, defaults to KPLIB_zeroPos]
        _addition   - Additional argument for unit creation [STRING, defaults to "NONE"]

    Returns:
        Created unit [OBJECT]
*/

private _debug = [
    [
        {KPLIB_param_common_createUnit_debug}
    ]
] call KPLIB_fnc_common_debug;

params [
    ["_grp", grpNull, [grpNull]],
    ["_className", "", [""]],
    ["_spawnPos", KPLIB_zeroPos, [[]], [3]],
    ["_addition", "NONE", [""]]
];

if (_debug) then {
    [format ["[fn_common_createUnit] Entering: [isNull _grp, _className, _spawnPos, _addition]: %1"
        , str [isNull _grp, _className, _spawnPos, _addition]], "COMMON", true] call KPLIB_fnc_common_log;
};

if (_grp isEqualTo grpNull || _className isEqualTo "") exitWith {
    objNull;
};

// Create temp group, as we need to let the unit join the "correct side group".
// If we use the "correct side group" for the createUnit, the group would switch to the side of the unit written in the config.
private _grpTemp = createGroup [civilian, true];

// Create unit in temp group
private _unit = _grpTemp createUnit [_className, _spawnPos, [], 10, _addition];

// Let unit join the "correct side group"
[_unit] joinSilent _grp;

// Remove temp group
deleteGroup _grpTemp;

["KPLIB_unit_created", [_unit]] call CBA_fnc_globalEvent;

if (_debug) then {
    ["[fn_common_createUnit] Fini", "COMMON", true] call KPLIB_fnc_common_log;
};

_unit;
