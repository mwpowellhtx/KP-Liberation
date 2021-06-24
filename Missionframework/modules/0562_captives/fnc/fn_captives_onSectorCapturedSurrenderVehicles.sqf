#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSectorCapturedSurrenderVehicles

    File: fn_captives_onSectorCapturedSurrenderVehicles.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 13:40:05
    Last Update: 2021-06-14 17:20:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Here we identify the ENEMY VEHICLES within CAPTURE range of the SECTOR
        for potential SURRENDER. We also separate the vehicles into LIGHT VEHICLE,
        HEAVY VEHICLE, or APC buckets, each with their own BIASES, etc. When we
        determine that a vehicle should be surrendered, then we defer to the ONE
        callback to handle the particulars for each of the candidate vehicles.

        Everything else being equal, we shall expect sector arrays to have been
        updated, and 'KPLIB_captured' flag set on the sector itself. But more
        importantly, we expect there to have been a SIDE ON ACTIVATION, which
        allows us to gauge how we should be responding here, regardless of the
        current sector alignment.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/crew
        https://community.bistudio.com/wiki/deleteVehicle
        https://community.bistudio.com/wiki/deleteVehicleCrew
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCapturedSurrenderVehicles_debug)
    || (_sector getVariable [QMVAR(_onSectorCapturedSurrenderVehicles_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _captured = _sector getVariable [Q(KPLIB_sectors_captured), false];
private _sideOnActivation = _sector getVariable [Q(KPLIB_sectors_sideOnActivation), sideEmpty];

if (_debug) then {
    [format ["[fn_captives_onSectorCapturedSurrenderVehicles] Entering: [_markerName, markerText _markerName, _captured, _sideOnActivation]: %1"
        , str [_markerName, markerText _markerName, _captured, _sideOnActivation]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

// Nothing to do when sector neither CAPTURED nor to BLUFOR
if (!(_sideOnActivation == KPLIB_preset_sideE || _captured)) exitWith {
    false;
};

private _actVehiclesE = _sector getVariable [Q(KPLIB_sectors_actVehiclesE), []];
private _ratioBundle = _sector getVariable [Q(KPLIB_garrison_ratioBundle), []];

_ratioBundle params [
    Q(_0) // _civRepRatio
    , [Q(_opforStrengthRatio), 0, [0]]
    , Q(_2) // _opforAwarenessRatio
    , [Q(_bluforStrengthRatio), 0, [0]]
];

// TODO: TBD: there are probably better ways to gauge this one...
private _threshold = PCT(MPARAM(_assetSurrenderThreshold));
private _coefficient = [_bluforStrengthRatio, 1 - _opforStrengthRatio] call BIS_fnc_arithmeticMean;

if (_debug) then {
    [format ["[fn_captives_onSectorCapturedSurrenderVehicles] Entering: [_threshold, _coefficient, _bluforStrengthRatio, _opforStrengthRatio]: %1"
        , str [_threshold, _coefficient, _bluforStrengthRatio, _opforStrengthRatio]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

private _index = 0;
{
    _x params [
        [Q(_bias), 0, [0]]
        , [Q(_vehicles), [], [[]]]
    ];

    private _chances = [];
    private _biasedThreshold = (_coefficient * _threshold) - _bias;

    private _vehiclesToSurrender = _vehicles select {
        _chances = [random 1] + _chances;
        (_chances#0) >= _biasedThreshold;
    };

    if (_debug) then {
        [format ["[fn_captives_onSectorCapturedSurrenderVehicles::forEach] Entering: [_index, _chances, _biasedThreshold, _bias, count _vehicles, count _vehiclesToSurrender]: %1"
            , str [_index, _chances, _biasedThreshold, _bias, count _vehicles, count _vehiclesToSurrender]], "CAPTIVES", true] call KPLIB_fnc_common_log;
    };

    _vehiclesToSurrender apply { [_x] call MFUNC(_onSurrenderVehicleOne); };
    _index = _index + 1;

} forEach [
    [
        PCT(MPARAM(_opforLightVehicleSurrenderBias))
        , _actVehicles select { alive _x && typeOf _x in KPLIB_preset_vehLightArmedPlE; }
    ]
    , [
        PCT(MPARAM(_opforHeavyVehicleSurrenderBias))
        , _actVehicles select { alive _x && typeOf _x in KPLIB_preset_vehHeavyPlE; }
    ]
    , [
        PCT(MPARAM(_opforApcSurrenderBias))
        , _actVehicles select { alive _x && typeOf _x in KPLIB_preset_vehHeavyApcPlE; }
    ]
];

if (_debug) then {
    ["[fn_captives_onSectorCapturedSurrenderVehicles] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
