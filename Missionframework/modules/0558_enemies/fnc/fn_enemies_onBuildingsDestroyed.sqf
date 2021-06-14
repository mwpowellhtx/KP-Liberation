#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onBuildingsDestroyed

    File: fn_enemies_onBuildingsDestroyed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 13:17:51
    Last Update: 2021-06-14 17:17:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to SECTOR CAPTURED event with ENEMY module related bits. Marks buildings
        as ALREADY COUNTED, which, although is a module object variable, should only affect
        this function. This is important to avoid double counting buildings that may land
        within overlapping sector ranges.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onBuildingsDestroyed_debug)
    || (_sector getVariable [QMVAR(_onBuildingsDestroyed_debug), false])
    ;

[
    _sector getVariable [Q(KPLIB_garrison_buildings), []]
    , _sector getVariable [QMVAR(_civRepReward), 0]
    , _sector getVariable [Q(KPLIB_sectors_markerName), ""]
] params [
    Q(_buildings)
    , Q(_civRepReward)
    , Q(_markerName)
];

if (_debug) then {
    [format ["[fn_enemies_onBuildingsDestroyed] Entering: [_markerName, markerText _markerName, count _buildings]: %1"
        , str [_markerName, markerText _markerName, count _buildings]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

// If we got nothing in then just exit
if (_buildings isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_enemies_onBuildingsDestroyed] No buildings", "ENEMIES", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Do not double count buildings during the BDA
private _alreadyCounted = _buildings select { _x getVariable [QMVAR(_alreadyCounted), false]; };
_sector setVariable [QMVAR(_buildings), _buildings - _alreadyCounted];
_buildings = _buildings - _alreadyCounted;

private _damaged = _buildings select {
    private _damage = damage _x;
    private _alreadyCounted = _x getVariable [QMVAR(_alreadyCounted), false];
    !_alreadyCounted && ((MPARAM(_assessPartialBuildingDamage) && _damage > 0) || _damage >= 1);
};

if (_damaged isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_enemies_onBuildingsDestroyed] Nothing damaged", "ENEMIES", true] call KPLIB_fnc_common_log;
    };
    true;
};

private _damageDeltas = _damaged apply {
    private _damage = damage _x;
    // Allows for building specific penalties, i.e. based on relative building dimensions
    private _penalty = _x getVariable [QMVAR(_buildingDamagePenalty), MPARAM(_buildingDamageMaxPenalty)];
    // Also flag already counted in order to avoid double counting
    _x setVariable [QMVAR(_alreadyCounted), true];
    _damage * _penalty;
};

// TODO: TBD: add string table entry
[-([_damageDeltas] call KPLIB_fnc_linq_sum)] call {
    params [
        [Q(_damagePenalty), 0, [0]]
    ];
    if (_damagePenalty < 0) then {
        [_damagePenalty, format ["%1 buildings damaged or destroyed.", count _damaged], _markerName] call MFUNC(_addCivRep);
        _sector setVariable [QMVAR(_civRepReward), _civRepReward + _damagePenalty];
    };
};

// Finally 'forget' about buildings that were at all damaged in the prior engagement
_sector setVariable [QMVAR(_buildings), _buildings - _damaged];

if (_debug) then {
    [format ["[fn_enemies_onBuildingsDestroyed] Fini: [_markerName, markerText _markerName, count _damaged]: %1"
        , str [_markerName, markerText _markerName, count _damaged]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

true;
