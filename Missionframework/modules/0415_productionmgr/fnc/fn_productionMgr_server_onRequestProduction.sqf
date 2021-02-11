/*
    KPLIB_fnc_productionMgr_server_onRequestProduction

    File: fn_productionMgr_server_onRequestProduction.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onRequestProduction' event handler, responds to the
        'KPLIB_productionMgr_onRequestProduction' CBA server event. Response with the
        'KPLIB_productionMgr_onProductionResponse' owner (i.e. client) event.

    Parameter(s):
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_server_onRequestProduction] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_cid", -1, [0]]
];

if (_cid <= 0) exitWith {

    if (_debug) then {
        ["[fn_productionMgr_server_onRequestProduction] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };
};

/* Which we will use downstream from here to post updates
 * to all currently known production manager clients. */

if (!(_cid in KPLIB_productionMgr_clientOwners)) then {
    KPLIB_productionMgr_clientOwners pushBack _cid;
};

private _production = KPLIB_production select {(_x#0#0) in KPLIB_sectors_blufor};

["KPLIB_productionMgr_onProductionResponse", [_production], _cid] call CBA_fnc_ownerEvent;

if (_debug) then {
    [format ["[fn_productionMgr_server_onRequestProduction] Finished: [_cid]: %1"
        , str [_cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};
