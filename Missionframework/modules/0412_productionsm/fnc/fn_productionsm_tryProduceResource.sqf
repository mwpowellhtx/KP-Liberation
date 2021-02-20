/*
    KPLIB_fnc_productionsm_tryProduceResource

    File: fn_productionsm_tryProduceResource.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 14:06:08
    Last Update: 2021-02-18 14:06:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Tries to produce the next resource in the CBA production statemachine '_queue'.

    Parameter(s):
        _namespace - a CBA namespace objet [LOCATION, default: locationNull]

    Returns:
        Whether the resource was successfully produced and stored [BOOL]
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

// TODO: TBD: might add some light error handling...
private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];
private _queue = _namespace getVariable ["_queue", []];
private _targetStorage = _namespace getVariable ["_targetStorage", objNull];

if (_debug) then {
    [format ["[fn_productionsm_tryProduceResource] Entering: [_markerName, _queue]: %1"
        , str [_markerName, _queue]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (true) exitWith {

    if (_debug) then {
        [format ["[fn_productionsm_tryProduceResource] For future use: [_markerName]: %1"
            , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    true;
};

private _onExit = {
    _namespace setVariable ["_targetStorage", nil];
};

if ((_queue isEqualTo []) || isNull _targetStorage) exitWith {

    if (_debug) then {
        ["[fn_productionsm_tryProduceResource] Nothing enqueued or null storage", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    [] call _onExit;
    false;
};

private _markerPos = markerPos _markerName;

// TODO: TBD: could capture as a preset or param...
private _targetPos = _markerPos getPos [25, random 360]

// Do not delete the queue item, we leave that for subsequent tear down...
private _crate = [KPLIB_resources_resourceKinds select (_queue#0), _targetPos] call KPLIB_fnc_resources_createCrate;

// TODO: TBD: do we need to put any locks on the storage while we do this (?)
[_crate, _targetStorage] call KPLIB_fnc_resources_storeCrate;

[] call _onExit;

if (_debug) then {
    ["[fn_productionsm_tryProduceResource] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
