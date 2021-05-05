#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getOpforGarrison

    File: fn_garrison_getOpforGarrison.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-01 15:58:17
    Last Update: 2021-05-05 14:12:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the OPFOR GARRISON for the requested CBA SECTOR namespace. The approach
        here is opposite that of BLUFOR. With BLUFOR we maintain GARRISON specs, whereas
        with OPFOR we originate the specs starting with COUNT calculations.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The OPFOR GARRISON arrays [ARRAY]
 */

private _defaultSectorType = Q(metropolis);

// TODO: TBD: for now assuming "sector namespace"...
// TODO: TBD: however, 'garrison' could just as easily serve the needs of missions, i.e. S+R, etc...
params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAM(_getOpforGarrison_debug)
    || (_namespace getVariable [QMVAR(_getOpforGarrison_debug), false]);

private _markerName = _namespace getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    [format ["[fn_garrison_getOpforGarrison] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// Remember GRP COUNT shall have already been properly normalized
([_namespace] call MFUNC(_getOpforSectorCounts)) params [
    [Q(_unitCount), 0, [0]]
    , [Q(_grpCount), 0, [0]]
    , [Q(_lightVehicleCount), 0, [0]]
    , [Q(_heavyVehicleCount), 0, [0]]
    , [Q(_intelCount), 0, [0]]
    , [Q(_iedCount), 0, [0]]
    , [Q(_resourceCount), 0, [0]]
];

if (_debug) then {
    [format ["[fn_garrison_getOpforGarrison] Counts: [_markerName, markerText _markerName, [_unitCount, _grpCount, _lightVehicleCount, _heavyVehicleCount, _intelCount, _iedCount, _resourceCount]]: %1"
        , str [_markerName, markerText _markerName, [_unitCount, _grpCount, _lightVehicleCount, _heavyVehicleCount, _intelCount, _iedCount, _resourceCount]]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _side = [_namespace] call KPLIB_fnc_sectors_getSide;
private _presetUnitClassNames = ([_side] call KPLIB_fnc_common_getSoldierArray) call BIS_fnc_arrayShuffle;

// Set aside the class names that will inform the garrison specification
private _presetLightVehicleClassNames = +KPLIB_preset_vehLightArmedPlE;

if ([_namespace] call MFUNC(_shouldGarrisonApcs)) then {
    _presetLightVehicleClassNames append KPLIB_preset_vehHeavyApcPlE;
};

private _presetHeavyVehicleClassNames = +KPLIB_preset_vehHeavyPlE;
private _presetIntelClassNames = +KPLIB_preset_resources_intelClassNames;
// TODO: TBD: be prepared to refactor to IED module...
private _presetIedClassNames = +MPRESET(_iedClassNames);
// TODO: TBD: 'F' or 'E'?
private _presetResourceClassNames = +KPLIB_resources_crateClassesF;

if (_debug) then {
    [format ["[fn_garrison_getOpforGarrison] Presets: [_markerName, markerText _markerName, _side, count _presetUnitClassNames, _presetUnitClassNames]: %1"
        , str [_markerName, markerText _markerName, _side, count _presetUnitClassNames, _presetUnitClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

/* Create the INTEL which will serve as a DEFEND objective. Increasing levels of ENEMY
 * AWARENESS also means not only fewer INTEL opportunities, but also increasingly
 * stringent opportunities when they do occur. The opposite is also true when ENEMY
 * AWARENESS is weak, the are more opportunities, and more rewarding opportunities
 * when they do occur. This is to model that the ENEMY is more disciplined when they
 * are more aware, and less so when they are less aware. */

// TODO: TBD: may tweak the class selection filter, for now selecting random...
private _garrison = [
    [_unitCount, _presetUnitClassNames]
    , [_lightVehicleCount, _presetLightVehicleClassNames]
    , [_heavyVehicleCount, _presetHeavyVehicleClassNames]
    , [_intelCount, _presetIntelClassNames]
    , [_iedCount, _presetIedClassNames]
    , [_resourceCount, _presetResourceClassNames]
] apply {
    _x params [
        [Q(_count), 0, [0]]
        , [Q(_classNames), [], [[]]]
    ];
    private _retval = [];
    if (_count == 0) then { _retval; } else {
        _retval resize _count;
        _retval apply { selectRandom _classNames; };
    };
};

_garrison params [
    Q(_unitClassNames)
    , Q(_lightVehicleClassNames)
    , Q(_heavyVehicleClassNames)
    , Q(_intelClassNames)
    , Q(_iedClassNames)
    , Q(_resourceClassNames)
];

if (_debug) then {
    {
        _x params [
            Q(_variableName)
            , Q(_value)
        ];
        [format ["[fn_garrison_getOpforGarrison] Class names: [_markerName, markerText _markerName, %1]: %2"
            , _variableName, str [_markerName, markerText _markerName, _value]], "GARRISON", true] call KPLIB_fnc_common_log;
    } forEach [
        [Q(_unitClassNames), _unitClassNames]
        , [Q(_lightVehicleClassNames), _lightVehicleClassNames]
        , [Q(_heavyVehicleClassNames), _heavyVehicleClassNames]
        , [Q(_intelClassNames), _intelClassNames]
        , [Q(_iedClassNames), _iedClassNames]
        , [Q(_resourceClassNames), _resourceClassNames]
    ];
};

// Apportion the UNITS GARRISON according to the UNITS PER GRP
private _newUnitsGarrison = [+(_garrison#0), floor (_unitCount / _grpCount)] call {
    params [
        [Q(_classNames), [], [[]]]
        , [Q(_unitsPerGrp), 0, [0]]
    ];
    private _retval = [];
    while { count _classNames > 0; } do {
        private _view = _classNames select [0, (count _classNames) min _unitsPerGrp];
        _classNames = _classNames select [count _view, (count _classNames) - (count _view)];
        _retval pushBack _view;
    };
    _retval;
};

[format ["[fn_garrison_getOpforGarrison] Class names: [_markerName, markerText _markerName, %1]: %2"
    , Q(_newUnitsGarrison), str [_markerName, markerText _markerName, _newUnitsGarrison]], "GARRISON", true] call KPLIB_fnc_common_log;

// And replace the APPORTIONED UNITS in the GARRISON
_garrison set [0, _newUnitsGarrison];

if (_debug) then {
    [format ["[fn_garrison_getOpforGarrison] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "GARRISON", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: fill in the gap with created garrison...
_garrison;
