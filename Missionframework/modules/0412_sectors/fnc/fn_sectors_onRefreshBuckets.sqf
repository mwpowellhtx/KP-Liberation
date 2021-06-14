#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onRefreshBuckets

    File: fn_sectors_onRefreshBuckets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 19:19:50
    Last Update: 2021-06-14 16:51:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REFRESH key bits of the CBA SECTOR namespace. In this case, we take the overall
        UNITS+VEHICLES arrays, and subdivide them into appropriate BUCKETS, aligned
        according to SIDE, RANGE from the sector, and further according to object kind, etc.
        We do this instead of counts, per se, because it is just as easy to count the arrays
        once we have them subdivided anyway.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]

    References:
        https://www.dictionary.com/browse/divvy
        https://en.wikipedia.org/wiki/Maginot_Line
        https://en.wikipedia.org/wiki/Line_in_the_sand
        https://community.bistudio.com/wiki/forEach#Alternative_Syntax
        https://community.bistudio.com/wiki/toArray#Alternative_Syntax_2
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onRefreshBuckets_debug)
    || (_sector getVariable [QMVAR(_onRefreshBuckets_debug), false])
    ;

private _sectorPos = position _sector;
private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_onRefreshBuckets] Entering: [_markerName, markerText _markerName, %1, %2, %3]: %4"
        , QMPARAM(_actRange)
        , QMPARAM(_capRange)
        , Q(KPLIB_preset_allSides)
        , str [_markerName, markerText _markerName, MPARAM(_actRange), MPARAM(_capRange), KPLIB_preset_allSides]]
        , "SECTORS", true] call KPLIB_fnc_common_log;
};

// Starting from the initial results
private _allActUnits = [_sector] call MFUNC(_getAllUnits);
private _allActVehicles = [_sector] call MFUNC(_getAllVehicles);
private _allActTanks = _allActVehicles select { _x isKindOf Q(Tank); };

private _allCapObjects = [_allActUnits, _allActVehicles, _allActTanks] apply {
    private _actObjects = _x;
    _actObjects select { _sectorPos distance _x <= MPARAM(_capRange); };
};

_allCapObjects params [
    Q(_allCapUnits)
    , Q(_allCapVehicles)
    , Q(_allCapTanks)
];

