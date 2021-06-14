#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_canActivate

    File: fn_sectors_canActivate.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-29 23:19:21
    Last Update: 2021-06-14 16:49:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether a CBA SECTOR namespace CAN ACTIVATE. Basically whereby
        there are qualifying BLUFOR or non-GARRISONED or REINFORCING units.
        Any other units are considerd unqualified to activate a sector, or to
        keep it active for that matter. By extension may also be useful when
        determining whether an ACTIVE SECTOR shall begin DEACTIVATING.

        Whether to INCLUDE ACTIVE is critical because we ask the question when
        evaluating new batches of ACTIVATING SECTORS, as well as evaluating ACTIVE
        SECTORS whether they should deactivate.

    Parameter(s):
        _sector - a CBA SECTOR namespace to consider [LOCATION, default: locationNull]
        _includeActive - whether to INCLUDE ACTIVE when evaluating [BOOL, default: false]

    Returns:
        Whether a sector CAN ACTIVATE [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_includeActive), false, [false]]
];

private _debug = MPARAM(_canActivate_debug)
    || (_sector getVariable [QMVAR(_canActivate_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];
private _active = _sector in MVAR(_allActive);

if (_debug) then {
    [format ["[fn_sector_canActivate] Entering: [_markerName, markerText _markerName, _active]: %1"
        , str [_markerName, markerText _markerName, _active]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Cannot RE-activate but only verify when asked to do so
if (_includeActive && _active) exitWith { false; };

private _nearestActDist = _sector getVariable [QMVAR(_nearestActDist), -1];

if (_debug) then {
    [format ["[fn_sector_canActivate] Fini: [_nearestActDist]: %1"
        , str [_nearestActDist]], "SECTORS", true] call KPLIB_fnc_common_log;
};

_nearestActDist >= 0;
