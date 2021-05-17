/*
    KPLIB_fnc_common_createUnit

    File: fn_common_createUnit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:40:46
    Last Update: 2021-05-03 16:43:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates a unit of given classnames and fires the Liberation unit created event.

    Parameter(s):
        _grp - a GROUP for the unit to join [GROUP, default: grpNull]
        _className - a classname of the unit to spawn [STRING, default: ""]
        _spawnPos - position to spawn the unit [POSITION, default: KPLIB_zeroPos]
        _special - the SPECIAL argument for unit creation [STRING, default: "NONE"]

    Returns:
        A created UNIT [OBJECT]
 */

private _debug = [
    [
        {KPLIB_param_common_createUnit_debug}
    ]
] call KPLIB_fnc_common_debug;

params [
    ["_grp", grpNull, [grpNull]]
    , ["_className", "", [""]]
    , ["_spawnPos", KPLIB_zeroPos, [[]], [3]]
    , ["_special", "NONE", [""]]
];

if (_debug) then {
    [format ["[fn_common_createUnit] Entering: [isNull _grp, _className, _spawnPos, _special]: %1"
        , str [isNull _grp, _className, _spawnPos, _special]], "COMMON", true] call KPLIB_fnc_common_log;
};

if (_grp isEqualTo grpNull || _className isEqualTo "") exitWith {
    objNull;
};

// Create temp group, as we need to let the unit join the "correct side group".
// If we use the "correct side group" for the createUnit, the group would switch to the side of the unit written in the config.
private _grpTemp = createGroup [civilian, true];

// Create unit in temp group
private _unit = _grpTemp createUnit [_className, _spawnPos, [], 10, _special];

// Let unit join the "correct side group"
[_unit] joinSilent _grp;

// Remove temp group
deleteGroup _grpTemp;

["KPLIB_unit_created", [_unit]] call CBA_fnc_globalEvent;

if (_debug) then {
    ["[fn_common_createUnit] Fini", "COMMON", true] call KPLIB_fnc_common_log;
};

_unit;
