/*
    KPLIB_fnc_productionMgr_server_onDialogClosed

    File: fn_productionMgr_server_onDialogClosed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-11 11:31:10
    Last Update: 2021-02-11 11:31:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onDialogClosed' event handler, responds when the client closes the
        dialog. Which effectively takes the client out of any further notification loops.

    Parameter(s):
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_server_onDialogClosed] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_cid", -1, [0]]
];

if (_cid <= 0) exitWith {

    if (_debug) then {
        ["[fn_productionMgr_server_onDialogClosed] Finished.", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
    };
};

// Simply this
KPLIB_productionMgr_clientOwners = KPLIB_productionMgr_clientOwners - [_cid];

if (_debug) then {
    [format ["[fn_productionMgr_server_onDialogClosed] Finished: [_cid]: %1"
        , str [_cid]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};
