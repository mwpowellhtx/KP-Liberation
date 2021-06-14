#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onCreateOpforUnits

    File: fn_garrison_onCreateOpforUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 16:53:27
    Last Update: 2021-06-14 17:12:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        This function takes the UNITS REGIMENT, which shall have already been split
        according to GRP allocation, creates those GRPS of UNITS, and places them according
        to the following strategy. The key to success in this function is to allow for some
        redundancy, and to allow for contingencies during placement. The following strategies
        are preferred when placing units during this event handler.

        Okay, so what does all that mean. When there are buildings with supported positions,
        then we want to exhaust those for each GRP first. At the moment we are supporting ONE
        GRP+UNIT+POS, but we may reconsider that for interior positions in the future. When
        interior positions are exhausted, then we place UNITS surrounding the buildings. When 
        there are no further buildings available, then we find safe, non-water positions
        throughout sector for the GRP to be placed.

        Concerning eligible GRP buildings, using the sector buildings, those buildings with
        support for one or more positions. We expect that all such infrastructure elements
        are received into each sector using the 'BIS_fnc_arrayShuffle' function, so that when
        it comes time to leveraging them for spawn positions, they are randomly available.

        UNITS spawned in or around a building will be given instructions to defend that area.
        UNITS spawned in an open area will be given instructions to patrol the sector.

    Parameters:
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _regimentMap - the REGIMENT HASHMAP [HASHMAP, default: emptyHashMap]
        _garrisonMap - the GARRISON HASHMAP [HASHMAP, default: emptyHashMap]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://www.dictionary.com/browse/slew
        https://community.bistudio.com/wiki/isFlatEmpty
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_regimentMap), createHashMap, [emptyHashMap]]
    , [Q(_garrisonMap), createHashMap, [emptyHashMap]]
];

// TODO: TBD: instead of "one unit per building" really need more of a tracking for that...
// TODO: TBD: might be helpful if we can ask a 'building' what objects or units it contains (?)
// TODO: TBD: best I can come up with at the moment is this, but it is UNIT centric and would be kind of cumbersome probably...
// _objs = lineIntersectsObjs [atltoasl (getpos player), atltoasl (getpos player vectoradd [0, 0, 20]), objnull, objnull, true, 32];

private _debug = MPARAM(_onCreateOpforUnits_debug)
    || (_sector getVariable [QMVAR(_onCreateOpforUnits_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    [format ["[fn_garrison_onCreateOpforUnits] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _capRange = KPLIB_param_sectors_capRange;
private _unitRadius = MPRESET(_buildingUnitRadius);
private _buildingRadius = MPRESET(_buildingRadius);

private _sectorPos = position _sector;

if (_debug) then {
    // TODO: TBD: logging
};

// Starting from all of the known SECTOR BUILDINGS assuming they are shuffled
private _buildings = +(_sector getVariable [QMVAR(_buildings), []]);
private _positions = [_buildings] call MFUNC(_getBuildingPositions);

if (_debug) then {
    // TODO: TBD: logging
};

// Returns the next slew of buildings for unit placement and reduces the available buildings
private _getBuildings = {
    private _referenceBuilding = _this;
    private _slew = _buildings select { _x distance _referenceBuilding <= _buildingRadius; };
    _buildings = _buildings - _slew;
    if (_debug) then {
        // TODO: TBD: logging
    };
    _slew;
};

// UNIT CLASSES shall have already been GROUPED during the REGIMENT phase
private _unitClasses = _regimentMap get QMVAR(_unitClasses);
private _units = _garrisonMap getOrDefault [QMVAR(_units), []];

// TODO: TBD: at the moment we are taking a one-building-pos-unit approach...
// TODO: TBD: however, we may consider plugging in different strategies here...
// TODO: TBD: the main driving interest is to not split up units across large geographical areas...
// TODO: TBD: rather to center units, more or less around a certain area...
{
    private _grp = [_x, _sectorPos] call KPLIB_fnc_common_createGroup;

    // Get the UNITS in each GRP and APPEND them early so we do not forget
    private _unitsToPlace = units _grp;
    _units append _unitsToPlace;

    if (_debug) then {
        // TODO: TBD: logging
    };

    // Identify the NEXT BUILDING about which to center placement
    _buildings params [[Q(_building), objNull, [objNull]]];
    private _buildingsToPlace = _building call _getBuildings;

    // There are POSITIONS meaning there are BUILDINGS to choose among
    private _getMinPlaceDistance = {
        private _pos = _this;
        private _distances = _buildingsToPlace apply { _pos distance _x; };
        if (_debug) then {
            // TODO: TBD: logging
        };
        selectMin _distances;
    };

    /* Which if we're 'here' then it means we had at least one BUILDING with POSITIONS.
     * Start with the POSITIONS 'in range' then add a few more distinct ones about each one.
     */
    private _positionsToPlace = _positions select { (_x call _getMinPlaceDistance) <= _unitRadius; };
    // Does not matter what the forEach range was, simply to iterate a couple of times in an easy manner
    { _positionsToPlace append (_positionsToPlace apply { _x getPos [1, random 360]; }); } forEach [0, 1];
    //                                                                                             ^^^^^^
    _positionsToPlace = _positionsToPlace arrayIntersect _positionsToPlace;

    if (_debug) then {
        // TODO: TBD: logging
    };

    {
        private _unit = _x;

        // Exhaust the obvious POSITIONS TO PLACE first
        private _targetPos = switch (true) do {

            case (_positionsToPlace isNotEqualTo []): {
                if (_debug) then {
                    // TODO: TBD: logging
                };
                _positionsToPlace deleteAt 0;
            };

            case (_buildingsToPlace isNotEqualTo []): {
                // We may focus on the BUILDINGS themselves
                if (_debug) then {
                    // TODO: TBD: logging
                };
                [position selectRandom _buildingsToPlace, _unitRadius / 2] call MFUNC(_findSafePosition);
            };

            // Calculate positions about the BUILDINGS TO PLACE or the DEFAULT POSITION
            default {
                // DEFAULT+DEFAULT is to find safe pos centered by SECTOR, then about that
                if (_debug) then {
                    // TODO: TBD: logging
                };
                private _posNoBuilding = [_sectorPos, (_capRange/2) + random (_capRange/2)] call MFUNC(_findSafePosition);
                [_posNoBuilding, _unitRadius / 2] call MFUNC(_findSafePosition);
            };
        };

        // Now actually place the UNIT with a vector add
        _unit setPosATL (_targetPos vectorAdd MPRESET(_unitPosDelta));

    } forEach _unitsToPlace;

// Assumes that the UNIT CLASSES have already been regimented into 'GRPS'
} forEach _unitClasses;

if (_debug) then {
    // TODO: TBD: logging
};

// TODO: TBD: 'all' of the units? or only the 'leaders' (?)
// TODO: TBD: and is there a better timing to do this (?)
// TODO: TBD: may also need, "disableAI 'move'"
// https://community.bistudio.com/wiki/doStop
{ doStop _x; } forEach _units;

// After the placement algo dust is settled then (re-)set the GARRISON UNITS
_garrisonMap set [QMVAR(_units), _units];

if (_debug) then {
    ["[fn_garrison_onCreateOpforUnits] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
