/*
    KPLIB_fnc_eden_callback_onWithinRange

    File: fn_callback_onWithinRange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-29 00:16:27
    Last Update: 2021-01-31 13:03:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:

    Parameters:
        _target - The _target object used to determine distance from the _eden [OBJECT, default: objNull]
        _dist2d - The calculated distance between the _target and the _eden [NUMBER, default: 0]
        _eden - The Eden tuple used to determine within range [ARRAY, default: []]

    Returns:
*/

params [
    ["_target", objNull, [objNull]]
    , ["_dist2d", 0, [0]]
    , ["_eden", [], [[]]]
];

_dist2d <= KPLIB_param_edenRange;
