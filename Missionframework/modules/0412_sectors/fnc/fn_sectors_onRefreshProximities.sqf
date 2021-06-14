#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onRefreshProximities

    File: fn_sectors_onRefreshProximities.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-29 14:02:13
    Last Update: 2021-06-14 16:52:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REFRESH key bits of the CBA SECTOR namespace. When the OBJECT BUCKETS have been
        identified, then we will be able to properly account for them, count them, derive
        ratios, nearest distances, and so on.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]

    References:
        https://en.wikipedia.org/wiki/Maginot_Line
        https://en.wikipedia.org/wiki/Line_in_the_sand
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onRefreshProximities_debug)
    || (_sector getVariable [QMVAR(_onRefreshProximities_debug), false])
    ;

private _sectorPos = position _sector;
private _markerName = _sector getVariable [QMVAR(_markerName), ""];
private _blufor = _sector getVariable [QMVAR(_blufor), false];

if (_debug) then {
    [format ["[fn_sectors_onRefreshProximities] Entering: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Which BUCKETS shall have been refreshed by a prior event handler
private _bucketValues = [_sector] call MFUNC(_getBucketBundle);

_bucketValues params [
    Q(_actUnitsF), Q(_actUnitsE), Q(_actUnitsR), Q(_actUnitsC)
    , Q(_capUnitsF), Q(_capUnitsE), Q(_capUnitsR), Q(_capUnitsC)
    , Q(_actTanksF), Q(_actTanksE), Q(_actTanksR), Q(_actTanksC)
    , Q(_capTanksF), Q(_capTanksE), Q(_capTanksR), Q(_capTanksC)
];

// TODO: TBD: may relay this callback to the KPLIB_fnc_sectors_getBucketBundle function...
private _allActUnits = (_actUnitsF + _actUnitsE) select { [_x] call KPLIB_fnc_soldiers_canActivateSector; };
private _dividendCoef = [-1, 1] select _blufor;

if (_debug) then {
    [format ["[fn_sectors_onRefreshProximities] Ratios: [count _allActUnits, _dividendCoef]: %1"
        , str [count _allActUnits, _dividendCoef]], "SECTORS", true] call KPLIB_fnc_common_log;
    [format ["[fn_sectors_onRefreshProximities] Ratios: [count _actUnitsF, count _actUnitsE, count _actUnitsR, count _actUnitsC]: %1"
        , str [count _actUnitsF, count _actUnitsE, count _actUnitsR, count _actUnitsC]], "SECTORS", true] call KPLIB_fnc_common_log;
    [format ["[fn_sectors_onRefreshProximities] Ratios: [count _capUnitsF, count _capUnitsE, count _capUnitsR, count _capUnitsC]: %1"
        , str [count _capUnitsF, count _capUnitsE, count _capUnitsR, count _capUnitsC]], "SECTORS", true] call KPLIB_fnc_common_log;
    [format ["[fn_sectors_onRefreshProximities] Ratios: [count _actTanksF, count _actTanksE, count _actTanksR, count _actTanksC]: %1"
        , str [count _actTanksF, count _actTanksE, count _actTanksR, count _actTanksC]], "SECTORS", true] call KPLIB_fnc_common_log;
    [format ["[fn_sectors_onRefreshProximities] Ratios: [count _capTanksF, count _capTanksE, count _capTanksR, count _capTanksC]: %1"
        , str [count _capTanksF, count _capTanksE, count _capTanksR, count _capTanksC]], "SECTORS", true] call KPLIB_fnc_common_log;
};

[
    count _capUnitsR
    , count _capUnitsC
    , count (_capUnitsF + _capUnitsE)
    , count (_capTanksF + _capTanksE)
    , count (_capUnitsC + _capUnitsR)
    , round (_dividendCoef * (count _capUnitsF))
    , round (_dividendCoef * (count _capTanksF))
    , _allActUnits apply { _x distance2D _sectorPos; }
] params [
    Q(_capUnitCountR)
    , Q(_capUnitCountC)
    , Q(_capUnitDivisor)
    , Q(_capTankDivisor)
    , Q(_capCivResDivisor)
    , Q(_capUnitDividend)
    , Q(_capTankDividend)
    , Q(_allActUnitDists)
];

if (_debug) then {
    [format ["[fn_sectors_onRefreshProximities] Installing: [_capUnitCountR, _capUnitCountC, _capUnitDivisor, _capTankDivisor, _capCivResDivisor, _capUnitDividend, _capTankDividend, _allActUnitDists]: %1"
        , str [_capUnitCountR, _capUnitCountC, _capUnitDivisor, _capTankDivisor, _capCivResDivisor, _capUnitDividend, _capTankDividend, _allActUnitDists]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: also consider CIV, RESISTANCE, ratios
// TODO: TBD: extending into the HUD cut rsc...
// TODO: TBD: main PB is for the sector, DEFENDER v. ATTACKER (blue/red)
// TODO: TBD: smaller PB beneath indicating DEFENDER tanks v. ATTACKER tanks (blue/red)
// TODO: TBD: and a third PB for CIV+RESISTANCE ratio (could be GREE+PURPLE or non-existent 'gray')

// 'RATIO' of C+R is always CIVILIAN (GREEN) to RESISTANCE (PURPLE), or none (empty or GRAY)
{ _sector setVariable _x; } forEach [
    [QMVAR(_capCivResDividend), round (-1 * _capUnitCountR)]
    , [QMVAR(_capUnitCountR), _capUnitCountR]
    , [QMVAR(_capUnitCountC), _capUnitCountC]
    , [QMVAR(_capCivResDivisor), _capCivResDivisor]
    , [QMVAR(_capUnitDividend), _capUnitDividend]
    , [QMVAR(_capUnitDivisor), _capUnitDivisor]
    , [QMVAR(_capTankDividend), _capTankDividend]
    , [QMVAR(_capTankDivisor), _capTankDivisor]
    , [QMVAR(_nearestActDist), if (_allActUnitDists isNotEqualTo []) then { selectMin _allActUnitDists; }]
    // // TODO: TBD: we want these to be functions to do the calculation...
    // // TODO: TBD: why, because then we may apply offsets to dividends, divisors, and biases to the ratios themselves...
    // , [QMVAR(_capUnitRatio), if (_capUnitDivisor > 0) then { RAT(_capUnitDividend,_capUnitDivisor); }]
    // , [QMVAR(_actTankRatio), if (_capTankDivisor > 0) then { RAT(_capTankDividend,_capTankDivisor); }]
    // , [QMVAR(_capCivResRatio), if (_capCivResDivisor > 0) then { RAT(_capUnitCountC,_capCivResDivisor); }]
];

// TODO: TBD: we do not have the context necessary to make this decision during each sector refresh...

if (_debug) then {
    ["[fn_sectors_onRefreshProximities] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
