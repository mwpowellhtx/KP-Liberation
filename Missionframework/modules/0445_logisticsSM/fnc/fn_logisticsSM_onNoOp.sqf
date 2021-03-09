/*
    KPLIB_fnc_logisticsSM_onNoOp

    File: fn_logisticsSM_onNoOp.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-07 18:59:15
    Last Update: 2021-03-07 18:59:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _namespace - a CBA logistics namespace [LOCATION, default: locationNull]
        _stateOrTransition - the STATE or TRANSITION being proxied [STRING, default: ""]

    Returns:
        The callback has finished [ARRAY]
 */

// TODO: TBD: add logging, etc
private _debug = [
    [
        {KPLIB_param_logisticsSM_onNoOp_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_stateOrTransition", "", [""]]
];

([_namespace, [
    ["KPLIB_logistics_uuid", ""]
]] call KPLIB_fnc_namespace_getVars) params [
    "_targetUuid"
];

if (_debug) then {
    [format ["[fn_logisticsSM_onNoOp] Entering: [_targetUuid, _stateOrTransition]: %1"
        , str [_targetUuid, _stateOrTransition]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: introduce this in the event that we mess up on some conditions...
// TODO: TBD: so that we have a clue as to "where" we landed in the SM ...

if (_debug) then {
    ["[fn_logisticsSM_onNoOp] Fini", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
