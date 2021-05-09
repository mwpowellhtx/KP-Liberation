#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_create

    File: fn_triggers_create.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 12:54:00
    Last Update: 2021-05-08 22:39:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a created TRIGGER OBJECT, literally as an object, with several defining
        attributes, AREA, ACTIVATION, and STATEMENTS, making it what it is.

    Parameter(s):
        _target - may be either an OBJECT on which to target, or a POSITION [OBJECT|POSITION, default: objNull]
        _area - TRIGGER AREA arguments; all sizes are divided by two [ARRAY, default: []]
            [
                _a - X size [SCALAR, default: 0]
                , _b - Y size [SCALAR, default: 0]
                , _angle - rotation, degrees  [SCALAR, default: 0]
                , _isRectangle [BOOL, default: false]
                , _c - Z size [SCALAR, optional]
            ]
        _activation - TRIGGER ACTIVATION arguments [ARRAY, default: []]
            [
                _by - the BY component [SIDE|STRING, default: sideEmpty]
                , _type - the TYPE component [SIDE|BOOL|STRING, default: true]
                , _repeating - whether REPEATING [BOOL, default: true]
            ]
        _statements - TRIGGER STATEMENTS arguments [ARRAY, default: []]
            [
                _condition - CODE containing trigger condition [CODE, default: {_this#2}]
                    Parameter(s):
                        _trigger - trigger instance [OBJECT]
                        _list - array of all detected entities [ARRAY]
                        _activation - detection event [BOOL]

                , _onActivation - CODE that is executed when trigger is activated [CODE, default: {}]
                    Parameter(s):
                        _trigger - trigger instance [OBJECT]
                        _list - array of all detected entities [ARRAY]

                , _onDeactivation - CODE that is executed when trigger is deactivated [CODE, default: {}]
                    Parameter(s):
                        _trigger - trigger instance [OBJECT]
            ]

    Returns:
        The created TRIGGER [OBJECT]

    Remarks:
        Note that '_statements' callback arguments are always normalized to the following:
            [
                _trigger - trigger instance [OBJECT]
                , _list - array of all detected entities [ARRAY, default: nil]
                , _detected - detection event [BOOL, default: nil]
            ]

        The TRIGGER will have parameters that are useful during callbacks, i.e. 'KPLIB_triggers_target'.
        'KPLIB_triggers_uuid' may also be useful but it is used more during internal bookkeeping. The
        STATEMENTS are actual CODE, set as variables on the TRIGGER for invocation,
        'KPLIB_fnc_triggers_onCondition', 'KPLIB_fnc_triggers_onActivation',
        'KPLIB_fnc_triggers_onDeactivation'.

        Also, should be able to attach triggers to a mine, but we'll see.

    References:
        https://community.bistudio.com/wiki/Category:Command_Group:_Triggers
        https://community.bistudio.com/wiki/createTrigger
        https://community.bistudio.com/wiki/setTriggerArea
        https://community.bistudio.com/wiki/setTriggerActivation
        https://community.bistudio.com/wiki/setTriggerStatements
        https://community.bistudio.com/wiki/setTriggerInterval
        https://community.bistudio.com/wiki/setTriggerTimeout
        https://community.bistudio.com/wiki/enableSimulation
        https://community.bistudio.com/wiki/Side
        https://community.bistudio.com/wiki/createMine
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createTrigger-sqf.html#CBA_fnc_createTrigger
        https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_createTrigger.sqf
        https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_getArg.sqf
 */

private _debug = MPARAM(_create_debug);

params [
    [Q(_target), objNull, [objNull, []]]
    , [Q(_area), [], [[]]]
    , [Q(_activation), [], [[]]]
    , [Q(_statementCallbacks), [], [[]]]
];

private _targetPos = [];
private _trigger = objNull;

if (_target isEqualType objNull) then {
    if (isNull _target) exitWith { _trigger; };
    _targetPos = getPos _target;
} else {
    if (!(_target isEqualTypeArray [0, 0, 0])) exitWith { _trigger; };
    _targetPos = +_target;
};

_area params [
    [Q(_a), 0, [0]]
    , [Q(_b), 0, [0]]
    , [Q(_angle), 0, [0]]
    , [Q(_isRectangle), false, [false]]
    , Q(_c)
];

_area = [_a, _b, _angle, _isRectangle];
if (!isNil { _c; }) then { _area pushBack _c; };

_activation params [
    [Q(_by), sideEmpty, [sideEmpty, ""]]
    , [Q(_type), true, [sideEmpty, true, ""]]
    , [Q(_repeating), true, [true]]
];

_activation = [
    [_by] call MFUNC(_verifyActivationBy)
    , [_type] call MFUNC(_verifyActivationType)
    , _repeating
];

private _createdTrigger = [
        _targetPos
        , "AREA:", _area
        , "ACT:", _activation
        , "STATE:", +MPRESET(_statements)
    ] call CBA_fnc_createTrigger;

_trigger = (_createdTrigger#0);

private _defaultOnCondition = {
    params [Q(_0), Q(_1), Q(_retval)];
    _retval;
};

private _defaultOnCallback = {};

_statementCallbacks params [
    [Q(_onCondition), _defaultOnCondition, [{}]]
    , [Q(_onActivation), _defaultOnCallback, [{}]]
    , [Q(_onDeactivation), _defaultOnCallback, [{}]]
];

private _uuid = [] call KPLIB_fnc_uuid_create_string;

{ _trigger setVariable _x; } forEach [
    [QMVAR(_uuid), _uuid]
    , [QMVAR(_target), _target]
    , [QMVAR(_targetPos), _targetPos]
    , [QMFUNC(_onCondition), _onCondition]
    , [QMFUNC(_onActivation), _onActivation]
    , [QMFUNC(_onDeactivation), _onDeactivation]
];

// private _trigger = [_target, _statements] call {
//     params [
//         [Q(_target), objNull, [objNull, []]]
//         , [Q(_statements), [], [[]]]
//         , [Q(_uuid), [] call KPLIB_fnc_uuid_create_string]
//     ];
//     _statements params [
//         [Q(_onCondition), _defaultOnCondition, [{}]]
//         , [Q(_onActivation), _defaultOnCallback, [{}]]
//         , [Q(_onDeactivation), _defaultOnCallback, [{}]]
//     ];
//     private _targetPos = if (_target isEqualType objNull) then { getPos _target; } else { _target; };
//     private _trigger = createTrigger [Q(EmptyDetector), _targetPos];
//     { _trigger setVariable _x; } forEach [
//         [QMVAR(_uuid), _uuid]
//         , [QMVAR(_target), _target]
//         , [QMVAR(_targetPos), _targetPos]
//         , [QMFUNC(_onCondition), _onCondition]
//         , [QMFUNC(_onActivation), _onActivation]
//         , [QMFUNC(_onDeactivation), _onDeactivation]
//     ];
//     _trigger enableSimulation false;
//     _trigger;
// };

// [_trigger, _area] call {
//     params [Q(_trigger), Q(_area)];
//     _area params [
//         [Q(_a), 0, [0]]
//         , [Q(_b), 0, [0]]
//         , [Q(_angle), 0, [0]]
//         , [Q(_isRectangle), false, [false]]
//         , Q(_c)
//     ];
//     if (isNil { _c; }) then {
//         _trigger setTriggerArea [_a, _b, _angle, _isRectangle];
//     } else {
//         _trigger setTriggerArea [_a, _b, _angle, _isRectangle, _c];
//     };
// };

// [_trigger, _activation] call {
//     params [Q(_trigger), Q(_activation)];
//     _activation params [
//         [Q(_by), sideEmpty, [sideEmpty, ""]]
//         , [Q(_type), true, [sideEmpty, true, ""]]
//         , [Q(_repeating), true, [true]]
//     ];
//     _trigger setTriggerActivation [
//         [_by] call MFUNC(_verifyActivationBy)
//         , [_type] call MFUNC(_verifyActivationType)
//         , _repeating
//     ];
// };

// [_trigger] call {
//     params [Q(_trigger)];
//     _trigger setTriggerStatements [
//         "[thisTrigger, thisList, this] call (thisTrigger getVariable 'KPLIB_fnc_triggers_onCondition')"
//         , "[thisTrigger, thisList] call (thisTrigger getVariable 'KPLIB_fnc_triggers_onActivation')"
//         , "[thisTrigger] call (thisTrigger getVariable 'KPLIB_fnc_triggers_onDeactivation')"
//     ];
// };

// TODO: TBD: this may be more bookkeeping than is worth it...
// TODO: TBD: especially if we can self-contain GC duties within itself...
[_trigger] call {
    params [Q(_trigger)];
    MVAR(_registry) set [_trigger getVariable QMVAR(_uuid), _trigger];
    _trigger;
};

// Return the TRIGGER so that we can do subsequent things like attach it to other objects
_trigger;