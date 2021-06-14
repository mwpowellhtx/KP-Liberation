#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_canDisarm

    File: fn_ieds_canDisarm.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 23:14:27
    Last Update: 2021-06-14 17:08:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether PLAYER CAN DISARM the nearest possible IED within range.

    Parameter(s):
        _player - the PLAYER who may disarm [OBJECT, default: objNull]
        _target -  [OBJECT, default: objNull]

    Returns:
        Whether PLAYER CAN DISARM the nearest IED in range [BOOL]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

private _debug = MPARAM(_canDisarm_debug);

params [
    [Q(_player), player, [objNull]]
];

if (_debug) then {
    [format ["[fn_ieds_canDisarm] Entering: [isNull _player]: %1"
        , str [isNull _player]], "IEDS", true] call KPLIB_fnc_common_log;
};

private _onGetDistance = { (_x distance _player) <= MPARAM(_disarmRange); };

([allMines select _onGetDistance, [], _onGetDistance] call BIS_fnc_sortBy) params [
    [Q(_target), objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_ieds_canDisarm] Targeting: [isNull _target, typeOf _target]: %1"
        , str [isNull _target, typeOf _target]], "IEDS", true] call KPLIB_fnc_common_log;
};

if (isNull _target || !(typeOf _target in MPRESET(_mineClassNames))) then {
    _player setVariable [QMVAR(_disarmTarget), nil, true];
} else {
    _player setVariable [QMVAR(_disarmTarget), _target, true];
};

_target = _player getVariable [QMVAR(_disarmTarget), objNull];

if (_debug) then {
    [format ["[fn_ieds_canDisarm] Fini: [isNull _target]: %1"
        , str [isNull _target]], "IEDS", true] call KPLIB_fnc_common_log;
};

_player isEqualTo vehicle _player
    && !(isNull _target);
