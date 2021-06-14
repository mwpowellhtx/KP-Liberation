#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getCapRatio

    File: fn_sectors_getCapRatio.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 13:34:09
    Last Update: 2021-06-14 16:50:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Calculates either the CAPTURE RATIO or the component [DIVIDEND, DIVISOR] bits for
        KIND, which may either 'UNIT' or 'TANK', case insensitive. May be reported in RATIO
        form, or as consituent [DIVIDEND, DIVISOR] components.

        CBA settings may further calibrate the components and ratios accordingly with SIDE,
        KIND, and possibly also SECTOR TYPE specific modifiers.
            - dividend offset
            - dividend coefficient
            - divisor offset
            - divisor coefficient
            - ratio bias

        And are applied in the following manner:
            - actual dividend = 0 max ((dividend * coefficient) + offset)
            - actual divisor = (minimum divisor) max ((divisor * coefficient) + offset)
            - actual ratio = (dividend / divisor) + ratio bias

        Note that we normalize DIVISOR using a nominal MINIMUM DIVISOR in order to avert
        divide by zero (DBZ) errors. Clients should be aware of this when interpreting
        these ratios for purposes of presenting HUD elements.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        One of two possible values, either a RATIO, or the ratio COMPONENTS
            - RATIO [SCALAR]
            - [DIVIDEND, DIVISOR] [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_kind), MPRESET(_ratioKinds) select 0, [""]]
    , [Q(_ratio), true, [true]]
];

private _debug = MPARAM(_getCapRatio_debug)
    || (_sector getVariable [QMVAR(_getRatio_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    // TODO: TBD: logging...
};

private [Q(_retval)];
private _components = [-1, -1];

// Screen KIND in a case insensitive manner
if (MPRESET(_ratioKinds) findIf { _x == _kind; } < 0) exitWith {
    _retval = if (_ratio) then { _components#0; } else { _components; };

    if (_debug) then {
        // TODO: TBD: log retval
    };

    _retval;
};

// Assumes that REFRESH PROXIMITIES has properly aligned DIVIDENDS+DIVISORS
private _varNames = MPRESET(_ratioVarNameFormats) apply { format [_x, _kind]; };
(_varNames apply { _sector getVariable [_x, 0]; }) params [
    [Q(_dividend), -1, [0]]
    , [Q(_divisor), -1, [0]]
];

if (_debug) then {
    // TODO: TBD: log var names and values
};

// Acquire the modifiers aligned by SIDE+KIND+SECTOR
private _ratioVarNames = MPRESET(_ratioParamVarNameFormats) apply {
    private _side = if (_blufor) then { "blufor"; } else { "opfor"; };
    private _blufor = _sector getVariable [QMVAR(_blufor), false];
    format [_x, _side, _kind];
};
// Nominal default values are assumed when the settings are not there yet
_ratioVarNames apply { missionNamespace getVariable _x; } params [
    [Q(_dividendOffset), 0, [0]]
    , [Q(_divisorOffset), 0, [0]]
    , [Q(_dividendCoef), 1, [0]]
    , [Q(_divisorCoef), 1, [0]]
    , [Q(_ratioBias), 0, [0]]
];

if (_debug) then {
    // TODO: TBD: log var names and values
};

// Avoid DBZ errors in the DIVISOR without it actually reaching ZED
_components = [
    0 max ((_dividend * _dividendCoef) + _dividendOffset)
    , MPRESET(_minRatioDivisor) max ((_divisor * _divisorCoef) + _divisorOffset)
];

if (_debug) then {
    // TODO: TBD: log component values
};

if (!_ratio) exitWith {
    if (_debug) then {
        // TODO: TBD: log components
    };
    _components;
};

_retval = ((_components#0) / (_components#1)) + _ratioBias;

if (_debug) then {
    // TODO: TBD: log retval
};

_retval;
