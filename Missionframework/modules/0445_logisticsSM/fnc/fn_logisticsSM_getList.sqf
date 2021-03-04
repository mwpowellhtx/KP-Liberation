/*
    KPLIB_fnc_logisticsSM_getList

    File: fn_logisticsSM_getList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-04 08:35:05
    Last Update: 2021-03-04 08:35:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The array of CBA logistics namespaces. This is invoked with every SM iteration
        through the list, and is our moment of opportunity to remove "removed" logistics
        lines, or add "added" ones, in response to client requests. Removes CBA logistics
        namespace objects aligned with the 'KPLIB_logistics_uuidToRemove' variable. Adds
        staged CBA logistics namespaces objects via the 'KPLIB_logistics_namespacesToAdd'
        variable.

    Parameter(s):
        NONE

    Returns:
        The array of CBA logistics namespaces [ARRAY]

    References:
        https://github.com/CBATeam/CBA_A3/blob/master/addons/statemachine/fnc_create.sqf#L9-L13
 */

// Processing both queues...
private _uuidToRemove = KPLIB_logisticsSM_namespace getVariable ["KPLIB_logistics_uuidToRemove", []];
private _namespacesToAdd = KPLIB_logisticsSM_namespace getVariable ["KPLIB_logistics_namespacesToAdd", []];

private _onGcMatchingNamespace = {
    private _lineUuid = _x;
    private _i = KPLIB_logistics_namespaces findIf {
        private _uuid = _x getVariable ["KPLIB_logistics_uuid", ""];
        private _status = _x getVariable ["KPLIB_logistics_status", KPLIB_logistics_status_na];
        !(_lineUuid isEqualTo "")
            && _uuid isEqualTo _lineUuid
            && _status == KPLIB_logistics_status_standby;
    };
    if (_i >= 0) then {
        [KPLIB_logistics_namespaces deleteAt _i] call KPLIB_fnc_logistics_onGC;
    };
};

private _onPushBack = {
    private _namespace = _x;

    /* Lines are only rebased once during their lifetime in a server session. Newly created lines do not
     * require rebasing, they will have already had timers configured given the 'serverTime' 'startTimes'. */

    if (!isNull _namespace) then {

        _namespace setVariable ["KPLIB_logistics_rebased", true];
        //                       ^^^^^^^^^^^^^^^^^^^^^^^

        KPLIB_logistics_namespaces pushBack _namespace;
    };
};

_onGcMatchingNamespace forEach _uuidToRemove;
_onPushBack forEach _namespacesToAdd;

// Be sure to clear both queues afterwards...
KPLIB_logisticsSM_namespace setVariable ["KPLIB_logistics_uuidToRemove", []];
KPLIB_logisticsSM_namespace setVariable ["KPLIB_logistics_namespacesToAdd", []];

// This is the "one" time when broadcast may occur, i.e. when lines are refreshed during SM operation...
[] call KPLIB_fnc_logisticsSM_onBroadcastLines;

+KPLIB_logistics_namespaces;
