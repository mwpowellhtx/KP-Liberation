/*
    KPLIB_fnc_productionsm_onPublisherEntered

    File: fn_productionsm_onPublisherEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 15:28:08
    Last Update: 2021-02-21 13:21:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Callback which handles creating or refreshing the Publisher timer for the
        CBA production '_namespace'.

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
        , "KPLIB_param_productionsm_publisherEntered_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_publisher_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_publisherEntered_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_publisher_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_publisherEntered_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_onPublisherEntered] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[] call KPLIB_fnc_productionsm_onPublicationTimerRefresh;

if (_debug) then {
    ["[fn_productionsm_onPublisherEntered] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
