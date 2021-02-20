/*
    KPLIB_fnc_productionsm_onProducerLeaving

    File: fn_productionsm_onProducerLeaving.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-18 00:11:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The CBA production statemachine 'Produce' 'onStateLeaving' callback. Specifically,
        allows for continual production cycles to operate by optionally enqueueing the
        '_lastResource' produced.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        NONE
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_onProducerLeaving] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (true) exitWith {
    if (_debug) then {
        [format ["[fn_productionsm_onProducerLeaving] For future use: [_markerName]: %1"
            , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    true;
};

// TODO: TBD: do not care about a "last resource" as long as we have a queue and previous queue to compare and contrast
private _queue = _namespace getVariable ["_queue", []];
private _lastResource = _namespace getVariable ["_lastResource", -1];

if ((_queue isEqualTo [])
    && (_lastResource in KPLIB_resources_indexes)
    && KPLIB_param_production_rescheduleLastResource) then {

    _namespace setVariable ["_queue", [_lastResource]];
};

_namespace setVariable ["_lastResource", nil];

if (_debug) then {
    ["[fn_productionsm_onProducerLeaving] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
