/*
    KPLIB_fnc_productionServer_onRequestProduction

    File: fn_productionServer_onRequestProduction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-17 10:31:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onRequestProduction' event handler, responds to the
        'KPLIB_productionServer_onRequestProduction' CBA server event. Response with the
        'KPLIB_productionMgr_onProductionResponse' owner (i.e. client) event.

    Parameter(s):
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _debug = [] call KPLIB_fnc_production_debug;

if (_debug) then {
    ["[fn_productionServer_onRequestProduction] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_cid", -1, [0]]
];

if (_cid <= 0) exitWith {

    if (_debug) then {
        ["[fn_productionServer_onRequestProduction] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };
};

/* Which we will use downstream from here to post updates
 * to all currently known production manager clients. */

// TODO: TBD: it is a bit of an overlap with productionMgr, but this function belongs here...
if (!(_cid in KPLIB_productionMgr_clientOwners)) then {
    KPLIB_productionMgr_clientOwners pushBack _cid;
};

private _production = KPLIB_production select {
    private _markerName = _x getVariable ["_markerName", ""];
    _markerName in KPLIB_sectors_blufor;
} apply {
    _x call KPLIB_fnc_production_namespaceToArray;
};

["KPLIB_productionClient_onProductionResponse", _production, _cid] call CBA_fnc_ownerEvent;

if (_debug) then {
    [format ["[fn_productionServer_onRequestProduction] Finished: [_cid]: %1"
        , str [_cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};
