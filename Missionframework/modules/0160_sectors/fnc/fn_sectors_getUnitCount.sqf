#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getUnitCount

    File: fn_sectors_getUnitCount.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 09:52:57
    Last Update: 2021-04-26 09:52:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Counts the UNITS matching SIDE and CLASS NAME criteria.

    Parameter(s):
        _units - the units to count [ARRAY, default: []]
        _side - the SIDE for which to count [SIDE, default: KPLIB_preset_sideF]
        _className - the kind of class name for which to count [STRING, default: _manClassName]

    Returns:
        The count of units matching side and class name criteria [SCALAR]

    References:
        https://community.bistudio.com/wiki/isKindOf
 */

private _manClassName = "CAManBase";

// 'Friendly' is the default SIDE, and 'Man' is the default class name
params [
    [Q(_units), [], [[]]]
    , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
    , [Q(_className), _manClassName, [""]]
];

[
    { [_x, _side, _className] call MFUNC(_whereUnitMatches); } count _units
] params [
    Q(_count)
];

_count;
