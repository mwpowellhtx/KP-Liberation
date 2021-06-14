#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_canCaptureEval

    File: fn_sectors_canCaptureEval.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-14 07:34:03
    Last Update: 2021-06-14 16:49:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _sector - a CBA SECTOR namespace to consider [LOCATION, default: locationNull]
        _divisor - a DIVISOR to consider [SCALAR, default: 0]
        _dividend - a DIVIDEND to consider [SCALAR, default: 0]
        _divisorOffset - an OFFSET to consider [SCALAR, default: 0]
        _dividendOffset - an OFFSET to consider [SCALAR, default: 0]
        _ratioBias - a RATIO BIAS to consider [SCALAR, default: 0]
        _threshold - a THRESHOLD to consider [SCALAR, default: 0]

    Returns:
        Whether a sector CAN CAPTURE [BOOL]

    References:
        https://community.bistudio.com/wiki/try
        https://community.bistudio.com/wiki/catch
        https://community.bistudio.com/wiki/throw
        https://community.bistudio.com/wiki/Exception_handling
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_dividend), 0, [0]]
    , [Q(_divisor), 0, [0]]
    , [Q(_dividendOffset), 0, [0]]
    , [Q(_divisorOffset), 0, [0]]
    , [Q(_ratioBias), 0, [0]]
    , [Q(_threshold), 0, [0]]
];

private _debug = MPARAM(_canCaptureEval_debug)
    || (_sector getVariable [QMVAR(_canCaptureEval_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sector_canCaptureEval] Entering: [_markerName, markerText _markerName, _dividend, _divisor, _dividendOffset, _divisorOffset]: %1"
        , str [_markerName, markerText _markerName, _dividend, _divisor, _dividendOffset, _divisorOffset]], "SECTORS", true] call KPLIB_fnc_common_log;
};

private _dividendAdj = _dividend + _dividendOffset;
private _divisorAdj = _divisor + _divisorOffset;

/* Starting with a completely invalid RATIO, basically LONG_MIN:
 * https://cplusplus.com/reference/climits
 */
private _ratio = 0 - 0x8000;
private _ratioAdj = 0;

/* TRY CATCH in the event we do encounter any DBZ. Should not encounter
 * ZERO DIVISOR in this instance given the above THROW. MAY CAPTURE when
 * there is any ADJUSTED DIVIDEND.
 */
private _mayCap = try {
    if (_divisorAdj <= 0) then { throw _dividendAdj; };
    _ratio = _dividendAdj / _divisorAdj;
    _ratioAdj = _ratio + _ratioBias;
    _ratioAdj >= _threshold;
} catch {
    _exception > 0;
};

if (_debug) then {
    [format ["[fn_sector_canCaptureEval] Fini: [_mayCap, _divisorAdj, _dividendAdj, _ratio, _ratioBias, _ratioAdj, _threshold]: %1"
        , str [_mayCap, _divisorAdj, _dividendAdj, _ratio, _ratioBias, _ratioAdj, _threshold]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_mayCap;
