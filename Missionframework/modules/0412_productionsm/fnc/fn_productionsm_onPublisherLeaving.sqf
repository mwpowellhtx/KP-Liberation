/*
    KPLIB_fnc_productionsm_onPublisherLeaving

    File: fn_productionsm_onPublisherLeaving.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 15:35:49
    Last Update: 2021-02-19 15:35:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Installs a freshly running timer given the CBA production '_namespace' when
        the previous one has elapsed.

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
        , "KPLIB_param_productionsm_publisherLeaving_debug"
        , { _namespace getVariable ["KPLIB_param_productionsm_publisher_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
        , { _namespace getVariable ["KPLIB_param_productionsm_publisherLeaving_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_publisher_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
        , { _objSM getVariable ["KPLIB_param_productionsm_publisherLeaving_debug", false]; }
    ]
] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {
    [format ["[fn_productionsm_onPublisherLeaving] Entering: [_markerName]: %1"
        , str [_markerName]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

// Handle a bit of cid bookkeeping on leaving the state
_objSM setVariable ["KPLIB_productionsm_forced", false];

if (_debug) then {
    ["[fn_productionsm_onPublisherLeaving] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
