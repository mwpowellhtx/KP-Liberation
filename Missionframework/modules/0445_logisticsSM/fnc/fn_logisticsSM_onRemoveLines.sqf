/*
    KPLIB_fnc_logisticsSM_onRemoveLines

    File: fn_logisticsSM_onRemoveLines.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-08 13:03:20
    Last Update: 2021-03-08 13:03:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Removes logistics lines from the line up on a regular basis.

    Parameter(s):
        NONE

    Returns:
        The callback finished [ARRAY]
 */

private _debug = [
    [
        {KPLIB_param_logisticsSM_onRemoveLines_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

private _objSM = missionNamespace getVariable ["KPLIB_logisticsSM_objSM", locationNull];

if (_debug) then {
    [format ["[fn_logisticsSM_onRemoveLines] Entering: [isNull _objSM]: %1"
        , str [isNull _objSM]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

if (isNull _objSM) exitWith {
    false;
};

([_objSM, [
    ["KPLIB_logistics_uuidToRemove", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_uuidToRemove"
];

// Removes matching LINES in STANDBY and zero CONVOY TRANSPORTS
private _onGcMatchingNamespace = {
    private _lineUuid = _x;
    private _i = KPLIB_logistics_namespaces findIf {
        ([_x, [
            ["KPLIB_logistics_uuid", ""]
            , ["KPLIB_logistics_status", KPLIB_logistics_status_na]
            , [KPLIB_logistics_convoy, []]
        ]] call KPLIB_fnc_namespace_getVars) params [
            "_uuid"
            , "_status"
            , "_convoy"
        ];
        !(_lineUuid isEqualTo "")
            && _uuid isEqualTo _lineUuid
            && _status == KPLIB_logistics_status_standby
            && _convoy isEqualTo []
    };
    if (_i >= 0) then {
        [KPLIB_logistics_namespaces deleteAt _i] call KPLIB_fnc_namespace_onGC;
    };
};

if (_debug) then {
    [format ["[fn_logisticsSM_onRemoveLines] Removing: [count _uuidToRemove, _uuidToRemove]: %1"
        , str [count _uuidToRemove, _uuidToRemove]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_onGcMatchingNamespace forEach _uuidToRemove;

// Be sure to clear both queues afterwards...
[_objSM, [
    ["KPLIB_logistics_uuidToRemove", []]
]] call KPLIB_fnc_namespace_setVars;

if (_debug) then {
    ["[fn_logisticsSM_onRemoveLines] Fini", "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

true;
