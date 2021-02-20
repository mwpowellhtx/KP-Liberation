/*
    KPLIB_fnc_productionsm_onPublisher

    File: fn_productionsm_onPublisher.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-18 19:41:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback handles publishing the CBA production '_namespace' tuple to listening clients
        when it has changed in any way, shape or form.

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The event handler is fini [BOOL]
 */

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_namespace", locationNull, [locationNull]]
];

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_onPublisher] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _onPublish = {
    params [
        ["_targetElem", [], [[]]]
        , ["_cids", [], [[]]]
    ];
    {
        private_cid = _x;
        if (_cid >= 0 && ([_targetElem] call KPLIB_fnc_production_verifyArray)) then {
            ["KPLIB_productionMgr_onProductionElemPublished", _targetElem, _cid] call CBA_fnc_ownerEvent;
        };
    } forEach _cids;
};

// Keep the timer and production element states in front of us
private _timer = _namespace getVariable ["_publisherTimer", []];
private _oldState = _namespace getVariable ["_publisherState", []];
private _productionElem = [_namespace] call KPLIB_fnc_production_namespaceToArray;

// Keep all of the client identifiers in front of us here
private _cids = _namespace getVariable ["_cids", []];
private _previousCids = _namespace getVariable ["_previousCids", []];

private _newCids = _cids select { !(_x in _previousCids); };

private _forcedCids = _namespace getVariable ["_forcedCids", []];
{ _forcedCids pushBackUnique _x; } forEach _newCids;

// Publish any that are not forced during normal statemachine iterations
private _publishCids = _cids select { !(_x in _forcedCids); };

/* Publish either:
 *  - new and 'forced' (refresh button) mgr dialog announcements
 *  - existing timer elapsed mgrs
 */

// Forced publish includes new and actual 'forced' i.e. mgr refresh button
[_productionElem, _forcedCids] call _onPublish;

// Do not publish when nothing of any significance changed
if (_timer isEqualTo []
    || (_timer call KPLIB_fnc_timers_hasElapsed
        && !(_productionElem isEqualTo _oldState))) then {

    // Mark the new line in the sand and notify the listening clients
    _namespace setVariable ["_publisherState", (+_productionElem)];

    [_productionElem, _publishCids] call _onPublish;
};

if (_debug) then {
    ["[fn_productionsm_onPublisher] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
