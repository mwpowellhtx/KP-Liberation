#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onRegisterBuildings

    File: fn_enemies_onRegisterBuildings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 15:54:21
    Last Update: 2021-04-26 13:28:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to SECTOR ACTIVATING event with ENEMY module related bits.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/typeOf
        https://community.bistudio.com/wiki/configOf
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onRegisterBuildings_debug)
    || (_namespace getVariable [QMVAR(_onRegisterBuildings_debug), false]);

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [QMVAR(_buildings), []]
] params [
    Q(_markerName)
    , Q(_buildings)
];

if (_debug) then {
    [format ["[fn_enemies_onRegisterBuildings] Entering: [_markerName, markerText _markerName, count _buildings]: %1"
        , str [_markerName, markerText _markerName, count _buildings]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

if (!([_namespace] call MFUNC(_allowBuildingDestruction))) exitWith {
    if (_debug) then {
        [format ["[fn_enemies_onRegisterBuildings] City or metropolis: [_markerName, markerText _markerName]: %1"
            , str [_markerName, markerText _markerName]], "ENEMIES", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Do not set it again
if (!(_buildings isEqualTo [])) exitWith {
    false;
};

private _markerPos = markerPos _markerName;
private _allBuildings = nearestObjects [_markerPos, [Q(Building)], KPLIB_param_sectors_capRange];

private _whereNotDamagedOrIgnored = {
    damage _x == 0
        && !((typeOf _x) in MPRESET(_ignoredBuildingClassNames));
};

_buildings = _allBuildings select _whereNotDamagedOrIgnored;

// // TODO: TBD: not need to set any variables on buildings for now...
// // TODO: TBD: future efforts, might be interesting to gauge buildings in terms of relative size/weighted against a configured max
// // TODO: TBD: assuming we can see the model config and object dimensions
// {
//     private _building = _x;
//     // // TODO: TBD: allow scoring based on relative dimensions...
//     // private _config = configOf _building;
//     { _building setVariable _x; } forEach [
//         [QMVAR(_buildingDamagePenalty), MPARAM(_buildingDamageMaxPenalty)]
//         , [QMVAR(_assessPartialBuildingDamage), MPARAM(_assessPartialBuildingDamage)]
//     ];
// } forEach _buildings;

if (_debug) then {
    [format ["[fn_enemies_onRegisterBuildings] Fini: [_markerName, markerText _markerName, count _buildings]: %1"
        , str [_markerName, markerText _markerName, count _buildings]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

// Note the buildings in the namespace for future reference
_namespace setVariable [QMVAR(_buildings), _buildings];

true;
