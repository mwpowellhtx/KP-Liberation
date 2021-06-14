#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onManKilled

    File: fn_enemies_onManKilled.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-10 19:23:41
    Last Update: 2021-06-14 17:17:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _target - a target object [OBJECT, default: objNull]
        _killer - a killer object [OBJECT, default: objNull]
        _instigator - an instigator object [OBJECT, default: objNull]
        _useEffects - whether to use effects [BOOL, default: false]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Killed
        https://community.bistudio.com/wiki/setDamage#Alternative_Syntax
 */

params [
    [Q(_target), objNull, [objNull]]
    , [Q(_killer), objNull, [objNull]]
    , [Q(_instigator), objNull, [objNull]]
    , [Q(_useEffects), false, [false]]
];

if (isNull _target || isNull _instigator) exitWith {
    false;
};

// Man down automatically sets CAPTURED flags, which should help during SECTOR SM phases
_target setVariable [Q(KPLIB_surrender), true];

_instigator setVariable [format ["KPLIB_enemies_%1TouchTime", toLower str side _target], diag_tickTime];

true;
