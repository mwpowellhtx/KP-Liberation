#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_whereUnitMatches

    File: fn_sectors_whereUnitMatches.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 09:52:57
    Last Update: 2021-04-26 09:52:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Counts the UNITS matching SIDE and CLASS NAME criteria.

    Parameter(s):
        _unit - the unit to consider [OBJECT, default: objNull]
        _side - the SIDE for which to count [SIDE, default: KPLIB_preset_sideF]
        _className - the kind of class name for which to count [STRING, default: _manClassName]
        _predicate - an additional predicate to consider, by default considers 'alive'
            [CODE, default: _defaultPredicate]

    Returns:
        The count of units matching side and class name criteria [SCALAR]

    References:
        https://community.bistudio.com/wiki/isKindOf
        https://community.bistudio.com/wiki/alive
 */

private _manClassName = "CAManBase";
private _defaultPredicate = { alive _this; };

params [
    [Q(_unit), objNull, [objNull]]
    , [Q(_side), KPLIB_preset_sideF, [sideEmpty]]
    , [Q(_className), _manClassName, [""]]
    , [Q(_predicate), _defaultPredicate, [{}]]
];

side _unit isEqualTo _side
    && _unit isKindOf _className
    && (_unit call _defaultPredicate);
