#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getVehiclePosition

    File: fn_garrison_getVehiclePosition.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-23
    Last Update: 2021-06-03 23:24:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Finds an POSITION where a VEHICLE may safely be created. Skips water positions.

    Parameter(s):
        _targetPos - a target POSITION about which to find spawn position [POSITION, default: KPLIB_zeroPos]
        _className - a vehicle class name to use for purposes of establishing sufficient spawn space [STRING, default: _defaultClassName]
        _options - an ASSOCIATIVE ARRAY of OPTIONS [[], default: []]
            [
                _minDist - [SCALAR, default: KPLIB_param_garrison_minRange]
                , _maxDist - [SCALAR, default: KPLIB_param_sectors_capRange]
                , _objDist - [SCALAR, default: _vehicleSafeRadius]
                , _waterMode - [SCALAR, default: 0]
                , _maxGrad - [SCALAR, default: 0.25]
                , _shoreMode - [SCALAR, default: 0]
                , _defaultPos - [SCALAR, default: []]
                , _blacklistPos - [SCALAR, default: []]
            ]

    Returns:
        A safe position at which to create the VEHICLE [POSITION AGL]

    References:
        https://community.bistudio.com/wiki/getPos#Alternative_Syntax_2
        https://community.bistudio.com/wiki/BIS_fnc_findSafePos
 */

// TODO: TBD: and why 'B_T_VTOL_01_armed_F' (?) we could not just receive a class name?
private _defaultClassName = "B_T_VTOL_01_armed_F";

params [
    [Q(_targetPos), +KPLIB_zeroPos, [[]], [3]]
    , [Q(_className), _defaultClassName, [""]]
    , [Q(_options), [], [[]]]
];

private _optionMap = createHashMapFromArray _options;
private _vehicleSafeRadius = [_className] call KPLIB_fnc_common_vehicleSafeRadius;

[
    _optionMap getOrDefault [Q(_minDist), MPARAM(_minRange)]
    , _optionMap getOrDefault [Q(_maxDist), KPLIB_param_sectors_capRange]
    , _optionMap getOrDefault [Q(_objDist), _vehicleSafeRadius]
    , _optionMap getOrDefault [Q(_waterMode), 0]
    , _optionMap getOrDefault [Q(_maxGrad), 0.25]
    , _optionMap getOrDefault [Q(_shoreMode), 0]
    , _optionMap getOrDefault [Q(_defaultPos), []]
    , _optionMap getOrDefault [Q(_blacklistPos), []]
] params [
    Q(_minDist)
    , Q(_maxDist)
    , Q(_objDist)
    , Q(_waterMode)
    , Q(_maxGrad)
    , Q(_shoreMode)
    , Q(_blacklistPos)
    , Q(_defaultPos)
];

// We let the BIS algo do the work, we can provide the options
private _safePos = [_targetPos, _minDist, _maxDist, _objDist, _waterMode, _maxGrad, _shoreMode, _blacklistPos, _defaultPos] call BIS_fnc_findSafePos;

_safePos params [
    [Q(_safePosX), 0, [0]]
    , [Q(_safePosY), 0, [0]]
    , [Q(_safePosZ), 0, [0]]
];

[_safePosX, _safePosY, _safePosZ] vectorAdd [0, 0, 0.1];
