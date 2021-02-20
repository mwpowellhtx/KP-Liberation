/*
    KPLIB_fnc_productionsm_onProductionMgrClosed

    File: fn_productionsm_onProductionMgrClosed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:02:58
    Last Update: 2021-02-18 20:03:01
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

private _debug = [] call KPLIB_fnc_productionsm_debug;

params [
    ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_productionsm_onProductionMgrClosed] Entering: [_cid]: %1"
        , str [_cid]], "PRODUCTION", true] call KPLIB_fnc_common_log;
};

if (_cid <= 0) exitWith {};

{
    private _namespace = _x;

    private _cids = _namespace getVariable ["_cids", []];
    _namespace setVariable ["_previousCids", (+_cids)];

    _cids = _cids - [_cid];
    _namespace setVariable ["_cids", _cids];

} forEach KPLIB_production_namespaces;

if (_debug) then {
    [format ["[fn_productionsm_onProductionMgrClosed] Finished: [_cid]: %1"
        , str [_cid]], "PRODUCTION", true] call KPLIB_fnc_common_log;
};
