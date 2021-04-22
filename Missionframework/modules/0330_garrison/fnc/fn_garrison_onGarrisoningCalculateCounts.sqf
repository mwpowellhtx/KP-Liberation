#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningCalculateCounts

    File: fn_garrison_onGarrisoningCalculateCounts.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-17 22:59:21
    Last Update: 2021-04-21 11:23:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the GARRISON SPECIFICATION counts.

    Parameter(s):
        _grpArgs - GRP arguments bundle [ARRAY, default: []]
        _unitsArgs - UNITS arguments bundle [ARRAY, default: []]
        _lightVehicleArgs - LIGHT VEHICLE arguments bundle [ARRAY, default: []]
        _heavyVehicleArgs - HEAVY VEHICLE arguments bundle [ARRAY, default: []]

        Arguments are to be delivered in a bundle: [_min, _count, _ceil, _coef]

    Returns:
        The desired functional primitive [CODE]
 */

// TODO: TBD: we may include additional bias, throttle, etc, beyond the base arg bundles...
params [
    [Q(_grpArgs), [], [[]]]
    , [Q(_unitsArgs), [], [[]]]
    , [Q(_lightVehicleArgs), [], [[]]]
    , [Q(_heavyVehicleArgs), [], [[]]]
];

private _retval = [
    _grpArgs
    , _unitsArgs
    , _lightVehicleArgs
    , _heavyVehicleArgs
] apply {
    private _args = _x;
    _args call MFUNC(_onGarrisoningCalculateEachCount);
};

_retval;
