/*
    KPLIB_fnc_core_fob_callback_onWithinRange

    File: fn_core_fob_callback_onWithinRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-31 13:00:08
    Last Update: 2021-05-17 20:25:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameters:
        _target - The _target object used to determine distance from the _fob [OBJECT, default: objNull]
        _dist2d - The calculated distance between the _target and the _fob [NUMBER, default: 0]
        _fob - The FOB tuple used to determine within range [ARRAY, default: []]

    Returns:
*/

// TODO: TBD: may do further quality checks on the _fob tuple...

params [
    ["_target", objNull, [objNull]]
    , ["_dist2d", 0, [0]]
    , ["_fob", [], [[]]]
];

_dist2d <= KPLIB_param_fobs_range;
