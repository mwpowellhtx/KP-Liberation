#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoning

    File: fn_garrison_onGarrisoning.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 16:33:22
    Last Update: 2021-05-05 18:30:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        What we populate the CBA GARRISON namespace with depends on ALIGNMENT,
        as well as AWARENESS, STRENGTH, and sometimes also CIVILIAN REPUTATION.

    Parameter(s):
        _namespace - a CBA GARRISON namespace [LOGATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

// TODO: TBD: currently assuming that the sector is "OPFOR" when it requires GARRISON
// TODO: TBD: may also garrison for BLUFOR, i.e. especially for CR hostile scenarios...
// TODO: TBD: i.e. garrison of IEDs, but then again...
// TODO: TBD: i.e. may need to add constraints when objects already exist...
// TODO: TBD: i.e. which also beggars the question, should "all" sectors just be wrapped in a namespace to begin with
// TODO: TBD: strong likelihood that yes, we should...

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_onGarrisoning_debug)
    || (_namespace getVariable [QMVAR(_onGarrisoning_debug), false]);

[
    _namespace getVariable [Q(KPLIB_sectors_markerName), ""]
    , _namespace getVariable [Q(KPLIB_sectors_blufor), false]
    , _namespace getVariable [Q(KPLIB_sectors_opfor), false]
    , [_namespace, KPLIB_sectors_status_garrisoning, Q(KPLIB_sectors_status)] call KPLIB_fnc_namespace_checkStatus
    , [_namespace, KPLIB_sectors_status_garrisoned, Q(KPLIB_sectors_status)] call KPLIB_fnc_namespace_checkStatus
] params [
    Q(_markerName)
    , Q(_blufor)
    , Q(_opfor)
    , Q(_garrisoning)
    , Q(_garrisoned)
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Entering: [_markerName, markerText _markerName, _blufor, _opfor, _garrisoning, _garrisoned]: %1"
        , str [_markerName, markerText _markerName, _blufor, _opfor, _garrisoning, _garrisoned]], "GARRISON", true] call KPLIB_fnc_common_log;
};

if (!_garrisoning || _garrisoned) exitWith {
    if (_debug) then {
        ["[fn_garrison_onGarrisoning] Not garrisoning or already garrisoned", "GARRISON", true] call KPLIB_fnc_common_log;
    };
    false;
};

// GARRISON status flags have already been established
private _selectedGarrisons = [
    [_blufor    , { [_namespace] call MFUNC(_getBluforGarrison); }  ]
    , [ _opfor  , { [_namespace] call MFUNC(_getOpforGarrison); }   ]
] select { (_x#0); };

// We get the FIRST one allowing for a DEFAULT EMPTY case
_selectedGarrisons params [
    [Q(_garrisonPair), [], [[]]]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Invoking callback: [_markerName, markerText _markerName, count _selectedGarrisons]: %1"
        , str [_markerName, markerText _markerName, count _selectedGarrisons]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_garrisonPair params [
    [Q(_predicate), true, [true]]
    , [Q(_getGarrisonCallback), {[]}, [{}]]
];

private _garrison = [] call _getGarrisonCallback;

_namespace setVariable [QMVAR(_garrison), _garrison];

_garrison params [
    [Q(_groupedUnitClassNames), [], [[]]]
    , [Q(_lightVehicleClassNames), [], [[]]]
    , [Q(_heavyVehicleClassNames), [], [[]]]
    , [Q(_intelClassNames), [], [[]]]
    , [Q(_iedsClassNames), [], [[]]]
    , [Q(_resourceClassNames), [], [[]]]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoning] Garrisoning: [_markerName, markerText _markerName, count _garrison, count _groupedUnitClassNames, count _lightVehicleClassNames, count _heavyVehicleClassNames, count _intelClassNames, count _iedsClassNames, count _resourceClassNames]: %1"
        , str [_markerName, markerText _markerName, count _garrison, count _groupedUnitClassNames, count _lightVehicleClassNames, count _heavyVehicleClassNames, count _intelClassNames, count _iedsClassNames, count _resourceClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _garrisonCallbacks = [
    [_resourceClassNames, MFUNC(_onGarrisoningSpawnResources)]
    , [_iedsClassNames, MFUNC(_onGarrisoningSpawnIeds)]
    , [_intelClassNames, MFUNC(_onGarrisoningSpawnIntel)]
    , [_groupedUnitClassNames, MFUNC(_onGarrisoningSpawnUnits)]
    , [_lightVehicleClassNames, MFUNC(_onGarrisoningSpawnLightVehicles)]
    , [_heavyVehicleClassNames, MFUNC(_onGarrisoningSpawnHeavyVehicles)]
];

private _garrisonedObjs = _garrisonCallbacks apply {
    _x params [
        [Q(_classNames), [], [[]]]
        , [Q(_callback), {[]}, [{}]]
    ];
    [_namespace, _classNames] call _callback;
};

_garrisonedObjs params [
    Q(_resourceObjs)
    , Q(_iedObjs)
    , Q(_intelObjs)
    , Q(_unitObjs)
    , Q(_lightVehicleObjs)
    , Q(_heavyVehicleObjs)
];
// TODO: TBD: do something with the objects, set them on the name space, etc...

if (_debug) then {
    ["[fn_garrison_onGarrisoning] Fini", "GARRISON", true] call KPLIB_fnc_common_log;
};

true;
