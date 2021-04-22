#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onDeactivatedEntered

    File: fn_sectorsSM_onDeactivatedEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 20:02:11
    Last Update: 2021-04-21 20:02:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The CBA SECTOR namespace is now considered fully DEACTIVATED, meaning sufficient
        GC has occurred, all timers have been fully resolved, and the sector may now fall
        back to STANDBY status.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAMSM(_onDeactivatedEntered_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

_namespace setVariable [QMVAR(_timer), nil];
_namespace setVariable [QMVAR(_status), MSTATUS(_standby)];

true;
