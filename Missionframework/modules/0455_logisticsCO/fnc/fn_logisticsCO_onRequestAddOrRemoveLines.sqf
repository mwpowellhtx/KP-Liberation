/*
    KPLIB_fnc_logisticsCO_onRequestAddOrRemoveLines

    File: fn_logisticsCO_onRequestAddOrRemoveLines.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 20:38:56
    Last Update: 2021-02-28 20:39:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Request either to add or remove some lines. Publishes the new set of lines
        to the cataloged managers afterwards.

    Parameters:
        _toAdd - an array of UUID to add as logistic lines [ARRAY, default: []]
        _toRemove - an array of UUID to remove from the logistic lines [ARRAY, default: []]
        _cid - the client identifier originating the request [SCALAR, default: -1]

    Returns:
        The number of lines added or removed [ARRAY, retval: [_added, _removed]]
            - _added - count of added UUID
            - _removed - count of removed UUID
 
    References:
        https://community.bistudio.com/wiki/findIf
        https://community.bistudio.com/wiki/deleteAt
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_deleteNamespace-sqf.html
 */

private _debug = [
    [
        {KPLIB_param_logisticsCO_onRequestAddOrRemoveLines_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

params [
    ["_toAdd", [], [[]]]
    , ["_toRemove", [], [[]]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsCO_onRequestAddOrRemoveLines] Entering: [_toAdd, _toRemove, _cid]: %1"
        , str [_toAdd, _toRemove, _cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

([KPLIB_logisticsSM_objSM, [
    ["KPLIB_logistics_uuidToRemove", []]
    , ["KPLIB_logistics_namespacesToAdd", []]
]] call KPLIB_fnc_namespace_getVars) params [
    "_uuidToRemove"
    , "_namespacesToAdd"
];

private _tryStageUuidToRemove = {
    private _i = _uuidToRemove pushBackUnique _x;
    _i >= 0;
};

private _tryStageNamespaceToAdd = {

    private _logistic = [] call KPLIB_fnc_logistics_createArray;

    private _namespace = [_logistic] call KPLIB_fnc_logistics_arrayToNamespace;

    /* By default, brand new logistics lines do not require rebasing...
     * In fact, their timers will not be running to begin with. */
    [_namespace, [
        ["KPLIB_logistics_shouldRebase", false]
        , ["KPLIB_logistics_rebased", true]
    ]] call KPLIB_fnc_namespace_setVars;

    private _i = _namespacesToAdd pushBack _namespace;

    _i >= 0;
};

private _removed = _toRemove select _tryStageUuidToRemove;
private _added = _toAdd select _tryStageNamespaceToAdd;

[KPLIB_logisticsSM_objSM, [
    ["KPLIB_logistics_uuidToRemove", _uuidToRemove]
    , ["KPLIB_logistics_namespacesToAdd", _namespacesToAdd]
]] call KPLIB_fnc_namespace_setVars;

private _counts = [
    count _added
    , count _removed
];

private _retval = (_counts#0) == (count _toAdd)
    && (_counts#1) == (count _toRemove);

if (_debug) then {
    [format ["[fn_logisticsCO_onRequestAddOrRemoveLines] Fini: [_toAdd, _toRemove, _counts]: %1"
        , str [_toAdd, _toRemove, _counts]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_retval;
