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
        private _cid = _x;
        private _verified = _state apply {
            [_x] call KPLIB_fnc_production_verifyArray;
        };
        if (_cid >= 0 && ((count _verified) isEqualTo (count _state))) then {
            if (_debug) then {
                [format ["[fn_productionsm_onPublisher::_onPublish] Owner event: ['KPLIB_productionMgr_onProductionStatePublished', [_cid, _state]]: %1"
                    , str [_cid, _state]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
            };
            ["KPLIB_productionMgr_onProductionStatePublished", [_state], _cid] call CBA_fnc_ownerEvent;
        };
    } forEach _cids;
};

// Keep all of the client identifiers in front of us here
private _cids = _objSM getVariable ["KPLIB_productionsm_cids", []];
private _forced = _objSM getVariable ["KPLIB_productionsm_forced", false];
private _elapsed = [] call KPLIB_fnc_productionsm_hasPublicationTimer;

private _productionList = _objSM getVariable ["CBA_statemachine_list", []];

private _whereProductionF = {
    private _markerName = _x getVariable ["_markerName", ""];
    !(_markerName isEqualTo "")
        && _markerName in KPLIB_sectors_blufor;
};

// We only want the '_state' that is considered friendly, i.e. BLUFOR
private _state = _productionList select _whereProductionF apply {
    [_x] call KPLIB_fnc_production_namespaceToArray;
};

if (_debug) then {
    [format ["[fn_productionsm_onPublisher] [_cids, _elapsed, _forced, count _state]: %1"
        , str [_cids, _elapsed, _forced, count _state]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Publish for a couple of reasons, on request, or timer elapsed
if (_forced || _elapsed) then {
    [_state, _cids, _debug] call _onPublish;
};

_objSM setVariable ["KPLIB_productionsm_publishedState", _state];

private _restart = true;

// Kick off the next wait period by restarting the timer, regardless
[_restart] call KPLIB_fnc_productionsm_onPublicationTimerRefresh;

if (_debug) then {
    ["[fn_productionsm_onPublisher] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
