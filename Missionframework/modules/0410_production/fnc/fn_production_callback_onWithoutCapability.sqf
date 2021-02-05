/*
    KPLIB_fnc_production_callback_onWithoutCapability

    File: fn_production_callback_onWithoutCapability.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 01:15:55
    Last Update: 2021-02-05 01:15:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the '_markerName' exists without an already added production capability.

    Parameter(s):
        _target - a target object to consider near the '_markerName', unused for purposes
            of this function [OBJECT, default: player]
        _range - the range about which to consider near the '_markerName', unused for purposes
            of this callback function [SCALAR, default: 0]
        _markerName - the marker name at which to consider [STRING, default: ""]
        _args - arguments specifying the target production capability [ARRAY, default: [0]]

    Returns:
        Whether there is not already target production capability at the '_markerName' site [BOOL]
*/

if (isNil "KPLIB_production") exitWith {false};

params [
    ["_target", player, [objNull]]
    , ["_range", 0, [0]]
    , ["_markerName", "", [""]]
    , ["_args", [0], [[]], 1]
];

_args params [
    ["_cap", 0, [0]]
];

private _matched = KPLIB_production select { ((_x#0#0) isEqualTo _markerName) && ((_x#2#0) select _cap); };
//                           1. _markerName:   ^^^^^^
//                           2.        _cap:                                      ^^^^^^^^^^^^^^^^^^^^

// Not build already will not match any of the tuples.
_matched isEqualTo [];
