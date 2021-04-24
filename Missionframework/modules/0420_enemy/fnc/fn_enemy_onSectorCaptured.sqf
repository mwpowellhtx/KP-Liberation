#include "script_component.hpp"
/*
    KPLIB_fnc_enemy_onSectorCaptured

    File: fn_enemy_onSectorCaptured.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 15:50:12
    Last Update: 2021-04-23 15:50:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to SECTOR CAPTURED event with ENEMY module related bits. Marks buildings
        as ALREADY COUNTED, which, although is a module object variable, should only affect
        this function. This is important to avoid double counting buildings that may land
        within overlapping sector ranges.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = MPARAM(_onSectorCaptured_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

[
    _namespace getVariable [QMVAR(_buildings), []]
    , _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
] params [
    Q(_buildings)
    , Q(_markerName)
];

if (_debug) then {
    [format ["[fn_enemy_onSectorCaptured] Entering: [_markerName, markerText _markerName, count _buildings]: %1"
        , str [_markerName, markerText _markerName, count _buildings]], "ENEMY", true] call KPLIB_fnc_common_log;
};

// If we got nothing in then just exit
if (_buildings isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_enemy_onSectorCaptured] No buildings", "ENEMY", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Do not double count buildings during the BDA
private _alreadyCounted = _buildings select { _x getVariable [QMVAR(_alreadyCounted), false]; };
_namespace setVariable [QMVAR(_buildings), _buildings - _alreadyCounted];
_buildings = _buildings - _alreadyCounted;

private _damaged = _buildings select {
    private _damage = damage _x;
    private _alreadyCounted = _x getVariable [QMVAR(_alreadyCounted), false];
    !_alreadyCounted && ((MPARAM(_assessPartialBuildingDamage) && _damage > 0) || _damage >= 1);
};

if (_damaged isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_enemy_onSectorCaptured] Nothing damaged", "ENEMY", true] call KPLIB_fnc_common_log;
    };
    false;
};

private _damageDeltas = _damaged apply {
    private _damage = damage _x;
    // Allows for building specific penalties, i.e. based on relative building dimensions
    private _penalty = _x getVariable [QMVAR(_buildingDamagePenalty), MPARAM(_buildingDamageMaxPenalty)];
    // Also flag already counted in order to avoid double counting
    _x setVariable [QMVAR(_alreadyCounted), true];
    _damage * _penalty;
};

private _totalDelta = [_damageDeltas] call KPLIB_fnc_linq_sum;

if (_totalDelta > 0) then {
    // TODO: TBD: add string table entry
    // Remember it is a PENALTY
    [-_totalDelta, format ["%1 buildings damaged or destroyed.", count _damaged], _markerName] call MFUNC(_addCivRep);
};

// Finally 'forget' about buildings that were at all damaged in the prior engagement
_namespace setVariable [QMVAR(_buildings), _buildings - _damaged];

if (_debug) then {
    [format ["[fn_enemy_onSectorCaptured] Fini: [_markerName, markerText _markerName, _totalDelta, count _damaged]: %1"
        , str [_markerName, markerText _markerName, _totalDelta, count _damaged]], "ENEMY", true] call KPLIB_fnc_common_log;
};

true;
