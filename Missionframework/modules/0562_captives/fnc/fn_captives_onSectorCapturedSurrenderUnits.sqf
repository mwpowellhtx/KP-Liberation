#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSectorCapturedSurrenderUnits

    File: fn_captives_onSectorCapturedSurrenderUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 14:48:04
    Last Update: 2021-06-17 11:30:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Here we identify the ENEMY UNITS within CAPTURE range of the SECTOR for
        for potential SURRENDER. We use the UNIT BIAS for this purpose. When we
        determine that a unit should be surrendered, then we defer to the ONE
        callback to handle the particulars for each of the candidate units.

        Everything else being equal, we shall expect sector arrays to have been
        updated, and 'KPLIB_captured' flag set on the sector itself. But more
        importantly, we expect there to have been a SIDE ON ACTIVATION, which
        allows us to gauge how we should be responding here, regardless of the
        current sector alignment.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCapturedSurrenderUnits_debug)
    || (_sector getVariable [QMVAR(_onSectorCapturedSurrenderUnits_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _captured = _sector getVariable [Q(KPLIB_sectors_captured), false];
private _sideOnActivation = _sector getVariable [Q(KPLIB_sectors_sideOnActivation), sideEmpty];

if (_debug) then {
    [format ["[fn_captives_onSectorCapturedSurrenderUnits] Entering: [_markerName, markerText _markerName, _captured, _sideOnActivation]: %1"
        , str [_markerName, markerText _markerName, _captured, _sideOnActivation]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

if (!(_sideOnActivation == KPLIB_preset_sideE || _captured)) exitWith {
    false;
};

private _ratioBundle = _sector getVariable [Q(KPLIB_garrison_ratioBundle), []];

_ratioBundle params [
    Q(_0) // _civRepRatio
    , [Q(_opforStrengthRatio), 0, [0]]
    , Q(_2) // _opforAwarenessRatio
    , [Q(_bluforStrengthRatio), 0, [0]]
];

// TODO: TBD: there are probably better ways to gauge this one...
// TODO: TBD: the pattern here is also very similar to that of VEHICLES, so we might consider combining the two...
private _threshold = PCT(MPARAM(_unitSurrenderThreshold));
private _coefficient = [_bluforStrengthRatio, 1 - _opforStrengthRatio] call BIS_fnc_arithmeticMean;

private _capUnitsE = _sector getVariable [Q(KPLIB_sectors_capUnitsE), []];

if (_debug) then {
    [format ["[fn_captives_onSectorCapturedSurrenderUnits] Entering: [_threshold, _coefficient, _bluforStrengthRatio, _opforStrengthRatio]: %1"
        , str [_threshold, _coefficient, _bluforStrengthRatio, _opforStrengthRatio]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

/* Potentially SURRENDER UNITS which are ALIVE and which are also NOT in a vehicle.
 * Units under these circumstances SHOULD be free standing, but I suppose they may
 * potentially NOT be.
 */
private _index = 0;
{
    _x params [
        [Q(_bias), 0, [0]]
        , [Q(_units), [], [[]]]
    ];

    private _chances = [];
    private _biasedThreshold = (_coefficient * _threshold) - _bias;

    // This is key, UNITS apart from VEHICLES are to be considered
    private _unitsToSurrender = _units select {
        _chances = [random 1] + _chances;
        (_chances#0) >= _biasedThreshold;
    };

    if (_debug) then {
        [format ["[fn_captives_onSectorCapturedSurrenderUnits::forEach] Entering: [_index, _chances, _biasedThreshold, _bias, count _units, count _unitsToSurrender]: %1"
            , str [_index, _chances, _biasedThreshold, _bias, count _units, count _unitsToSurrender]], "CAPTIVES", true] call KPLIB_fnc_common_log;
    };

    _unitsToSurrender apply { [_x] call MFUNC(_onSurrenderUnitOne); };
    _index = _index + 1;

} forEach [
    [
        PCT(MPARAM(_unitSurrenderBias))
        , _capUnitsE select {
            alive _x
                && isNull objectParent _x
                && !(_x getVariable [Q(KPLIB_surrender), false])
                ;
        }
    ]
];

if (_debug) then {
    ["[fn_captives_onSectorCapturedSurrenderUnits] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
