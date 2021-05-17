#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getVehSpawnPos

    File: fn_garrison_getVehSpawnPos.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-23
    Last Update: 2021-05-06 15:03:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Finds an position where a vehicle can safely spawn. Skips water positions.

    Parameter(s):
        _targetPos - a target POSITION about which to find spawn position [POSITION, default: KPLIB_zeroPos]
        _className - a vehicle class name to use for purposes of establishing sufficient spawn space [STRING, default: _defaultClassName]
        _range - range about which to consider spawn position [SCALAR, default: KPLIB_param_sectors_capRange]

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
    , [Q(_range), KPLIB_param_sectors_capRange, [0]]
];

private _filterPos = {
    params [
        [Q(_0), 0]
        , [Q(_1), 0]
        , [Q(_2), 0]
    ];
    [_0, _1, _2];
};

private _spawnPos = +KPLIB_zeroPos;
private _minRange = MPARAM(_minRange);
private _emptyPosMinRange = 0;
private _emptyPosMaxRange = 50;

// Avoid spawn position on water or empty position by findEmptyPosition
while {
        _spawnPos isEqualTo KPLIB_zeroPos
            || surfaceIsWater _spawnPos
            || !((_spawnPos nearEntities MPARAM(_nearEntityRange)) isEqualTo []);
    } do {
    // Also this averts any hint of recursion
    private _randomPos = _targetPos getPos [_minRange max (random _range), random 360];
    private _foundPos = _randomPos findEmptyPosition [_emptyPosMinRange, _range min _emptyPosMaxRange, _className];
    _spawnPos = _foundPos call _filterPos;
    // // TODO: TBD: 'near roads' might be interesting, but doubtful it is necessary...
    // private _nearRoad = selectRandom (_targetPos nearRoads _range);
    // if (!isNil { _nearRoad; }) then { _spawnPos = getPosATL _nearRoad; };
};

// Return position with a slight z offset
(_spawnPos call _filterPos) vectorAdd [0, 0, 0.25];
