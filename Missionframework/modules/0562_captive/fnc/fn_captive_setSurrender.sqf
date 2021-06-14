/*
    KPLIB_fnc_captive_setSurrender

    File: fn_captive_setSurrender.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-09-11
    Last Update: 2021-06-14 17:19:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Given unit surrenders.

    Parameter(s):
        _unit - Unit to set in surrender [OBJECT, defaults to objNull]

    Returns:
        Unit surrendered [BOOL]
 */

params [
    ["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith { false; };

if (vehicle _unit isNotEqualTo _unit) then {
    moveOut _unit;
};

// UNIT surrendered but has not yet been CAPTURED
_unit setVariable ["KPLIB_surrender", [KPLIB_param_captive_timeout] call KPLIB_fnc_timers_create, true];

// Remove some equipment of the unit
removeAllWeapons _unit;
removeHeadgear _unit;
removeBackpack _unit;
_unit setUnitPos "UP";
if (KPLIB_ace_enabled) then {
    [_unit, true] call ACE_captives_fnc_setSurrendered;
} else {
    _unit disableAI "ANIM";
    _unit disableAI "MOVE";
    _unit playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
    _unit setCaptive true;
    _unit setBehaviour "CARELESS";

    // Invoke the CAPTIVE actions for all players in a JIP manner
    [_unit] remoteExecCall ["KPLIB_fnc_captive_addCaptiveAction", 0, _unit];
};

// Add a killed EH to the unit, to ensure that all actions will be removed
_unit addMPEventHandler ["MPKilled", {
    // Remove all actions of the unit
    removeAllActions (_this select 0);

    // Remove the unload action from the vehicle if the unit is in a vehicle
    private _vehicle = objectParent (_this select 0);
    if (!(isNull _vehicle)) then {
        _vehicle removeAction ((_this select 0) getVariable ["KPLIB_captive_unloadID", 9000]);
    };
}];

// Emit global event
["KPLIB_captive_surrendered", [_unit]] call CBA_fnc_globalEvent;

true;
