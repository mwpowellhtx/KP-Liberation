#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onSurrenderUnitOne

    File: fn_captives_onSurrenderUnitOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-16 18:34:16
    Last Update: 2021-06-16 18:34:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Surrenders ONE UNIT. Conditions have already been met, we are here simply
        to close the loop on the response.

    Parameter(s):
        _unit - a UNIT object to surrender [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/removeAllWeapons
        https://community.bistudio.com/wiki/removeHeadgear
        https://community.bistudio.com/wiki/removeBackpack
        https://community.bistudio.com/wiki/setUnitPos
        https://community.bistudio.com/wiki/disableAI
        https://community.bistudio.com/wiki/playMove
        https://community.bistudio.com/wiki/setCaptive
        https://community.bistudio.com/wiki/setBehaviour
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_onSurrenderUnitOne_debug)
    || (_unit getVariable [QMVAR(_onSurrenderUnitOne_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

/* We only consider UNITS that have already given up their VEHICLE, or were otherwise
 * already free standing. Otherwise they have not surrendered the vehicle, etc. However,
 * we shall verify that condition here as a smoke test.
 */
if (!(alive _unit || isNull objectParent _unit)) exitWith {
    false;
};

// Remove some bits from the UNIT
removeAllWeapons _unit;
removeHeadgear _unit;
removeBackpack _unit;

if (KPLIB_ace_enabled) exitWith {
    if (_debug) then {
        // TODO: TBD: logging...
    };
    [_unit, true] call ACE_captives_fnc_setSurrendered;
    true;
};

[QMVAR(_surrender), [_unit]] call CBA_fnc_globalEvent;

if (_debug) then {
    // TODO: TBD: logging...
};

true;
