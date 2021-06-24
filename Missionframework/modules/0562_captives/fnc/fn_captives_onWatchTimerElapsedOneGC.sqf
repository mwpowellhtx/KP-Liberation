#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onWatchTimerElapsedOneGC

    File: fn_captives_onWatchTimerElapsedOneGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 09:56:37
    Last Update: 2021-06-20 09:59:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Watches a single UNIT after having been identified as 'KPLIB_surrender'.
        When the 'KPLIB_captives_timer' has elapsed, then we perform a GC on the
        unit, regardless of the CAPTIVES phase, SURRENDERED, CAPTURED, or INTERROGATED.

        When the CAPTIVES phase changes, of course, the timer should be reset. But that
        question is beyond the scope of this function, in particular.

    Parameter(s):
        _unit - a UNIT to consider [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    Remarks:
        Should never, ever, EVER run this code on the client side. The reason is we
        always want to refresh timers with regard to server oriented times. Client may
        have access to those times, but we shall not depend on that being the case.
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_onWatchTimerElapsedOneGC_debug)
    || (_unit getVariable [QMVAR(_onWatchTimerElapsedOneGC_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

// Timer SHOULD be installed, but it may not be
private _timer = _unit getVariable [QMVAR(_timer), []];

// Refresh and (re-)place the TIMER when it was actually installed
if (_timer isEqualTypeArray KPLIB_timers_default) then {
    private _refreshed = _timer call KPLIB_fnc_timers_refresh;
    _unit setVariable [QMVAR(_timer), _refreshed, true];
    _timer = _refreshed;
};

// TODO: TBD: may also monitor whether should switch sides depending on the phase
// TODO: TBD: whether the unit should capture vehicle
// TODO: TBD: so on and so forth...
if (_timer call KPLIB_fnc_timers_hasElapsed) then {
    deleteVehicle _unit;
};

if (_debug) then {
    // TODO: TBD: logging...
};

true;
