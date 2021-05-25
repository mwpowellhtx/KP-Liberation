#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_canDeploy

    File: fn_fobs_canDeploy.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-11
    Last Update: 2021-05-25 11:00:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether PLAYER may BUILD FOB from the BOXORTRUCK object.

    Parameter(s):
        _boxOrTruck - FOB box or truck [OBJECT, default: objNull]
        _player - the player trying to build FOB [OBJECT, default: objNull]
        _random - optionally whether RANDOM deployment is the ask [BOOL, default: false]

    Returns:
        Whether PLAYER May BUILD FOB from the BOXORTRUCK object [BOOL]
 */

params [
    [Q(_boxOrTruck), objNull, [objNull]]
    , [Q(_player), objNull, [objNull]]
    , [Q(_random), false, [false]]
];

private _debug = MPARAM(_canBuild_debug)
    || (_boxOrTruck getVariable [QMVAR(_canBuild_debug), false])
    || (_player getVariable [QMVAR(_canBuild_debug), false])
    ;

// Return early when either of them is NULL|!ALIVE
if (({ isNull _x || !alive _x; } count [_boxOrTruck, _player]) > 0) exitWith {
    false;
};

// Take the maximum of either of these two values in order that either does not overlap
private _minDeployRange = [] call KPLIB_fnc_common_getMinimumDeployRange;

if (_debug) then {
    [format ["[fn_fobs_canBuild] Entering: [typeOf _boxOrTruck, typeOf _player, _random, _minDeployRange]: %1"
        , str [typeOf _boxOrTruck, typeOf _player, _random, _minDeployRange]], "FOBS", true] call KPLIB_fnc_common_log;
};

/* Whereas in most other instances we ARE looking for a NEAREST MARKER, in THIS instance, we
 * actually ARE NOT looking for one. That is, we WANT the space to be free and clear so that
 * a new FOB may be deployed. */

// TODO: TBD: may refactor in terms of proper CBA setting...
private _maxMomentum = 5;

private _momentum = [_boxOrTruck] call KPLIB_fnc_common_getMomentum;

private _randomOrVennOkay = if (_random) then {
    count KPLIB_sectors_fobs == 0;
} else {

    private _nearestMarker = [
        _boxOrTruck
        , KPLIB_sectors_startbases + KPLIB_sectors_fobs + KPLIB_sectors_all
        , [] call KPLIB_fnc_common_getMinimumDeployRange
    ] call KPLIB_fnc_common_getNearestMarker;

    _nearestMarker isEqualTo "";
};

/* Keep it simple, REALLY simple... Whether '_boxOrTruck' is...
 * 1. sufficiently at rest, i.e. not in motion
 * 2. not within range of ANY target markers; 'any' meaning ALL, effectively
 */

_momentum <= _maxMomentum
    && _randomOrVennOkay
    ;
