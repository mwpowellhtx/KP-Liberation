#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getCivResRatio

    File: fn_sectors_getCivResRatio.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 15:04:49
    Last Update: 2021-06-14 16:50:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Calculates either the RATIO or the component [DIVIDEND, DIVISOR] bits for
        CIVILIAN+RESISTANCE. There is not much to decided here other than that.
        POSITIVE ratio means there is CIVILIAN presence, whereas NEGATIVE ratio
        means there is no CIVILIAN presence. May be ZERO when there are no CIVILIAN
        nor RESISTANCE units present whatsoever.

        When there is greater CIVILIAN presence, then DIVIDEND will be POSITIVE.
        However, when there is greater RESISTANCE presence, then the DIVIDEND will
        be NEGATIVE. This is so that notifications, and client side HUD elements,
        may respond qualitatively, and adjust PROGRESS BARS, colors, ratios, etc,
        accordingly.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _ratio - whether to respond with the RATIO (true) or components (false) [BOOL, default: true]

    Returns:
        One of two possible values, either a RATIO, or the ratio COMPONENTS
            - RATIO [SCALAR]
            - [DIVIDEND, DIVISOR] [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_ratio), true, [true]]
];

private _debug = MPARAM(_getCivResRatio_debug)
    || (_sector getVariable [QMVAR(_getCivResRatio_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    // TODO: TBD: logging...
};

private [Q(_retval)];
private _components = [-1, -1];

if (_debug) then {
    // TODO: TBD: logging...
};

([QMVAR(_capUnitCountC), QMVAR(_capCivResDivisor)] apply { _sector getVariable _x; }) params [
    [Q(_capUnitCountC), 0, [0]]
    , [Q(_capUnitCountR), 0, [0]]
    , [Q(_capCivResDivisor), MPRESET(_minRatioDivisor), [0]]
];

/* CIVILIAN units always receive preference when arranging the dividends.
 * Also, avert DBZ errors calculating the RATIO.
 */
_component = [
    // This is not quite a MIN function, but it could be...
    if (_capUnitCountC >= _capUnitCountR) then { _capUnitCountC; } else { -_capUnitCountR; }
    //                                                                    -^^^^^^^^^^^^^^
    , MPRESET(_minRatioDivisor) max _capCivResDivisor
];

if (_debug) then {
    // TODO: TBD: logging...
};

if (!_ratio) exitWith {
    if (_debug) then {
        // TODO: TBD: log components...
    };
    _components;
};

_retval = (_components#0) / (_components#1);

if (_debug) then {
    // TODO: TBD: logging...
};

_retval;
