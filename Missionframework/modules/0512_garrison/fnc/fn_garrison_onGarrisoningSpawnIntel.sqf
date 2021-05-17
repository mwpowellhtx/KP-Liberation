#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningSpawnIntel

    File: fn_garrison_onGarrisoningSpawnIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-27 11:31:44
    Last Update: 2021-05-06 19:30:57
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

        Included is a guard detecting when GARRISON has already occurred and does not need
        to re-garrison.

    Parameter(s):
        _namespace - a CBA SECTOR namespace being garrisoned for INTEL bits
            [LOCATION, default: locationNull]
        _targetClassNames - the TARGET CLASS NAMES being spawned [ARRAY, default: []]

    Returns:
        The created INTEL objects [ARRAY]

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
    , [Q(_targetClassNames), [], [[]]]
];

private _debug = MPARAM(_onGarrisoningSpawnIntel_debug)
    || (_namespace getVariable [QMVAR(_onGarrisoningSpawnIntel_debug), false]);

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [Q(KPLIB_sectors_markerPos), +KPLIB_zeroPos]
    , _namespace getVariable [QMVAR(_garrison), []]
    , _namespace getVariable QMVAR(_actualIntelClassNames)
    , _namespace getVariable QMVAR(_intel)
] params [
    Q(_markerName)
    , Q(_markerPos)
    , Q(_garrison)
    , Q(_actualIntelClassName)
    , Q(_intel)
];

// Preclude duplicate garrison
if (!isNil { _actualIntelClassNames; }) exitWith {
    _garrison set [MPRESET(_garrisonIndex_intel), +_actualIntelClassNames];
    _namespace setVariable [QMVAR(_garrison), +_garrison];
    _intel;
};

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningSpawnIntel] Entering: [_markerName, markerText _markerName, count _targetClassNames, _targetClassNames]: %1"
        , str [_markerName, markerText _markerName, count _targetClassNames, _targetClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

if ((_markerPos isEqualTo KPLIB_zeroPos)
    || (_targetClassNames isEqualTo [])
    || !(_markerName in KPLIB_sectors_military)) exitWith {
    _intel = [];
    { _namespace setVariable _x; } forEach [
        [QMVAR(_intel), _intel]
        , [QMVAR(_actualIntelClassNames), []]
    ];
    _intel;
};

// Shuffle some arrays for maximum stochastic effect
[
    _targetClassNames call BIS_fnc_arrayShuffle
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

// May like to log this in debugging but for now we simply capture the response
_intel = _shuffledClassNames apply {
    private _obj = objNull;

    // Create as long as we have POSITIONS to support doing so
    if (count _shuffledPositions > 0) then {
        private _pos = _shuffledPositions deleteAt 0;

        // Position is ATL so that works out perfectly
        _obj = createVehicle [_x, _pos vectorAdd [0, 0, 0.75], [], 0.25, Q(can_collide)];
        //                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^

        // Prepares the INTEL bit for easier identification and bookkeeping later on
        { _obj setVariable _x; } forEach [
            [QMVAR(_targetNamespace), _namespace]
            , [QMVAR(_uuid), [] call KPLIB_fnc_uuid_create_string]
        ];
    };

    _obj;
};
// May also log left over '_shuffledPositions', (_shuffledClassNames - _createdClassNames), etc
_intel = _intel select { !isNull _x; };
_actualIntelClassNames = _intel apply { typeOf _x; };

// Set the INTEL array and flag do not need to re-garrison
{ _namespace setVariable _x; } forEach [
    [QMVAR(_intel), _intel]
    , [QMVAR(_actualIntelClassNames), +_actualIntelClassNames]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningSpawnIntel] Fini: [_markerName, markerText _markerName, count _actualIntelClassNames, _actualIntelClassNames]: %1"
        , str [_markerName, markerText _markerName, count _actualIntelClassNames, _actualIntelClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_intel;
