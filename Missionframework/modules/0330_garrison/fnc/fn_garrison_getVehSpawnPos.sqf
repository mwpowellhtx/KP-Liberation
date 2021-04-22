#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getVehSpawnPos

    File: fn_garrison_getVehSpawnPos.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-23
    Last Update: 2021-04-14 23:27:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Finds an position where a vehicle can safely spawn. Skips water positions.

    Parameter(s):
        _targetPos - a target POSITION about which to find spawn position [POSITION, default: KPLIB_zeroPos]
        _className - a vehicle class name to use for purposes of establishing sufficient spawn space [STRING, default: _defaultClassName]

    Returns:
        Position to spawn [POSITION AGL]

    References:
        https://community.bistudio.com/wiki/getPos#Alternative_Syntax_2
 */

// TODO: TBD: and why 'B_T_VTOL_01_armed_F' (?) we could not just receive a class name?
private _defaultClassName = "B_T_VTOL_01_armed_F";

params [
    [Q(_targetPos), KPLIB_zeroPos, [[]], [3]]
    , [Q(_className), _defaultClassName, [""]]
];

private _spawnPos = [];

private _minRange = MPARAM(_minRange);
private _capRange = KPLIB_param_sectors_capRange;
private _actRange = KPLIB_param_sectors_actRange;

// Avoid spawn position on water or empty position by findEmptyPosition
while {
        _spawnPos isEqualTo []
            || surfaceIsWater _spawnPos
            || !((_spawnPos nearEntities MPARAM(_nearEntityRange)) isEqualTo []);
    } do {

    // Also this averts any hint of recursion
    _spawnPos = (_targetPos getPos [_minRange + (random (_minRange max _actRange)), random 360]) findEmptyPosition [0, 50, _className];

    private _nearRoad = selectRandom (_targetPos nearRoads _capRange);

    if (!isNil Q(_nearRoad)) then {
        _spawnPos = getPosATL _nearRoad;
    };
};

// Return position with a slight z offset
[_spawnPos#0, _spawnPos#1, 0.25];
