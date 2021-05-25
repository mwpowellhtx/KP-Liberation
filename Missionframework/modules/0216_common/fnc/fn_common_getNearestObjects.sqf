/*
    KPLIB_fnc_common_getNearestObjects

    File: fn_common_getNearestObjects.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 18:15:20
    Last Update: 2021-05-18 18:15:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns an ARRAY of the objects near the TARGET object aligning to the CLASS NAMES.
        When there is no TARGET object, or range, then we consider center of the map in all
        directions.

    Parameter(s):
        _target - TARGET object about which to consider nearest objects [OBJECT, default: objNull]
        _range - RANGE about which to consider nearest objects [SCALAR, default: _defaultRange]
        _classNames - CLASS NAMES about which to consider [ARRAY, default: []]

    Returns:
        An ARRAY of the objects aligning to the CLASS NAMES [ARRAY]

    References:
        https://en.wikipedia.org/wiki/Display_aspect_ratio
        https://en.wikipedia.org/wiki/Display_aspect_ratio#Productivity_applications
        https://en.wikipedia.org/wiki/ISO_216#A_series
 */

private _aspectRatioCoef = 1.41;
private _defaultCoord = worldSize / 2;
private _defaultRange = _aspectRatioCoef * _defaultCoord;

/*
 * _coord = worldsize / 2;
 * _aspect = 1.41;
 * _buildings = nearestobjects [[_coord, _coord, 0], ['Land_Cargo_HQ_V1_F'], _coord * _aspect];
 * count _buildings;
 */

params [
    ["_target", objNull, [objNull]]
    , ["_range", _defaultRange, [0]]
    , ["_classNames", [], [[]]]
];

private _debug = MPARAM_param_common_getNearestObjects_debug
    || (_target getVariable ["MPARAM_common_getNearestObjects_debug", false])
    ;

// Normalize TARGET and RANGE accordingly
private _pos = if (isNull _target) then { [_defaultCoord, _defaultCoord, 0]; } else { getPos _target; };

// All CANDIDATES aligning to their class names
private _candidates = nearestObjects [_pos, _classNames, _range];

_candidates;
