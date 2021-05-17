/*
    KPLIB_fnc_productionSM_onProductionMgrOpened

    File: fn_productionSM_onProductionMgrOpened.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 20:02:58
    Last Update: 2021-02-18 20:03:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onDialogClosed' event handler, responds when the client closes the
        dialog. Which effectively takes the client out of any further notification loops.

    Parameter(s):
        _refresh - ... [BOOL, default: false]
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
*/

private _debug = [
    [
        {KPLIB_param_productionSM_onProductionMgrOpened_debug}
    ]
] call KPLIB_fnc_productionSM_debug;

params [
    ["_refresh", false, [false]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_productionSM_onProductionMgrOpened] Entering: [_cid, _refresh]: %1"
        , str [_cid, _refresh]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

private _objSM = [KPLIB_productionSM_objSM, _cid] call {
    params [
        ["_objSM", locationNull, [locationNull]]
        , ["_cid", -1, [0]]
    ];

    if (_cid >= 0) then {
        ([_objSM, [
            ["KPLIB_production_cids", []]
            , ["KPLIB_production_cidsToPublish", []]
        ]] call KPLIB_fnc_namespace_getVars) params [
            "_cids"
            , "_cidsToPublish"
        ];

        private _opened = _cids pushBackUnique _cid;

        // May also be a request to refresh or re-publish
        if (_refresh) then {
            _cidsToPublish pushBackUnique _cid;
        };

        // There is no 'forced' just receive the manager announcement and await next cycles
        [_objSM, [
            ["KPLIB_production_cids", _cids]
            , ["KPLIB_production_cidsToPublish", _cidsToPublish]
        ]] call KPLIB_fnc_namespace_setVars;
    };

    _objSM;
};

[_cid] call KPLIB_fnc_productionSM_onPublish;

if (_debug) then {
    [format ["[fn_productionSM_onProductionMgrOpened] Fini: [_cid]: %1"
        , str [_cid]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
