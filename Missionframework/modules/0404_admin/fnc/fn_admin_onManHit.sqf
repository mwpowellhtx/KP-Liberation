/*
    KPLIB_fnc_admin_onManHit

    File: fn_admin_onManHit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-05 11:22:29
    Last Update: 2021-06-14 16:47:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _target - a target object [OBJECT, default: objNull]
        _killer - a killer object [OBJECT, default: objNull]
        _damage - the damage [SCALAR, default: 0]
        _instigator - an instigator object [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Hit
 */

// TODO: TBD: this truly does belong in the common or core modules... possibly even 'enemy' where it was?
params [
    ["_target", objNull, [objNull]]
    , ["_source", objNull, [objNull]]
    , ["_damage", 0, [0]]
    , ["_instigator", objNull, [objNull]]
];

if (isNull _target || isNull _instigator || !(_instigator in allUnits)) exitWith {
    false;
};

_instigator setVariable [format ["KPLIB_admin_%1TouchTime", toLower str side _target], diag_tickTime];

// TODO: TBD: refactor as an admin damage reflction...
if (([_target, _instigator] apply { side _x }) isEqualTo [KPLIB_preset_sideF, KPLIB_preset_sideE]) then {
    _instigator setDamage 1;

    // Whack the rest of the crew along with him
    private _vehicle = vehicle _instigator;

    if (_vehicle isNotEqualTo _instigator) then {
        { _x setDamage 1; } forEach ((crew _vehicle) - [_instigator]);
    };

    [_instigator] call KPLIB_fnc_common_onKilled;
};

true;
