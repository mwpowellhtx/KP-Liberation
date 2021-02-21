/*
    KPLIB_fnc_productionsm_isSecure

    File: fn_productionsm_isSecure.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 14:45:52
    Last Update: 2021-02-18 14:45:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the factory sector is considered secure.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        Whether the factory sector is considered secure [BOOL]
 */

private _debug = [
    [
        "KPLIB_param_productionsm_conditions_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_isSecure] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[
   _markerName in KPLIB_sectors_factory
   , _markerName in KPLIB_sectors_blufor
] params [
    "_isFactory"
    , "_isBlufor"
];

if (_debug) then {
    [format ["[fn_productionsm_isSecure] Finished: [_isFactory, _isBlufor]: %1"
        , str [_isFactory, _isBlufor]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

_isFactory && _isBlufor;
