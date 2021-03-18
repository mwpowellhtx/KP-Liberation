/*
    KPLIB_fnc_productionSM_onGetList

    File: fn_productionSM_onGetList.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-17 13:35:06
    Last Update: 2021-03-17 13:35:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the production array for use with its state machine. This is also
        the moment when changes are evaluated concerning whether to broadcast to
        subscribed production manager clients.

    Parameter(s):
        NONE

    Returns:
        The array of BLUFOR aligned CBA PRODUCTION namespaces [ARRAY]
 */

if (isNil "KPLIB_productionSM_objSM") exitWith { []; };

private _objSM = KPLIB_productionSM_objSM;

private _debug = [
    [
        {KPLIB_param_productionSM_onGetList_debug}
        , { _objSM getVariable ["KPLIB_param_productionSM_onGetList_debug", false]; }
    ]
] call KPLIB_fnc_productionSM_debug;

[_objSM, [] call KPLIB_fnc_production_getAllNamespaces] call {
    params [
        ["_objSM", locationNull, [locationNull]]
        , ["_allNamespaces", [], [[]]]
    ];

    if (_debug) then {
        [format ["[fn_productionSM_onGetList::call] Namespaces: [isNull _objSM, count _allNamespaces]: %1"
            , str [isNull _objSM, count _allNamespaces]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
    };

    [_objSM, [
        ["KPLIB_production_allNamespaces", _allNamespaces]
    ]] call KPLIB_fnc_namespace_setVars;

    _objSM;
};

([_objSM, [
    ["KPLIB_production_allNamespaces", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_allNamespaces"
];

if (_debug) then {
    [format ["[fn_productionSM_onGetList] Broadcasting: [count _allNamespaces]: %1"
        , str [count _allNamespaces]], "PRODUCTIONSM", true] call KPLIB_fnc_common_log;
};

[_allNamespaces] call KPLIB_fnc_productionSM_onBroadcast;

_allNamespaces;
