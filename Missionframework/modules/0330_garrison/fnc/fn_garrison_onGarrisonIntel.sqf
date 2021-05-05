#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisonIntel

    File: fn_garrison_onGarrisonIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-27 11:31:44
    Last Update: 2021-05-04 13:02:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Garrisons the INTEL bits at a specified location. We support creating up to the
        requested count or the number of buildings locations, which ever comes first. Only
        supports doing so at the MILITARY BASE sectors. We do some bookkeeping preparation
        for use later on during events such as SECTOR DEACTIVATED, GATHER INTEL, etc.

        We collect the INTEL bits into an ARRAY that we set as a variable on the namespace,
        'KPLIB_garrison_intel'. Additionally, we also set the TARGET NAMESPACE on each of
        the INTEL bits for use later on, 'KPLIB_garrison_targetNamespace'. We also set a
        UUID on each of the INTEL bits for easier identification, 'KPLIB_garrison_uuid'.

    Parameter(s):
        _namespace - a CBA SECTOR namespace being garrisoned for INTEL bits
            [LOCATION, default: locationNull]

    Returns:
        The number of INTEL bits actually created [SCALAR]

    References:
        https://community.bistudio.com/wiki/buildingPos
        https://community.bistudio.com/wiki/createVehicle
        https://community.bistudio.com/wiki/nearestObjects
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
        https://dictionary.com/browse/stochastic
        https://sciencedirect.com/topics/earth-and-planetary-sciences/stochasticity
        https://en.wikipedia.org/wiki/Stochastic
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onGarrisonIntel_debug)
    || (_namespace getVariable [QMVAR(_onGarrisonIntel_debug), false]);

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [Q(KPLIB_sectors_markerPos), +KPLIB_zeroPos]
    , _namespace getVariable [QMVAR(_garrison), []]
    , []
] params [
    Q(_markerName)
    , Q(_markerPos)
    , Q(_garrison)
    , Q(_intel)
];

_garrison params [
    Q(_0) // UNITS
    , Q(_1) // LIGHT VEHICLES
    , Q(_2) // HEAVY VEHICLES
    , [Q(_intelClassNames), [], [[]]]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisonIntel] Entering: [_markerName, markerText _markerName, count _intelClassNames, _intelClassNames]: %1"
        , str [_markerName, markerText _markerName, count _intelClassNames, _intelClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

if ((_markerPos isEqualTo KPLIB_zeroPos)
    || (_intelClassNames isEqualTo [])
    || !(_markerName in KPLIB_sectors_military)) exitWith { count _intel; };

// Shuffle some arrays for maximum stochastic effect
[
    _intelClassNames call BIS_fnc_arrayShuffle
    , nearestObjects [_markerPos, [Q(Building)], KPLIB_param_sectors_capRange, true]
] params [
    Q(_shuffledClassNames)
    , Q(_buildings)
];

// We only spawn INTEL in RELATIVELY UNDAMAGED BUILDINGS given THRESHOLD
private _shuffledBuildings = _buildings select { damage _x <= MPARAM(_intelBuildingDamageThreshold); };
// We do not care about the BUILDING per se but rather the available POSITIONS
private _positions = [[], _shuffledBuildings apply { _x buildingPos -1; }] call KPLIB_fnc_linq_aggregate;
private _shuffledPositions = _positions call BIS_fnc_arrayShuffle;

private _whereIntelCreated = {
    private _targetClassName = _x;
    private _obj = objNull;

    // The rest is handled loosely coupled and transparent to the actual GARRISON effort
    if (count _shuffledPositions > 0) then {

        private _pos = _shuffledPositions deleteAt 0;
        // TODO: TBD: we do not need to run through the KPLIB API vehicle creation bits...

        // Position is ATL so that works out perfectly
        _obj = createVehicle [_targetClassName, _pos vectorAdd [0, 0, 0.75], [], 0.25, Q(can_collide)];
        //                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^

        // Prepares the INTEL bit for easier identification and bookkeeping later on
        { _obj setVariable _x; } forEach [
            [QMVAR(_targetNamespace), _namespace]
            , [QMVAR(_uuid), [] call KPLIB_fnc_uuid_create_string]
        ];

        // This array is critical we will set this on the CBA SECTOR namespace
        _intel pushBack _obj;
    };

    !isNull _obj;
};

// May like to log this in debugging but for now we simply capture the response
private _createdClassNames = _shuffledClassNames select _whereIntelCreated;
// May also log left over '_shuffledPositions', (_shuffledClassNames - _createdClassNames), etc

// For use later on during GATHER INTEL and SECTOR DEACTIVATED events
_namespace setVariable [QMVAR(_intel), _intel];

if (_debug) then {
    [format ["[fn_garrison_onGarrisonIntel] Entering: [_markerName, markerText _markerName, count _intel]: %1"
        , str [_markerName, markerText _markerName, count _intel]], "GARRISON", true] call KPLIB_fnc_common_log;
};

count _intel;
