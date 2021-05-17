#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_onPreInit

    File: fn_triggers_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 12:44:09
    Last Update: 2021-05-08 20:13:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/trim
        https://community.bistudio.com/wiki/toUpper
        https://community.bistudio.com/wiki/setVariable
        https://community.bistudio.com/wiki/missionNamespace
        https://community.bistudio.com/wiki/setTriggerActivation
        https://community.bistudio.com/wiki/Category:Command_Group:_Triggers
 */

if (isServer) then {
    ["[fn_triggers_onPreInit] Initializing...", "PRE] [TRIGGERS", true] call KPLIB_fnc_common_log;
};

[] call MFUNC(_settings);

if (isServer) then {
    // Server bits

    MVAR(_registry)                             = createHashMap;

    MPRESET(_byNone)                            = Q(NONE);

    {
        missionNamespace setVariable [
            format ["KPLIB_preset_triggers_bySide%1", _x]
            , toUpper _x
        ];
    } forEach [
        "East"
        , "West"
        , "Guer"
        , "Civ"
        , "Logic"
        , "Any"
        , "AnyPlayer"
    ];

    {
        missionNamespace setVariable [
            format ["KPLIB_preset_triggers_byRadio%1", _x]
            , toUpper _x
        ];
    } forEach [
        "Alpha"
        , "Bravo"
        , "Charlie"
        , "Delta"
        , "Echo"
        , "Foxtrot"
        , "Golf"
        , "Hotel"
        , "India"
        , "Juliet"
    ];

    {
        missionNamespace setVariable [
            format ["KPLIB_preset_triggers_byObject%1", _x]
            , toUpper _x
        ];
    } forEach [
        "Static"
        , "Vehicle"
        , "Group"
        , "Leader"
        , "Member"
    ];

    {
        missionNamespace setVariable [
            format ["KPLIB_preset_triggers_byStatus%1Seized", _x]
            , format ["%1 SEIZED", toUpper _x]
        ];
    } forEach [
        "East"
        , "West"
        , "Guer"
    ];

    {
        missionNamespace setVariable [
            format ["KPLIB_preset_triggers_type%1Present", _x]
            , trim toUpper (format ["%1 PRESENT", _x])
        ];
    } forEach [
        ""
        , "Not"
    ];

    {
        missionNamespace setVariable [
            format ["KPLIB_preset_triggers_type%1Detection", _x]
            , toUpper (format ["%1 D", _x])
        ];
    } forEach [
        "West"
        , "East"
        , "Guer"
        , "Civ"
    ];

    MPRESET(_statements)                    = [
        "[thisTrigger, thisList, this] call (thisTrigger getVariable ['KPLIB_fnc_triggers_onCondition', {false}])"
        , "[thisTrigger, thisList] call (thisTrigger getVariable ['KPLIB_fnc_triggers_onActivation', {}])"
        , "[thisTrigger] call (thisTrigger getVariable ['KPLIB_fnc_triggers_onDeactivation', {}])"
    ];
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_triggers_onPreInit] Initialized", "PRE] [TRIGGERS", true] call KPLIB_fnc_common_log;
};

true;
