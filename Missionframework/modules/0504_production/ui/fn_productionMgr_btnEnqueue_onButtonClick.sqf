/*
    KPLIB_fnc_productionMgr_btnEnqueue_onButtonClick

    File: fn_productionMgr_btnEnqueue_onButtonClick.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 19:17:51
    Last Update: 2021-02-11 09:47:57
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Apply the candidate queue changes to the server for consideration.

    Parameter(s):
        _ctrl - the button control [CONTROL, default: controlNull, unused]
        _args - the resource args to enqueue, three values are accepted [ARRAY, default: []]
            - while we will ignore default arguments, expected values are:
                [0] supply
                [1] ammo
                [2] fuel

    Returns:
        The module event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onButtonClick
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html
*/

private _debug = [
    [
        {KPLIB_param_productionMgr_btnEnqueue_onButtonClick_debug}
    ]
] call KPLIB_fnc_productionMgr_debug;

params [
    ["_ctrl", controlNull, [controlNull]]
    , ["_args", [], [[]]]
];

if (_debug) then {
    [format ["[fn_productionMgr_btnEnqueue_onButtonClick] Entering: _args: %1"
        , str _args], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

_args params [
    ["_resourceIndex", -1, [0]]
];

// May be empty (i.e. '') when nothing selected yet
private _markerName = [] call KPLIB_fnc_productionMgr_getSelectedMarkerName;

/* Bypass when either nothing selected of desired candidate queue would be invalid.
 * Resource index "should" be in range, but if for any reason it is not, then simply bypass. */

if (_markerName isEqualTo "" || !(_resourceIndex in KPLIB_resources_indexes)) exitWith {

    if (_debug) then {
        [format ["[fn_productionMgr_btnEnqueue_onButtonClick] Bypassed: [_markerName, _resourceIndex]: %1"
            , str [_markerName, _resourceIndex]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };

    true;
};

private _queue = [] call KPLIB_fnc_productionMgr_getSelectedQueue;

// Always append enqueued resource requests to the tail of the queue
private _candidateQueue = _queue + [_resourceIndex];

if (_debug) then {
    [format ["[fn_productionMgr_btnEnqueue_onButtonClick] Server event: [_markerName, _queue, _candidateQueue, _cid]: %1"
        , str [_markerName, _queue, _candidateQueue, clientOwner]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

[KPLIB_productionCO_requestChangeQueue, [_markerName, _candidateQueue, clientOwner]] spawn CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_productionMgr_btnEnqueue_onButtonClick] Fini", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
