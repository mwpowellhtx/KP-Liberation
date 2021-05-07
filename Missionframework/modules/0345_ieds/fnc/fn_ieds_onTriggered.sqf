#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onTriggered

    File: fn_ieds_onTriggered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 18:30:08
    Last Update: 2021-05-07 13:38:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Triggers the target IED explosion.

    Parameter(s):
        _target - the TARGET IED object being triggered [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]

    References:
        https://community.bistudio.com/wiki/setDamage
 */

private _debug = MPARAM(_onTriggered_debug);

params [
    [Q(_target), objNull, [objNull]]
];

if (isNull _target) exitWith {
    true;
};

// TODO: TBD: since they are 'mines' then may consider 'touch off'
// TODO: TBD: https://community.bistudio.com/wiki/Arma_3:_Actions#TouchOff
// TODO: TBD: and for bigger more spectacular effects, we might also consider spawning in other explosions/effects...
// Which 'triggers' the IED explosion
_target setDamage 1;

[_target] call MFUNC(_onGC);
