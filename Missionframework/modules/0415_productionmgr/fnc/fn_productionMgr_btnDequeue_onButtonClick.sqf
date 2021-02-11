#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_btnDequeue_onButtonClick

    File: fn_productionMgr_btnDequeue_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-11 14:46:57
    Last Update: 2021-02-11 14:47:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull, unused]

    Returns:
        NONE

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
*/

// TODO: TBD: see notes concerning btnChangePriority ...
// TODO: TBD: there may be parallels sufficient to factoring into single callback-driven event handler...

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_ctrl", controlNull, [controlNull]]
];

if (_debug) then {
    ["[fn_productionMgr_btnDequeue_onButtonClick] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

private _markerName = [] call KPLIB_fnc_productionMgr_getSelectedMarkerName;

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _lnbQueue = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBQUEUE;

private _rowIndex = lnbCurSelRow _lnbQueue;

if (_markerName isEqualTo "" || _rowIndex <= 0) exitWith {

    if (_debug) then {
        [format ["[fn_productionMgr_btnDequeue_onButtonClick] Nothing selected: [_markerName, _rowIndex]: %1"
            , str [_markerName, _rowIndex]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };

    true;
};

private _queue = [] call KPLIB_fnc_productionMgr_getSelectedQueue;

private _candidateQueue = +_queue;

// Adjusting for the LNB 'header' row...
private _queueIndex = _rowIndex - 1;

/* In case we need to report the resource index... Not the index
 * in the queue, but rather the actual 'resource' index... */

private _resourceIndex = _candidateQueue deleteAt _queueIndex;

private _eventName = "KPLIB_productionMgr_onRequestQueueChange";

if (_debug) then {
    [format ["[fn_productionMgr_btnDequeue_onButtonClick] Server event: [_eventName, _markerName, _queue, _candidateQueue, _queueIndex, _resourceIndex, _cid]: %1"
        , str [_eventName, _markerName, _queue, _candidateQueue, _queueIndex, _resourceIndex, clientOwner]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

[_eventName, [_markerName, _candidateQueue, clientOwner]] spawn CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_productionMgr_btnDequeue_onButtonClick] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
