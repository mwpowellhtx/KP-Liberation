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

if (isNil "KPLIB_logisticsSM_objSM") exitWith {
    false;
};

([KPLIB_logisticsSM_objSM, [
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

_onGcMatchingNamespace forEach _uuidToRemove;

// Be sure to clear both queues afterwards...
[KPLIB_logisticsSM_objSM, [
    ["KPLIB_logistics_uuidToRemove", []]
]] call KPLIB_fnc_namespace_setVars;

true;
