/*
    KPLIB_fnc_common_onGroupCreated

    File: fn_common_onGroupCreated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:48:45
    Last Update: 2021-04-02 14:48:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        // ...
 */

private _debug = [
    [
        {KPLIB_param_common_createGroup_debug}
    ]
] call KPLIB_fnc_common_debug;

params [
    ["_grp", grpNull, [grpNull]]
];

if (_debug) then {
    [format ["[fn_common_onGroupCreated] Entering: [isNull _grp, groupId _grp, count units _grp, count allGroups]: %1"
        , str [isNull _grp, groupId _grp, count units _grp, count allGroups]], "COMMON", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    ["[fn_common_onGroupCreated] Fini", "COMMON", true] call KPLIB_fnc_common_log;
};

true;