if (_debug) then {
    [format ["[fn_sectors_onRefreshBuckets] [count _allActUnits, count _allActVehicles, count _allActTanks]: %1"
        , str [count _allActUnits, count _allActVehicles, count _allActTanks]], "SECTORS", true] call KPLIB_fnc_common_log;

    [format ["[fn_sectors_onRefreshBuckets] [count _allCapUnits, count _allCapVehicles, count _allCapTanks]: %1"
        , str [count _allCapUnits, count _allCapVehicles, count _allCapTanks]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Now divvy up the buckets by SIDE
private _allSideObjectMap = createHashMap;
{
    _x params [Q(_varNameInfix), Q(_allObjects)];

    _allSideObjectMap set [_varNameInfix, _allObjects];

    private _allSideObjects = KPLIB_preset_allSides apply {
        private _side = _x;
        _allObjects select { side _x isEqualTo _side; };
    };

    private _allSideVarNameSuffixes = KPLIB_preset_allSideSuffixes apply { _varNameInfix + _x; };
    _allSideObjectMap merge (_allSideVarNameSuffixes createHashMapFromArray _allSideObjects);

    if (_debug) then {
        [format ["[fn_sectors_onRefreshBuckets::forEach] [%1]: %2"
                , (_allSideVarNameSuffixes apply { format ["count %1", _x]; }) joinString ", "
                , str (_allSideObjects apply { count _x; })
            ], "SECTORS", true] call KPLIB_fnc_common_log;
    };

} forEach [
    [Q(_actUnits), _allActUnits]
    , [Q(_actVehicles), _allActVehicles]
    , [Q(_actTanks), _allActTanks]
    , [Q(_capUnits), _allCapUnits]
    , [Q(_capVehicles), _allCapVehicles]
    , [Q(_capTanks), _allCapTanks]
];

// Updated with new HASHMAP alternate syntax
{ _sector setVariable [["KPLIB_sectors", _x] joinString "", _y]; } forEach _allSideObjectMap;

// // TODO: TBD: sort out the buckets, from UNITS+VEHICLES to TANKS to SIDES etc...
// // TODO: TBD: and appropriate logging...
// // TODO: TBD: ...
// // TODO: TBD: ...
// // TODO: TBD: ...

// // And a bit further by KIND
// private _allActSideTanks = _allActSideVehicles apply {
//     private _sideVehicles = _x;
//     _sideVehicles select { _x isKindOf Q(Tank); };
// };

// if (_debug) then {
//     [format ["[fn_sectors_onRefreshBuckets] [_allActSideUnitCounts, _allActSideVehicleCounts, _allActSideTankCounts]: %1"
//         , str [
//             _allActSideUnits apply { count _x; }
//             , _allActSideVehicles apply { count _x; }
//             , _allActSideTanks apply { count _x; }
//         ]], "SECTORS", true] call KPLIB_fnc_common_log;
// };

// /* Results:
//  *  [
//  *      [
//  *          [_actUnitsE, _actUnitsF, _actUnitsC, _actUnitsR]
//  *          , [_capUnitsE, _capUnitsF, _capUnitsC, _capUnitsR]
//  *      ]
//  *      , [
//  *          [_actTanksE, _actTanksF, _actTanksC, _actTanksR]
//  *          , [_capTanksE, _capTanksF, _capTanksC, _capTanksR]
//  *      ]
//  *      , [
//  *          [_actVehiclesE, _actVehiclesF, _actVehiclesC, _actVehiclesR]
//  *          , [_capVehiclesE, _capVehiclesF, _capVehiclesC, _capVehiclesR]
//  *      ]
//  * ]
//  */

// private _allCapSideObjects = [_allActSideUnits, _allActSideVehicles, _allActSideTanks] apply {
//     private _actSideObjects = _x;
//     _actSideObjects select { _sectorPos distance _x <= MPARAM(_capRange); };
// };

// _allCapSideObjects params [
//     Q(_allCapSideUnits)
//     , Q(_allCapSideVehicles)
//     , Q(_allCapSideTanks)
// ];

// if (_debug) then {
//     [format ["[fn_sectors_onRefreshBuckets] [_allCapSideUnitCounts, _allCapSideVehicleCounts, _allCapSideTankCounts]: %1"
//         , str [
//             _allCapSideUnits apply { count _x; }
//             , _allCapSideVehicles apply { count _x; }
//             , _allCapSideTanks apply { count _x; }
//         ]], "SECTORS", true] call KPLIB_fnc_common_log;
// };

// private _varMap = createHashMap;

// // Now merge the values in terms of key-value pairs
// {
//     _x params [Q(_keys), Q(_values)];
//     _varMap merge (_keys createHashMapFromArray _values);
// } forEach [
//     [_allSideSuffixes apply { QMVAR(_actUnits) + _x; }, _allActSideUnits]
//     , [_capSideSuffixes apply { QMVAR(_capUnits) + _x; }, _allCapSideUnits]
//     , [_allSideSuffixes apply { QMVAR(_actTanks) + _x; }, _allActSideTanks]
//     , [_capSideSuffixes apply { QMVAR(_capTanks) + _x; }, _allCapSideTanks]
//     , [_allSideSuffixes apply { QMVAR(_actVehicles) + _x; }, _allActSideVehicles]
//     , [_capSideSuffixes apply { QMVAR(_capVehicles) + _x; }, _allCapSideVehicles]
// ];

// // Then we may simply transplant those key-value pairs as proper namespace variables
// { _sector setVariable _x; } forEach (_varMap toArray false);

// if (_debug) then {
//     ["[fn_sectors_onRefreshBuckets] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
// };

true;
