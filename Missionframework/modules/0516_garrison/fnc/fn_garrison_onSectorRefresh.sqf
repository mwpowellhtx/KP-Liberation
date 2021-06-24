#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorRefresh

    File: fn_garrison_onSectorRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 09:17:59
    Last Update: 2021-06-24 12:47:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the RATIO BUNDLE for the SECTOR available for use during the next
        iteration for whatever is happening in the sector. First, this saves us having
        to invoke the bundle calculation in multiple places. Second, we have a more
        consistent readily available source of truth, the SECTOR, available when we
        want to respond to the next life cycle event.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorRefresh_debug)
    || (_sector getVariable [QMVAR(_onSectorRefresh_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    // TODO: TBD: logging...
};

_sector setVariable [QMVAR(_ratioBundle), [] call MFUNC(_getRatioBundle)];

if (_debug) then {
    // TODO: TBD: logging...
};

true;
