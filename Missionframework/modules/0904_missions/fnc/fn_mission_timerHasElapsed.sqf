// Ditto similar includes re: macro abstractions
#include "script_component.hpp"
/*
    KPLIB_fnc_mission_timerHasElapsed

    File: fn_mission_timerHasElapsed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 02:17:26
    Last Update: 2021-03-20 02:17:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the TARGET MISSION timer has elapsed.

    Parameter(s):
        _target - a CBA MISSION namespace [LOCATION, default: locationNull], or:
            a TIMER tuple [ARRAY]

    Returns:
        Whether the TARGET MISSION or actual TIMER has elapsed [ARRAY]
 */

[
    MSTATUS1(_standby)
    , +KPLIB_timers_default
] params [
    Q(_standby)
    , _defaultTimer
];

// TODO: TBD: this is where we are slightly different from "logistics"...
// TODO: TBD: in other words, meaning that "array" is not a "mission tuple", we do not know what that is, per se...
// TODO: TBD: rather we think that this should refer to "target timer" itself...
params [
    [Q(_target), locationNull, [[], locationNull]]
];

private _hasTupleTimerElapsed = {
    params [
        [Q(_target), _defaultTimer, [[]], 4]
    ];
    _target call KPLIB_fnc_timers_hasElapsed;
};

private _hasNamespaceTimerElapsed = {
    params [
        [Q(_target), locationNull, [locationNull]]
    ];

    ([_target, [
        [QMVAR1(_timer), _defaultTimer]
    ]] call KPLIB_fnc_namespace_getVars) params [
        Q(_timer)
    ];

    [[_timer]] call _hasTupleTimerElapsed;
};

switch (true) do {

    case (_target isEqualType []): {
        [_target] call _hasTupleTimerElapsed;
    };

    case (_target isEqualType locationNull): {
        [_target] call _hasNamespaceTimerElapsed;
    };

    default { false; };
};
