#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onBuildingsDestroyed

    File: fn_garrison_onBuildingsDestroyed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-15 10:25:03
    Last Update: 2021-06-15 10:25:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Evaluates the BUILDINGS Battle Damage Assessment (BDA) vis-a-vis damaged
        buildings. MAXIMUM CIVILIAN REPUTATION PENALTY shall have been assessed
        at the moment when buildings are CATALOGED during the REGIMENT phase when
        sectors are ACTIVATING. Partial building damage may be permitted.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]

    References:
        https://en.wikipedia.org/wiki/Bomb_damage_assessment
            - 'also known as battle damage assessment' (BDA)
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onBuildingsDestroyed_debug)
    || (_sector getVariable [QMVAR(_onBuildingsDestroyed_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _buildings = _sector getVariable [QMVAR(_buildings), []];

if (_debug) then {
    [format ["[fn_garrison_onBuildingsDestroyed] Entering: [_markerName, markerText _markerName, count _buildings]: %1"
        , str [_markerName, markerText _markerName, count _buildings]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// If we got nothing in then just exit
if (_buildings isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_garrison_onBuildingsDestroyed] No buildings", "GARRISON", true] call KPLIB_fnc_common_log;
    };
    false;
};

/* Predicate buildings as a function of the CBA settings; the important thing here is also
 * not to double count buildings that may occur between overlapping sectors. May or may not
 * be predicated by partial damage assessment.
 */
private _whereBuildingShouldCount = [
    { _this >= 1; }
    , { _this > 0; }
] select MPARAM(_assessPartialBuildingDamage);

private _bdaBuildings = _buildings select {
    private _building = _x;
    !(_building getVariable [QMVAR(_alreadyCounted), false])
        //                   ^^^^^^^^^^^^^^^^^^^^^^
        && (damage _building) call _whereBuildingShouldCount
        ;
};

if (_bdaBuildings isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_garrison_onBuildingsDestroyed] Nothing damaged", "GARRISON", true] call KPLIB_fnc_common_log;
    };
    true;
};

// Also flag already counted in order to avoid double counting
private _bdaCivRepPens = _bdaBuildings apply {
    private _building = _x;
    _building setVariable [QMVAR(_alreadyCounted), true];
    //                     ^^^^^^^^^^^^^^^^^^^^^^
    (damage _building) * (_building getVariable [QMVAR(_maxCivRepPenalty), 0]);
};

// Now evaluate the DAMAGE PENALTY although dampen might be one possible outlook
[[_bdaCivRepPens] call KPLIB_fnc_linq_sum] call {
    params [Q(_bdaCivRepPen)]; // Mind the signage
    _bdaCivRepPen = 0 - (abs _bdaCivRepPen);
    if (_bdaCivRepPen > 0) then {
        [
            0 - _bdaCivRepPen
            , format [localize "STR_KPLIB_GARRISON_garrison_DESTROYED_FORMAT", count _bdaBuildings]
            , _markerName
        ] call KPLIB_fnc_enemies_addCivRep;
    };
};

// 'Forget' about buildings in the BDA or that were ALREADY COUNTED i.e. by other sector BDA phases
private _alreadyCounted = _buildings select { _x getVariable [QMVAR(_alreadyCounted), false]; };
_sector setVariable [QMVAR(_buildings), _buildings - (_bdaBuildings + _alreadyCounted)];

if (_debug) then {
    [format ["[fn_garrison_onBuildingsDestroyed] Fini: [_markerName, markerText _markerName, count _bdaBuildings, _bdaCivRepPens]: %1"
        , str [_markerName, markerText _markerName, count _bdaBuildings, _bdaCivRepPens]], "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
