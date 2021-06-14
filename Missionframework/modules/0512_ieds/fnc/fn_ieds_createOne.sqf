#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_createOne

    File: fn_ieds_createOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 14:02:14
    Last Update: 2021-06-14 17:09:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates a new MINE (IED) at the TARGET POSITION. It is left for the
        caller to determine how to position the MINE (IED).

    Parameter(s):
        _className - a MINE (IED) class to create [STRING, default: ""]
        _targetPos - a POSITION where the MINE (IED) should be created [POSITION, default: KPLIB_zeroPos]

    Returns:
        The created MINE (IED) object [OBJECT]

    References:
        https://community.bistudio.com/wiki/createMine#Syntax
 */

private _debug = MPARAM(_createOne_debug);

params [
    [Q(_className), "", [""]]
    , [Q(_targetPos), +KPLIB_zeroPos, [[]], 3]
];

private _target = objNull;

if (_className isEqualTo "" || _targetPos isEqualTo KPLIB_zeroPos) exitWith {
    _target;
};

// TODO: TBD: no markers, for now, but that should be considered as an option...
private _markers = [];

_target = createMine [_className, _targetPos, _markers, 0];

_target setVariable [QMVAR(_className), _className, true];

// We can probably get away with a server only event after all
[Q(KPLIB_vehicle_created), [_target]] call CBA_fnc_serverEvent;

_target;
