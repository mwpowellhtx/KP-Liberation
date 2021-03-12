/*
    KPLIB_fnc_logisticsMgr_ctrlMap_onReloadEnRoute

    File: fn_logisticsMgr_ctrlMap_onReloadEnRoute.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-10 09:21:06
    Last Update: 2021-03-10 09:21:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _ctrlMap - [CONTROL, default: controlNull]
        _timer - the timer to consider [ARRAY, default: []]
        _alpha - the ALPHA ENDPOINT to consider [ARRAY, default: []]
        _bravo - the BRAVO ENDPOINT to consider [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/getDir
        https://community.bistudio.com/wiki/getPos
 */

private _transportSpeedMps = [] call KPLIB_fnc_logistics_calculateTransportSpeedMps;

// TODO: TBD: really should refactor this calculation, except for the fact that it is client side, tuples oriented, etc...
// TODO: TBD: versus server side where calculation should be namespace oriented...
params [
    ["_ctrlMap", controlNull, [controlNull]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
    , ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
];

_timer params [
    ["_duration", KPLIB_timers_disabled, [0]]
    , ["_startTime", 0, [0]]
    , ["_elapsedTime", 0, [0]]
];

_alpha params [
    ["_alphaPos", +KPLIB_zeroPos, [[]], 3]
];

_bravo params [
    ["_bravoPos", +KPLIB_zeroPos, [[]], 3]
];

private _targetDir = _alphaPos getDir _bravoPos;

// TODO: TBD: we'll start here, and really this much could be a logistics API...
private _estimatedPos = _alphaPos getPos [(_elapsedTime * _transportSpeedMps), _targetDir];

private _markerName = KPLIB_logisticsMgr_markerName;

[_markerName, _estimatedPos, KPLIB_logisticsMgr_enRouteClassName] call KPLIB_fnc_markers_create;

if (_targetDir != (markerDir _markerName)) then {
    _markerName setMarkerDirLocal _targetDir;
};

_estimatedPos;
