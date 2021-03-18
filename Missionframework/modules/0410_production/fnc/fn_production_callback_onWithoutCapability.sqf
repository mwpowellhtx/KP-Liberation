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
        _targetMarkerName - the '_target' marker name at which to consider [STRING, default: ""]
        _args - arguments specifying the target production capability [ARRAY, default: [0]]

    Returns:
        Whether there is not already target production capability at the '_markerName' site [BOOL]
*/

if (isNil "KPLIB_production_namespaces") exitWith {
    false;
};

params [
    ["_target", player, [objNull]]
    , ["_range", 0, [0]]
    , ["_targetMarkerName", "", [""]]
    , ["_args", [0], [[]], 1]
];

_args params [
    ["_targetCap", 0, [0]]
];

// Expecting these to be CBA namespaces...
private _matched = KPLIB_production_namespaces select {
    private _markerName = _x getVariable ["KPLIB_production_markerName", KPLIB_production_markerNameDefault];
    private _capability = +(_x getVariable ["KPLIB_production_capability", KPLIB_resources_capDefault]);
    (_markerName isEqualTo _targetMarkerName) && (_capability#_targetCap);
};

// Not build already will not match any of the tuples
_matched isEqualTo [];
