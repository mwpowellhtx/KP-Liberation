#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getSectorSitRep

    File: fn_sectors_getSectorSitRep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 19:31:14
    Last Update: 2021-06-14 16:50:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the CBA SECTOR namespace SITREP for dispensation to the listening players.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        An associative array corresponding to the SITREP [ARRAY]

    References:
        https://community.bistudio.com/wiki/allUnits
        https://community.bistudio.com/wiki/allDeadMen
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_getSectorSitRep_debug)
    || (_sector getVariable [QMVAR(_getSectorSitRep_debug), false])
    ;

/* We will include the MARKER NAME for sake of completeness, although we may
 * be able to leverage  the 'KPLIB_sectors_nearestSector' player variable. At
 * the very least potentially we can use that to align whether to refresh the
 * SECTOR HUD, i.e. until the PLAYER PROXIMITY has been updated as well.
 */
private _markerName = _sector getVariable [QMVAR(_markerName), ""];
private _blufor = _sector getVariable [QMVAR(_blufor), false];

if (_debug) then {
    [format ["[fn_sectors_getSectorSitRep] Entering: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _sitRep = [];

// As a precaution however should never see this exit here
if (isNull _sector) exitWith { _sitRep; };

private _count = true;
private _bundle = [_sector, _count] call MFUNC(_getBucketBundle);

_bundle params [
    Q(_actUnitCountF), Q(_actUnitCountE), Q(_actUnitCountR), Q(_actUnitCountC)
    , Q(_capUnitCountF), Q(_capUnitCountE), Q(_capUnitCountR), Q(_capUnitCountC)
    , Q(_actTankCountF), Q(_actTankCountE), Q(_actTankCountR), Q(_actTankCountC)
];

/* Array the UNITS and TANKS across those that would ACTIVATE as well as
 * CAPTURE the sector, and across all SIDES.
 */
_sitRep append [
    [QMVAR(_markerName), _markerName]
    , [QMVAR(_blufor), _blufor]
    , [QMVAR(_actUnitCountF), _actUnitCountF]
    , [QMVAR(_actUnitCountE), _actUnitCountE]
    , [QMVAR(_actUnitCountR), _actUnitCountR]
    , [QMVAR(_actUnitCountC), _actUnitCountC]
    , [QMVAR(_capUnitCountF), _capUnitCountF]
    , [QMVAR(_capUnitCountE), _capUnitCountE]
    , [QMVAR(_capUnitCountR), _capUnitCountR]
    , [QMVAR(_capUnitCountC), _capUnitCountC]
    , [QMVAR(_actTankCountF), _actTankCountF]
    , [QMVAR(_actTankCountE), _actTankCountE]
    , [QMVAR(_actTankCountR), _actTankCountR]
    , [QMVAR(_actTankCountC), _actTankCountC]
];

// Also including the DIVIDENDS and DIVISORS
private _proximityVars = [
    [QMVAR(_capCivResDividend), 0]
    , [QMVAR(_capCivResDivisor), 0]
    , [QMVAR(_capUnitDividend), 0]
    , [QMVAR(_capUnitDivisor), 0]
    , [QMVAR(_capTankDividend), 0]
    , [QMVAR(_capTankDivisor), 0]
    , [QMVAR(_nearestActDist), -1]
];
private _proximities = _proximityVars apply { [_x select 0, _sector getVariable _x]; };
_sitRep append _proximities;

// TODO: TBD: should consider setting these as presets if they are not already...
// Also include some colors
_sitRep append [
    [QMVAR(_colorActF), [0, 0, 0.9, 1]]
    , [QMVAR(_colorActE), [0.9, 0, 0, 1]]
    , [QMVAR(_colorActR), [0.85, 0, 0.95, 1]]
    , [QMVAR(_colorActC), [0, 0.9, 0, 1]]
];

if (_debug) then {
    private _sitRepMap = createHashMapFromArray _sitRep;

    {
        private _key = _x;
        private _value = _sitRepMap get _key;
        [format ["[fn_sectors_getSectorSitRep] Key: [_key, _value]: %1"
            , str [_key, _value]], "SECTORS", true] call KPLIB_fnc_common_log;
    } forEach (keys _sitRepMap);

    [format ["[fn_sectors_getSectorSitRep] Fini: [_markerName, markerText _markerName, _blufor]: %1"
        , str [_markerName, markerText _markerName, _blufor]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_sitRep;
