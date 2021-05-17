#include "script_component.hpp"
/*
    KPLIB_fnc_hudSM_getThresholdColor

    File: fn_hudSM_getThresholdColor.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:06:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        By default selects the FIRST available color for GE POSITIVE or
        GT NEGATIVE threshold.

    Parameters:
        _target - the target threshold [SCALAR, default: 0]
        _thresholds - an array of thresholds to consider [ARRAY, default: []]
        _default - a default RGBA color to use [RGBA, default: [1, 1, 1, 1]]
        _comparison - a comparison function to use [CODE, default: _defaultComparison]

    Returns:
        The color meeting the threshold predicate [RGBA]
 */

private _defaultComparison = {
    params [
        [Q(_target), 0, [0]]
        , [Q(_threshold), 0, [0]]
    ];
    (_threshold >= 0 && _target >= _threshold)
        || (_threshold < 0 && _target > _threshold);
};

params [
    [Q(_target), 0, [0]]
    , [Q(_thresholds), [], [[]]]
    , [Q(_default), [1, 1, 1, 1], [[]], 4]
    , [Q(_comparison), _defaultComparison, [{}]]
];

// TODO: TBD: hmm, we might even be able to do some math here...
// TODO: TBD: i.e. TARGET-THRESHOLD, and do some math, i.e. which is of least distance...
private _selected = _thresholds select { [_target, (_x#0)] call _comparison; };

if (count _selected > 0) exitWith { +(_selected#0#1); };
//                          _color:   ___________^^

_default;
