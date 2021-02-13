/*
    KPLIB_fnc_production_isNearCapturedFactory

    File: fn_production_isNearCapturedFactory.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-05 00:00:10
    Last Update: 2021-02-13 09:22:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the '_target' is within '_range', plus optional '_predicate'.

    Parameter(s):
        _target - the object being considered within '_range' of near factory [OBJECT, default: player]
        _range - '_range' within which to verify '_target' of the 'KPLIB_sectors_factory' sectors [SCALAR, default: 0]
        _predicate - allows for an additional '_predicate' in addition to whether near captured factory [CODE, default {true}]
        _predicateArgs - additional arguments to be passed into the predicated callback [ARRAY, default: []]

    Returns:
        Whether the nearest factory sector meets the conditions of being captured, plus optional '_predicate'.

    Dependencies:
        0100_init
*/

params [
    ["_target", player, [objNull]]
    , ["_range", 0, [0]]
    , ["_predicate", { true; }, [{}]]
    , ["_predicateArgs", [], [[]]]
];

// Start with the '_markerName' itself because we need to verify side...
// TODO: TBD: might actually have some confusion between core and common...
// TODO: TBD: actually, might make better sense to move these to core, and update how the "getnearestmarker" works in the first place...
private _markerName = [_target, KPLIB_sectors_factory] call KPLIB_fnc_common_getNearestMarker;

// Then we may also focus the actual range check, predicate, etc...
_markerName in KPLIB_sectors_blufor
    && [_target, _range, [_markerName]] call KPLIB_fnc_core_getTargetMarkerInRange
    && [_target, _range, _markerName, _predicateArgs] call _predicate
    ;
