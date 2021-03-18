/*
    KPLIB_fnc_productionSM_onPublish

    File: fn_productionSM_onPublish.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-18 00:01:34
    Last Update: 2021-02-18 19:41:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        ...

    Parameter(s):
        _cid - ... [SCALAR, default: -1]
        _viewData - ...

    Returns:
        The event handler is finished [BOOL]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { true; };

private _objSM = KPLIB_productionSM_objSM;

params [
    ["_cid", -1, [0]]
    , "_viewData"
];

private _allNamespaces = [];

private _debug = [
    [
        {KPLIB_param_productionSM_onPublish_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onPublish_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

if (isNil "_viewData") then {
    _allNamespaces = [] call KPLIB_fnc_production_getAllNamespaces;
    _viewData = _allNamespaces apply { [_x] call KPLIB_fnc_production_namespaceToArray; };
};

if (_debug) then {
    [format ["[fn_productionSM_onPublish] Publishing: [_cid, isNull _objSM, count _allNamespaces, count _viewData]: %1"
        , str [_cid, isNull _objSM, count _allNamespaces, count _viewData]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

if (_cid > 0) then {
    // Assumes that _viewData was indeed set correctly...
    [KPLIB_productionMgr_productionStatePublished, [_viewData], _cid] call CBA_fnc_ownerEvent;
};

if (_debug) then {
    ["[fn_productionSM_onPublish] Fini", "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

true;
