/*
    KPLIB_fnc_common_onUnitCreated

    File: fn_common_onUnitCreated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-02 14:50:33
    Last Update: 2021-04-02 14:50:35
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
        {KPLIB_param_common_createUnit_debug}
    ]
] call KPLIB_fnc_common_debug;

params [
    ["_unit", objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_common_onUnitCreated] Entering: [isNull _unit, count allUnits, getPos _unit, mapGridPosition getPos _unit]: %1"
        , str [isNull _unit, count allUnits, getPos _unit, mapGridPosition getPos _unit]], "COMMON", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    ["[fn_common_onUnitCreated] Fini", "COMMON", true] call KPLIB_fnc_common_log;
};

true;
