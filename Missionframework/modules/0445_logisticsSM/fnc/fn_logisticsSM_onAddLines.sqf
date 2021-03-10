/*
    KPLIBN_fnc_logisticsSM_onAddLines

    File: fn_logisticsSM_onAddLines.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-08 13:03:20
    Last Update: 2021-03-08 13:03:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds logistics lines to the line up on a regular basis.

    Parameter(s):
        NONE

    Returns:
        The callback finished [ARRAY]
 */

private _objSM = missionNamespace getVariable ["KPLIB_logisticsSM_objSM", locationNull];

if (isNull _objSM) exitWith {
    false;
};

([_objSM, [
    ["KPLIB_logistics_namespacesToAdd", []]
]] call KPLIB_fnc_namespace_getVars) params [
    ["_namespacesToAdd", [], [[]]]
];

private _onPushBack = {
    private _namespace = _x;
    if (!isNull _namespace) then {
        KPLIB_logistics_namespaces pushBack _namespace;
    };
};

_onPushBack forEach _namespacesToAdd;

// Be sure to clear both queues afterwards...
[_objSM, [
    ["KPLIB_logistics_namespacesToAdd", []]
]] call KPLIB_fnc_namespace_setVars;

true;
