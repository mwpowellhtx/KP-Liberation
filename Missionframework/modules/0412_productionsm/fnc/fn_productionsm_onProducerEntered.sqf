/*
    KPLIB_fnc_productionsm_onProducerEntered

    File: fn_productionsm_onProducerEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-18 00:10:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The CBA production statemachine 'Produce' 'onStateEntering' callback. Specifically,
        arranges for resource production to land in the most available storage container. In the
        event there is production success, updates the '_queue' and reports the '_lastResource'
        produced.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        NONE
 */

private _debug = [["KPLIB_param_productionsm_producer_debug"]] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

// TODO: TBD: while we are debugging... we'll get there, but for now let's focus on the other SM bits...
if (true) exitWith {
    if (_debug) then {
        [format ["[fn_productionsm_onProducerEntered] For future use: [_markerName]: %1"
            , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };
    true;
};

// Although we may not expect more than one, let's do it this way...
private _factoryStorages = [_markerName] call KPLIB_fnc_resources_getFactoryStorages;

// No containers in which to store produced resources...
if (count _factoryStorages == 0) exitWith {
    false;
};

// Identify the least full storage container and use it...
private _spaceStorages = _factoryStorages apply { [[_x] call KPLIB_fnc_resources_getStorageSpace, _x]; };

private _openStorages = [_spaceStorages, [], { (_x#0); }, "DESCEND"] call BIS_fnc_sortBy;

private _targetStorage = (_openStorages deleteAt 0)#1;

_namespace setVariable ["_targetStorage", _targetStorage];

// TODO: TBD: do not think we care about any "last resources" as long as we have a queue and previousqueue to compare/contrast...
if (_namespace call KPLIB_fnc_productionsm_tryProduceResource) then {

    // Not expecting the default here...
    private _queue = _namespace getVariable ["_queue", []];
    private _lastResource = _queue deleteAt 0;
    _namespace setVariable ["_lastResource", _lastResource];
    _namespace setVariable ["_queue", +_queue];
};

if (_debug) then {
    ["[fn_productionsm_onProducerEntered] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
