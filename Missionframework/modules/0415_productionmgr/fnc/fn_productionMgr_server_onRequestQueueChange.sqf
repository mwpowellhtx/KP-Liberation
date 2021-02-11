/*
    KPLIB_fnc_productionMgr_server_onRequestQueueChange

    File: fn_productionMgr_server_onRequestQueueChange.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 20:59:47
    Last Update: 2021-02-10 20:59:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onRequestQueueChange' event handler, responds to the
        'KPLIB_productionMgr_onRequestQueueChange' CBA server event. Responds with
        the 'KPLIB_productionMgr_onQueueChangeResponse' owner (i.e. client) event.

        More specifically, the change request process takes into consideration
        a few basic criteria:

            - whether the array itself changed
            - whether queue depth is permissible given the settings
            - changes to the pending element requires a reset in the timer

    Parameter(s):
        _markerName - the factory sector '_markerName' receiving the change request [STRING, default: ""]
        _queue - the '_productionElem' '_queue' encompassing the desired change [ARRAY, default: []]
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

params [
    ["_markerName", "", [""]]
    , ["_queue", [], [[]]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_productionMgr_server_onRequestQueueChange] Entering: [_markerName, _queue, _cid]: %1"
        , str [_markerName, _queue, _cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    [format ["[fn_productionMgr_server_onRequestQueueChange] Finished: [_markerName, _cid]: %1"
        , str [_markerName, _cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};
