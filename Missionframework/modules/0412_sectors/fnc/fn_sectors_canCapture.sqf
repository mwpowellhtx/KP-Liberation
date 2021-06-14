#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_canCapture

    File: fn_sectors_canCapture.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 13:19:21
    Last Update: 2021-06-14 16:49:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA SECTOR namespace CAN CAPTURE. CAPTURE is possible when
        there are UNITS within ACTIVATION DISTANCE, and when the UNIT+TANK CAPTURE RATIOS
        have been successfully achieved. There must be at least SOME UNITS in range of the
        sector, and the RATIO THRESHOLD achieved for capture to be possible. For tanks, it
        is a slightly different story. There may be no tanks within range, but when there
        are, that ratio threhsold must also be achieved.

    Parameter(s):
        _sector - a CBA SECTOR namespace to consider [LOCATION, default: locationNull]

    Returns:
        Whether a sector CAN CAPTURE [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_canCapture_debug)
    || (_sector getVariable [QMVAR(_canCapture_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];
private _blufor = _sector getVariable [QMVAR(_blufor), false];

private _active = _sector in MVAR(_allActive);
private _captured = _sector getVariable [Q(KPLIB_captured), false];

private _bluforOnActivation = [_sector getVariable [QMVAR(_sideOnActivation), KPLIB_preset_sideE]] call {
    (_this#0) == KPLIB_preset_sideF;
};

if (_debug) then {
    [format ["[fn_sector_canCapture] Entering: [_markerName, markerText _markerName, _active, _captured, _blufor, _bluforOnActivation]: %1"
        , str [_markerName, markerText _markerName, _active, _captured, _blufor, _bluforOnActivation]], "SECTORS", true] call KPLIB_fnc_common_log;
};

/* Rule out these early cases first, SECTOR:
 *      - inactive - should NOT be 'here', so preclude just in case
 *      - captured - MAY be here while already CAPTURED, so preclude that as well
 *      - alignment has not changed - ditto CAPTURED, preclude
 */
if (!_active || _captured) exitWith { false; };

// We will bundle a few CAN CAPTURE components according to SECTOR ALIGNMENT
[
    _sector getVariable [QMVAR(_nearestActDist), -1]
    , _sector getVariable [QMVAR(_capUnitsE), []]
    , _sector getVariable [QMVAR(_capUnitsF), []]
    , _sector getVariable [QMVAR(_capTanksE), []]
    , _sector getVariable [QMVAR(_capTanksF), []]
] params [
    Q(_nearestActDist)
    , Q(_capUnitsE)
    , Q(_capUnitsF)
    , Q(_capTanksE)
    , Q(_capTanksF)
];

if (_debug) then {
    [format ["[fn_sector_canCapture] Components: [_nearestActDist, count _capUnitsE, count _capUnitsF, count _capTanksE, count _capTanksF]: %1"
        , str [_nearestActDist, count _capUnitsE, count _capUnitsF, count _capTanksE, count _capTanksF]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// DIVISORS are the same in either event
private _unitDivisor = count (_capUnitsF + _capUnitsE);
private _tankDivisor = count (_capTanksF + _capTanksE);

// BUNDLE KEYS are also the local VARIABLE NAMES
private _bundleKeys = [
    Q(_unitDividend)
    , Q(_tankDividend)
    , Q(_unitDividendOffset)
    , Q(_unitDivisorOffset)
    , Q(_unitRatioBias)
    , Q(_unitThreshold)
    , Q(_tankDividendOffset)
    , Q(_tankDivisorOffset)
    , Q(_tankRatioBias)
    , Q(_tankThreshold)
];

// Select (OPFOR+)BLUFOR bundle values
private _bundleValues = [
    [
        count _capUnitsF
        , count _capTanksF
        , MPARAM(_capUnitDividendOffsetF)
        , MPARAM(_capUnitDivisorOffsetF)
        , PCT(MPARAM(_capUnitRatioBiasF))
        , PCT(MPARAM(_capUnitThresholdF))
        , MPARAM(_capTankDividendOffsetF)
        , MPARAM(_capTankDivisorOffsetF)
        , PCT(MPARAM(_capTankRatioBiasF))
        , PCT(MPARAM(_capTankThresholdF))
    ]
    , [
        count _capUnitsE
        , count _capTanksE
        , MPARAM(_capUnitDividendOffsetE)
        , MPARAM(_capUnitDivisorOffsetE)
        , PCT(MPARAM(_capUnitRatioBiasE))
        , PCT(MPARAM(_capUnitThresholdE))
        , MPARAM(_capTankDividendOffsetE)
        , MPARAM(_capTankDivisorOffsetE)
        , PCT(MPARAM(_capTankRatioBiasE))
        , PCT(MPARAM(_capTankThresholdE))
    ]
];

/* Stitch them together via HASHMAP and identify them to local scope as VARIABLES;
 * Remember the logic here is a bit 'opposite', meaning, having BLUFOR ON ACTIVATION
 * means that CAPTURE conditions depend on OPFOR presence to convert; and vice versa.
 * OPFOR (!BLUFOR) ON ACTIVATION depends on BLUFOR presence. OFFSETS and BIASES aligned
 * as such are also furnished. DIVISORS are always the same, regardless.
 */
private _bundleMap = _bundleKeys createHashMapFromArray (_bundleValues select _bluforOnActivation);

// Yields a BUNDLE of local variables in the shape of the BUNDLE KEYS (see above)
(_bundleKeys apply { _bundleMap get _x; }) params _bundleKeys;

if (_debug) then {
    [format ["[fn_sector_canCapture] Bundled: [_unitDividend, _unitDivisor, _unitDividendOffset, _unitDivisorOffset, _unitRatioBias, _unitThreshold]: %1"
        , str [_unitDividend, _unitDivisor, _unitDividendOffset, _unitDivisorOffset, _unitRatioBias, _unitThreshold]], "SECTORS", true] call KPLIB_fnc_common_log;
    [format ["[fn_sector_canCapture] Bundled: [_tankDividend, _tankDivisor, _tankDividendOffset, _tankDivisorOffset, _tankRatioBias, _tankThreshold]: %1"
        , str [_tankDividend, _tankDivisor, _tankDividendOffset, _tankDivisorOffset, _tankRatioBias, _tankThreshold]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _evaluation = [
    [
        _sector
        , _unitDividend
        , _unitDivisor
        , _unitDividendOffset
        , _unitDivisorOffset
        , _unitRatioBias
        , _unitThreshold
    ]
    , [
        _sector
        , _tankDividend
        , _tankDivisor
        , _tankDividendOffset
        , _tankDivisorOffset
        , _tankRatioBias
        , _tankThreshold
    ]
] apply {
    _x call MFUNC(_canCaptureEval);
};

_evaluation params [
    Q(_unitEval)
    , Q(_tankEval)
];

if (_debug) then {
    [format ["[fn_sector_canCapture] Fini: [_unitEval, _tankEval, _unitDivisor, _tankDivisor]: %1"
        , str [_unitEval, _tankEval, _unitDivisor, _tankDivisor]], "SECTORS", true] call KPLIB_fnc_common_log;
};

(_unitDivisor > 0 && _unitEval)
    && (
        _tankDivisor <= 0
            || (_tankDivisor > 0 && _tankEval)
    );
