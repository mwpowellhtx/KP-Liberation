#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onDeactivatedTransition

    File: fn_sectorsSM_onDeactivatedTransition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-25 09:49:46
    Last Update: 2021-04-25 09:49:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The CBA SECTOR namespace is now considered fully DEACTIVATED, meaning sufficient
        GC has occurred, all timers have been fully resolved, and the sector may now fall
        back to STANDBY status. Instead of a 'deactivated' state, we decided it would be
        better for the natural, inert state to be considered IDLE.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onDeactivatedTransition_debug)
    || (_namespace getVariable [QMVARSM(_onDeactivatedTransition_debug), false]);

// Fully set the STATUS to STANDBY this is critical the sector must be completely reset
_namespace setVariable [QMVAR(_status), MSTATUS(_standby)];

// Remove timer along with STATUS
_namespace setVariable [QMVAR(_timer), nil];

// Should have critical bits also emptied so should not be necessary to clear anything else

true;
