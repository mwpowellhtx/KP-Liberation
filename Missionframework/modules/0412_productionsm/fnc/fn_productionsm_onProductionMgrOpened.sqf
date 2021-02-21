/*
    KPLIB_fnc_productionsm_onProductionMgrOpened

    File: fn_productionsm_onProductionMgrOpened.sqf
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

private _debug = [
    [
        "KPLIB_param_productionsm_productionMgr_debug"
    ]
] call KPLIB_fnc_productionsm_debug;

params [
    ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_productionsm_onProductionMgrOpened] Entering: [_cid, _forced]: %1"
        , str [_cid, _forced]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (_cid <= 0) exitWith {};

private _objSM = KPLIB_productionsm_objSM;
private _productionList = _objSM getVariable ["CBA_statemachine_list", []];

/* Must do this for each known production namespace. This is because the statemachine event
 * loop runs per production namespace, including new or existing publish notifications. */

private _forcedCids = _objSM getVariable ["KPLIB_productionsm_forcedCids", []];
_objSM setVariable ["KPLIB_productionsm_forcedCids", (_forcedCids + [_cid])];

private _cids = _objSM getVariable ["KPLIB_productionsm_cids", []];
_objSM setVariable ["KPLIB_productionsm_cids", (_cids + [_cid])];

// Any of the SM namespaces will do, serves as a trigger for the event only
private _namespace = (_productionList#0);

// Local event assuming this callback was invoked server side
["KPLIB_productionsm_onPublishProductionState", [_namespace]] call CBA_fnc_localEvent;

if (_debug) then {
    [format ["[fn_productionsm_onProductionMgrOpened] Finished: [_cid]: %1"
        , str [_cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};
