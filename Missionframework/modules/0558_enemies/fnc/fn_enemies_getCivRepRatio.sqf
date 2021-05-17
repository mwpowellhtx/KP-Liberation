#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_getCivRepRatio

    File: fn_enemies_getCivRepRatio.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-19 08:00:45
    Last Update: 2021-05-04 15:59:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the CIVILIAN REPUTATION expressed in terms of a RATIO. The raw value
        may be filtered prior to calculating this ratio.

    Parameter(s):
        _filterMaxRaw - a fitler through which to consider the RAW CIVILIAN REPUTATION
            [CODE, default: _defaultRawFilter]

    Returns:
        CIVILIAN REPUTATION in terms of ratio [SCALAR]
 */

private _debug = MPARAM(_getCivRepRatio_debug);
private _defaultRawFilter = { _this };

params [
    [Q(_filterRaw), _defaultRawFilter, [{}]]
];

[
    MVAR(_civRep) call _filterRaw
    , MPARAM(_maxCivRep)
] params [
    Q(_civRep)
    , Q(_maxCivRep)
];

private _civRepRatio = _civRep / _maxCivRep;

_civRepRatio;
