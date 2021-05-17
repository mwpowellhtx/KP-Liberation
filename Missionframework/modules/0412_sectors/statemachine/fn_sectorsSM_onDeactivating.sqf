#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onDeactivating

    File: fn_sectorsSM_onDeactivating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 19:29:13
    Last Update: 2021-04-25 20:07:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        We handle these conditions incrementally.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_arrayShuffle
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onDeactivating_debug)
    || (_namespace getVariable [QMVARSM(_onDeactivating_debug), false]);

// Probably also need some comprehension whether the sector is captured, i.e. as to whether other bits may occur
[
    _namespace getVariable [QMVAR(_markerName), ""]
    , [_namespace] call MFUNC(_getSectorDeactivating)
] params [
    Q(_markerName)
    , Q(_canDeactivate)
];

if (_debug) then {
    [format ["[fn_sectorsSM_onDeactivating] Entering: [_markerName, markerText _markerName, _canDeactivate]: %1"
        , str [_markerName, markerText _markerName, _canDeactivate]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

// Which handles peeling off objects in a GARRISON or other specific manner
if (_canDeactivate) then {
    [MVAR(_deactivating), [_namespace, [Q(KPLIB_garrison_units), Q(KPLIB_garrison_assets)]]] call CBA_fnc_serverEvent;
};

// Remember we got 'here' BECAUSE timer elapsed and other conditions were met
[_namespace, MSTATUS(_deactivating), { !_canDeactivate; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;

// Verify which objects may remain
[
    _namespace getVariable [Q(KPLIB_garrison_units), []]
    , _namespace getVariable [Q(KPLIB_garrison_assets), []]
] params [
    Q(_units)
    , Q(_assets)
];

[_namespace, MSTATUS(_active), { _canDeactivate && (_units + _assets) isEqualTo []; }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;

if (_debug) then {
    [format ["[fn_sectorsSM_onDeactivating] Fini: [_canDeactivate, count _units, count _assets]: %1"
        , str [_canDeactivate, count _units, count _assets]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
