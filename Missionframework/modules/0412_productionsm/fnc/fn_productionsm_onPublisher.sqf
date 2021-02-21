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

params [
    ["_namespace", locationNull, [locationNull]]
];

private _objSM = KPLIB_productionsm_objSM;

private _debug = [
    [
        "KPLIB_param_productionsm_publisher_debug"
        , "KPLIB_param_productionsm_productionMgr_debug"
        , "KPLIB_param_productionsm_publisherCore_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_publisher_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_publisherCore_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_publisher_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_publisherCore_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

[_objSM] call KPLIB_fnc_productionsm_onPublicationTimerRefresh;

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_onPublisher] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _onPublish = {
    params [
        ["_state", [], [[]]]
        , ["_cids", [], [[]]]
        , ["_debug", false, [false]]
    ];
    {
        // TODO: TBD: verify the state, of each '_productionElem'
        private _cid = _x;
        if (_cid >= 0 /* && ([_targetElem] call KPLIB_fnc_production_verifyArray) */ ) then {

            if (_debug) then {
                [format ["[fn_productionsm_onPublisher::_onPublish] Owner event: ['KPLIB_productionMgr_onProductionStatePublished', _state]: %1"
                    , str _state], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
            };

            ["KPLIB_productionMgr_onProductionStatePublished", [_state], _cid] call CBA_fnc_ownerEvent;
        };
    } forEach _cids;
};

// Keep all of the client identifiers in front of us here
private _cids = _objSM getVariable ["KPLIB_productionsm_cids", []];
private _forcedCids = _objSM getVariable ["KPLIB_productionsm_forcedCids", []];

// Only perform routine notification for the clients which were not forced
private _publishCids = _cids select { !(_x in _forcedCids); };

if (_debug) then {
    [format ["[fn_productionsm_onPublisher] cids: [_cids, _forcedCids, _publishCids]: %1"
        , str [_cids, _forcedCids, _publishCids]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Keep the timer and production element states in front of us
private _oldState = _objSM getVariable ["KPLIB_productionsm_publishedState", []];
private _productionList = _objSM getVariable ["CBA_statemachine_list", []];
private _newState = _productionList apply { [_x] call KPLIB_fnc_production_namespaceToArray; };

/* Publish either:
 *  - new and 'forced' (refresh button) mgr dialog announcements
 *  - existing timer elapsed mgrs
 */

// Forced publish includes new and actual 'forced' i.e. mgr refresh button
[_newState, _forcedCids] call _onPublish;

// Do not publish when nothing of any significance changed
if (!(_newState isEqualTo _oldState)) then {
    // Mark the new line in the sand and notify the listening clients
    [_newState, _publishCids] call _onPublish;
};

_objSM setVariable ["KPLIB_productionsm_publishedState", _newState];

// Kick off the next wait period by restarting the timer period
[_objSM, KPLIB_param_productionsm_publisherPeriodSeconds] call {
    params ["_objSM", "_period"];
    _objSM setVariable ["KPLIB_productionsm_publicationTimer", ([_period] call KPLIB_fnc_timers_create)];
};

if (_debug) then {
    ["[fn_productionsm_onPublisher] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
