#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorActivating

    File: fn_garrison_onSectorActivating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-12 15:37:53
    Last Update: 2021-06-14 17:12:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to the CBA SECTOR namespace 'KPLIB_sectors_activating' event.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorActivating_debug)
    || (_sector getVariable [QMVAR(_onSectorActivating_debug), false])
    ;

_sector setVariable [QMVAR(_regimentMap), nil];
_sector setVariable [QMVAR(_garrisonMap), nil];

true;
