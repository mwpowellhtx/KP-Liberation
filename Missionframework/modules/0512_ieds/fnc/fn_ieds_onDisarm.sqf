#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onDisarm

    File: fn_ieds_onDisarm.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 18:20:51
    Last Update: 2021-06-14 17:09:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Attempts to DISARM the target IED object. Note that this one will be client side
        after all, which is something to keep in mind connecting the dots with the server
        side IED object.

    Parameter(s):
        _player - the PLAYER attempting to disarm [OBJECT, default: objNull]

    Returns:
        The calculated SPAWN POSITION for the IED CLASS NAME under consideration [POSITION]    

    References:
        https://community.bistudio.com/wiki/getRoadInfo
 */

private _debug = MPARAM(_onDisarm_debug);

params [
    [Q(_player), objNull, [objNull]]
];

private _target = _player getVariable [QMVAR(_disarmTarget), objNull];
private _precision = PCT(MPARAM(_disarmPrecision));

if (_debug) then {
    [format ["[fn_ieds_onDisarm] Entering: [isNull _player, isNull _target, typeOf _target, _precision]: %1"
        , str [isNull _player, isNull _target, typeOf _target, _precision]], "IEDS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: the act of disarming may add the IED to player gear (?)
// TODO: TBD: i.e. if we support ACE perhaps? or vanilla (?)

// A more damaged IED is harder to disarm
[
    random 1
    , 1 - (damage _target)
] params [
    Q(_try)
    , Q(_threshold)
];

private _disarmed = switch (true) do {
    // Disarmed successfully
    case (_try <= (_threshold - _precision)): {
        [_target] call MFUNC(_onGC);
        true;
    };

    // Failed so triggered
    case (_try > _threshold + _precision): {
        [_target] call MFUNC(_onTriggered);
        true;
    };

    // Otherwise no effect, failed to disarm, also did not trigger
    default { false; };
};

if (_disarmed) then {
    _player setVariable [QMVAR(_disarmTarget), nil, true];
};

if (_debug) then {
    [format ["[fn_ieds_onDisarm] Fini: [_try, _threshold, _precision, _disarmed]: %1"
        , str [_try, _threshold, _precision, _disarmed]], "IEDS", true] call KPLIB_fnc_common_log;
};

true;
