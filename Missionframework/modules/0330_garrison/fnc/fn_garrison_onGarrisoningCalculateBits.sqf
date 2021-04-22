#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningCalculateBits

    File: fn_garrison_onGarrisoningCalculateBits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-19 13:17:03
    Last Update: 2021-04-21 11:25:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Calculates the bits GARRISON SPECIFICATIONS. Specs out a handful of potential
        bit CLASS NAMES. Note that because we have specified the bits does not mean they
        will actually be used during the GARRISON SECTOR phase. This is because not all bases
        will have buildings which are qualified to receive a spawning bit.

        Applies as a general principle for both INTEL as well as IEDs.

    Parameter(s):
        _args - an bits specific count calculator arguments bundle [ARRAY, default: []]
        _thresholdValues - the bit CLASS NAME threshold values; should be specified
            in the same order as the PRESET bit CLASS NAMES [ARRAY, default: []]
        _targetClassNames

        Count calculator arguments bundle: [_min, _count, _ceil, _coef]

    Returns:
        The specified bits CLASS NAMES [ARRAY]
 */

private _debug = MPARAM(_onGarrisoningCalculateBits_debug);

params [
    [Q(_args), [], [[]]]
    , [Q(_thresholdValues), [], [[]]]
    , [Q(_targetClassNames), [], [[]]]
];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningCalculateBits] Entering: [_args, _thresholdValues, _targetClassNames]: %1"
        , str [_args, _thresholdValues, _targetClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

private _retval = [];
private _bitCount = _args call MFUNC(_onRefresh_calculateEachCount);

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningCalculateBits] Count: [_bitCount]: %1"
        , str [_bitCount]], "GARRISON", true] call KPLIB_fnc_common_log;
};

if (_bitCount == 0) exitWith {
    _retval;
};

private _onCalculateClassNames = {
    params [
        [Q(_count), 0, [0]]
        , [Q(_thresholdClassNames), [], [[]], (count _targetClassNames + 1)]
    ];

    // Starting from base empty array resize to count
    private _classNames = [];
    _classNames resize _count;

    if (_debug) then {
        [format ["[fn_garrison_onGarrisoningCalculateBits::_onCalculateClassNames] Entering: [_count, count _classNames, count _thresholdClassNames, _thresholdClassNames]: %1"
            , str [_count, count _classNames, count _thresholdClassNames, _thresholdClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
    };

    private _appliedClassNames = _classNames apply {
        private _selectedClassNames = _thresholdClassNames select { random 1 >= (_x#0); };
        _selectedClassNames#0#1;
    };

    private _retval = _appliedClassNames select { !(_x isEqualTo ""); };

    if (_debug) then {
        [format ["[fn_garrison_onGarrisoningCalculateBits::_onCalculateClassNames] Selected: [_count, count _retval, _retval]: %1"
            , str [_count, count _retval, _retval]], "GARRISON", true] call KPLIB_fnc_common_log;
    };

    _retval;
};

// We build threshold gated class names in this way allowing for settings to change in between
private _thresholdClassNames = [_thresholdValues, _targetClassNames, { _this select [0, 2]; }] call KPLIB_fnc_linq_zip;
_thresholdClassNames pushBack [0, ""];

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningCalculateBits] Class names: [_bitCount, count _thresholdClassNames, _thresholdClassNames]: %1"
        , str [_bitCount, count _thresholdClassNames, _thresholdClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_bitClassNames = [_bitCount, _thresholdClassNames] call _onCalculateClassNames;

if (_debug) then {
    [format ["[fn_garrison_onGarrisoningCalculateBits] Fini: [count _bitClassNames, _bitClassNames]: %1"
        , str [count _bitClassNames, _bitClassNames]], "GARRISON", true] call KPLIB_fnc_common_log;
};

_bitClassNames;
