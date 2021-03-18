/*
    KPLIB_fnc_productionSM_onProductionMgrClosed

    File: fn_productionSM_onProductionMgrClosed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:02:58
    Last Update: 2021-03-17 14:23:07
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
        {KPLIB_param_productionSM_onProductionMgrClosed_debug}
    ]
] call KPLIB_fnc_productionSM_debug;

params [
    ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_productionSM_onProductionMgrClosed] Entering: [_cid]: %1"
        , str [_cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _objSM = [KPLIB_productionSM_objSM] call {
    params [
        ["_objSM", locationNull, [locationNull]]
    ];

    ([_objSM, [
        ["KPLIB_production_cids", []]
        , ["KPLIB_production_cidsToPublish", []]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_cids"
        , "_cidsToPublish"
    ];

    [_objSM, [
        ["KPLIB_production_cids", +(_cids - [_cid])]
        , ["KPLIB_production_cidsToPublish", +(_cidsToPublish - [_cid])]
    ]] call KPLIB_fnc_namespace_setVars;

    _objSM;
};

if (_debug) then {
    [format ["[fn_productionSM_onProductionMgrClosed] Fini: [_cid]: %1"
        , str [_cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
