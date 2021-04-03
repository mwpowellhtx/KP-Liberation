#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_whereShouldBeCounted

    File: fn_hudDispatchSM_whereShouldBeCounted.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether a target object should be counted.

    Parameters:
        _target - a target object being counted [OBJECT, default: objNull]
        _fobs - the FOBS at which to consider [ARRAY, default: KPLIB_sectors_fobs
        _range - the range within which to consider [SCALAR, default: KPLIB_param_fobRange]

    Returns:
        Whether a target object should be counted at the FOB [BOOL]
 */

params [
    [Q(_target), objNull, [objNull]]
    , [Q(_fobs), +KPLIB_sectors_fobs, [[]]]
    , [Q(_range), KPLIB_param_fobRange, [0]]
];

[
    // If it can be persisted, then it should be counted
    [_target] call KPLIB_fnc_persistence_whereAssetMayBeFobPersistent
    , [_target, _fobs, _range] call KPLIB_fnc_persistence_whereAssetShouldBeFobPersistent
] params [
    Q(_may)
    , Q(_should)
];

_may && _should;
