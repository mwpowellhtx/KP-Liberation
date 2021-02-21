/*
    KPLIB_fnc_productionsm_onPublishRequestTransition

    File: fn_productionsm_onPublishRequestTransition.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-20 19:33:51
    Last Update: 2021-02-20 19:33:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _namespace - a CBA production namespace [LOCATION, default: locationNull]

    Returns:
        The event handler is fini [BOOL]
 */

params [
    ["_namespace", locationNull, [locationNull]]
];

private _objSM = KPLIB_productionsm_objSM;
private _configSM = KPLIB_productionsm_configSM;

private _debug = [[
    "KPLIB_param_productionsm_publisher_debug"
    , "KPLIB_param_productionsm_productionMgr_debug"
    , { _namespace getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
    , { _objSM getVariable ["KPLIB_param_productionsm_productionMgr_debug", false]; }
]] call KPLIB_fnc_productionsm_debug;

private _markerName = _namespace getVariable ["_markerName", KPLIB_production_markerNameDefault];

if (_debug) then {

    private _config = _configSM
        >> "KPLIB_productionsm_state_scheduler"
        >> "KPLIB_productionsm_transition_onPublishRequest";

    [format ["[fn_productionsm_onPublishRequestTransition] Entering: [_markerName, _config >> 'targetState']: %1"
        , str [_markerName, getText (_config >> "targetState")]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    ["[fn_productionsm_onPublishRequestTransition] Finished", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
