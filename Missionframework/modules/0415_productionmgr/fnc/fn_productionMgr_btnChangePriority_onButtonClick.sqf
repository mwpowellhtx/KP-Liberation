#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_btnChangePriority_onButtonClick

    File: fn_productionMgr_btnChangePriority_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 19:17:51
    Last Update: 2021-02-11 13:03:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adjusts the priority for the currently selected resource production queue item
        in either direction, positive or negative. Note this has the inverse swap effect
        to the indicated direction. Meaning, increased priority means diminished indexing,
        and vice versa.

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull, unused]
        _direction - the direction of change, increase or decrease, two values are accepted [SCALAR, default: 0]
            [1] increase in priority, move the value up one position in the queue;
            [-1] decrease in priority, move the value down one position in the queue
            - although we also allow for any positive or negative value to indicate direction

    Returns:
        NONE

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
*/

// TODO: TBD: one observation, we think there "may" be similarities between priority and dequeue events...
// TODO: TBD: MAYBE...
// TODO: TBD: may consider whether there is enough of a similarity that we can consolidate...
// TODO: TBD: probably involving a decoupled callback injection somewhere along the way
// TODO: TBD: without getting too fancy or cute...
// TODO: TBD: summarizing, we will not start there with that as the goal, but if we can refactor, then we may, later on

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_ctrl", controlNull, [controlNull]]
    , ["_args", [], [[]]]
];

_args params [
    ["_direction", 0, [0]]
];

if (_debug) then {
    [format ["[fn_productionMgr_btnChangePriority_onButtonClick] Entering: [_direction]: %1"
        , str [_direction]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// Normalize _direction in either 'direction' so to speak...
_direction = (_direction max -1) min 1;

// Accounting for the corner cases, though should never be the case considering UI integration
if (_direction isEqualTo 0) exitWith {

    if (_debug) then {
        [format ["[fn_productionMgr_btnChangePriority_onButtonClick] No change: [_direction]: %1"
            , str [_direction]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };

    true;
};

private _markerName = [] call KPLIB_fnc_productionMgr_getSelectedMarkerName;

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _lnbQueue = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBQUEUE;

private _rowIndex = lnbCurSelRow _lnbQueue;

if (_markerName isEqualTo "" || _rowIndex <= 0) exitWith {

    if (_debug) then {
        [format ["[fn_productionMgr_btnChangePriority_onButtonClick] Nothing selected: [_markerName, _rowIndex]: %1"
            , str [_markerName, _rowIndex]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };

    true;
};

private _queue = [] call KPLIB_fnc_productionMgr_getSelectedQueue;

// Adjusting for the LNB 'header' row...
private _queueIndex = _rowIndex - 1;
// Because we need to invert for the true index...
private _targetIndex = _queueIndex - _direction;

if (_debug) then {
    [format ["[fn_productionMgr_btnChangePriority_onButtonClick] Conditioning swap: [_markerName, _direction, _queue, _rowIndex, _queueIndex, _targetIndex]: %1"
        , str [_markerName, _direction, _queue, _rowIndex, _queueIndex, _targetIndex]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// Will not be dealing with any wrap around scenarios, so simply constraint the target index range
if (_targetIndex >= 0 && _targetIndex < count _queue) then {

    // Then only conduct the change request when there will be a discernible difference
    if (!((_queue select _queueIndex) isEqualTo (_queue select _targetIndex))) then {

        // TODO: TBD: formalize this to first class cfg function (?)
        private _candidateQueue = [+_queue, _queueIndex, _targetIndex] call {
            params [
                ["_values", [], [[]]]
                , ["_i", 0, [0]]
                , ["_j", 0, [0]]
            ];
            [
                _values select _i
                , _values select _j
            ] params [
                // Note the swap in the pattern...
                ["_jval", 0, [0]]
                , ["_ival", 0, [0]]
            ];
            // Then simply re-set and return, should be swap aligned...
            _values set [_i, _ival];
            _values set [_j, _jval];

            _values;
        };

        private _eventName = "KPLIB_productionsm_onRequestQueueChange";

        if (_debug) then {
            [format ["[fn_productionMgr_btnChangePriority_onButtonClick] Server event: [_eventName, _markerName, _queue, _candidateQueue, _queueIndex, _targetIndex, _cid]: %1"
                , str [_eventName, _markerName, _queue, _candidateQueue, _queueIndex, _targetIndex, clientOwner]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
        };

        [_eventName, [_markerName, _candidateQueue, clientOwner]] spawn CBA_fnc_serverEvent;

    } else {
        if (_debug) then {
            //                                                  Meaning: NO CHANGE
            [format ["[fn_productionMgr_btnChangePriority_onButtonClick] No change: [_markerName, _queue, _queueIndex, _targetIndex, _cid]: %1"
                , str [_markerName, _queue, _queueIndex, _targetIndex, clientOwner]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
        };
    };
};

if (_debug) then {
    ["[fn_productionMgr_btnChangePriority_onButtonClick] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
