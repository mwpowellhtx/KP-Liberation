/*
    KPLIB_fnc_productionServer_onOwnerProductionElem

    File: fn_productionServer_onOwnerProductionElem.sqf
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
        _namespace - the CBA production namespace being posted to each of the listeners [LOCATION]

    Returns:
        NONE
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

private _namespace = _this;

private _productionElem = _namespace call KPLIB_fnc_production_namespaceToArray;

if (_debug) then {
    [format ["[fn_productionServer_onOwnerProductionElem] Entering: [_markerName]: %1"
        , str [(_namespace getVariable ["_markerName", KPLIB_production_markerNameDefault])]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

/* Respond to the server request with this specific element only... Also noteworthy,
 * update all currently known clients with the change in production element. */

{
    ["KPLIB_productionMgr_onProductionElemResponse", _productionElem, _x] call CBA_fnc_ownerEvent;
    //                                                                ^^ each known ownerClient
} forEach KPLIB_productionMgr_clientOwners;

if (_debug) then {
    ["[fn_productionServer_onOwnerProductionElem] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};
