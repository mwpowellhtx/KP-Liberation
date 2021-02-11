/*
    KPLIB_fnc_productionMgr_server_onOwnerProductionElem

    File: fn_productionMgr_server_onOwnerProductionElem.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 20:59:47
    Last Update: 2021-02-10 20:59:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onRequestQueueChange' event handler, responds to the
        'KPLIB_productionMgr_onRequestQueueChange' CBA server event. Responds with
        the 'KPLIB_productionMgr_onProductionElemResponse' owner (i.e. client) event.

        More specifically, the change request process takes into consideration
        a few basic criteria:

            1. whether queue depth is permissible given the settings
            2. whether the array itself changed
            3. and whether candidate queue aligned with production cap
            4. changes to the pending element requires a reset in the timer

    Parameter(s):
        _markerName - the factory sector '_markerName' receiving the change request [STRING, default: ""]
        _candidateQueue - the '_productionElem' '_candidateQueue' encompassing the desired change [ARRAY, default: []]
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _productionElem = _this;

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    [format ["[fn_productionMgr_server_onOwnerProductionElem] Entering: [_markerName]: %1"
        , str [_productionElem#0#0]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

/* Respond to the server request with this specific element only... Also noteworthy,
 * update all currently known clients with the change in production element. */

{
    ["KPLIB_productionMgr_onProductionElemResponse", _productionElem, _x] call CBA_fnc_ownerEvent;
    //                                                                ^^ each known ownerClient
} forEach KPLIB_productionMgr_clientOwners;

if (_debug) then {
    ["[fn_productionMgr_server_onOwnerProductionElem] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};
