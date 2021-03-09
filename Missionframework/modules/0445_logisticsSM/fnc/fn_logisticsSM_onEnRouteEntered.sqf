/*
    KPLIB_fnc_logisticsSM_onEnRouteEntered

    File: fn_logisticsSM_onEnRouteEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 17:00:45
    Last Update: 2021-03-07 12:28:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Evaluates the current approximate position, actual road position and
        direction, and proximity near enemy controlled sectors. May result in
        a route blockage when traveling toward enemy controlled sectors. Additionally,
        evaulates arrival scenarios, whether to continue mission and UNLOAD, or that
        the next [BRAVO, ALPHA] mission may be CONFIRMED.

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]

    Returns:
        The callback has finished [ARRAY]
 */

// TODO: TBD: add logging, etc
private _debug = [
    [
        {KPLIB_param_logisticsSM_onEnRouteEntered_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

([_namespace, [
    ["KPLIB_logistics_timer", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_timer"
];

_timer params ["_duration", "_startTime", "_elapsedTime", "_timeRemaining"];

// TODO: TBD: planned for future... for now just let it pass through...
// TODO: TBD: evaluate approximate versus 'actual' road position/direction...
// TODO: TBD: and proximity to enemy controlled sectors re: blockage

// // TODO: TBD: departure/arrival might be a first class function after all, but for now...
// // TODO: TBD: however, probably unnecessary, simple comparisons with the TIMER seem adequate...
// private _windowSeconds = [_namespace] call KPLIB_fnc_logistics_calculateTransitWindow;
// _windowSeconds params ["_departure", "_arrival"];

// TODO: TBD: use window? or simple FOB range seconds? probably FOB range...
private _fobRangeSeconds = [] call KPLIB_fnc_logistics_calculateFobRangeSeconds;

[
    _elapsedTime <= _fobRangeSeconds
    , _timeRemaining <= _fobRangeSeconds
] params [
    "_departing"
    , "_arriving"
];

// TODO: TBD: is also the moment when we potentially evaluate for ambush, etc, maybe we do that in a transition...
// TODO: TBD: we would want to evaluate for blockage as well...
// Fully in transit, i.e. not within a FOB 'safe' range...
if (!(_departing || _arriving)) exitWith {
    // TODO: TBD: add logging
    private _continueMissionEnRoute = true;
    _continueMissionEnRoute;
};

// Signal the 'onTransition' event handler how to handle ARRIVAL...
if (_arriving) then {

    // TODO: TBD: should probably be calculating the same plan during the UNLOADING state...
    // Which also includes the ABORTING flag when necessary
    private _status = [_namespace] call KPLIB_fnc_logistics_calculateArrivalStatus;

    [_namespace, [
        ["KPLIB_logistics_status", _status]
    ]] call KPLIB_fnc_namespace_setVars;
};

true;
