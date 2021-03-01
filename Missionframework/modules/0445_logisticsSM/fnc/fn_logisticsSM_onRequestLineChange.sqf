/*
    KPLIB_fnc_logisticsSM_onRequestLineChange

    File: fn_logisticsSM_onRequestLineChange.sqf
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
        {KPLIB_logisticsSM_onRequestLineChange_debug}
    ]
] call KPLIB_fnc_logisticsSM_debug;

// TODO: TBD: could perhaps run this through a more formal "change request" queue, eventually...
// TODO: TBD: especially as we flesh out the logistics SM, etc...

params [
    ["_toAdd", [], [[]]]
    , ["_toRemove", [], [[]]]
    , ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsSM_onRequestLineChange] Entering: [_toAdd, _toRemove, _cid]: %1"
        , str [_toAdd, _toRemove, _cid]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: should not allow lines to be removed that are not currently in STANDBY status...
// TODO: TBD: better still, should disable the remove button altogether when that selection is made...
private _onFilterActiveLines = {
    private _targetUuid = _x;

    KPLIB_logistics_namespaces findIf {
        private _uuid
    };

};

private _onSelectRemoved = {
    private _targetUuid = _x;

    // We want only logistics lines that match UUID and are in STANDBY
    private _i = KPLIB_logistics_namespaces findIf {
        private _uuid = _x getVariable ["KPLIB_logistics_uuid", ""];
        private _status = _x getVariable ["KPLIB_logistics_status", KPLIB_logistics_status_na];
        _uuid isEqualTo _targetUuid
            && _status == KPLIB_logistics_status_standby;
    };

    // TODO: TBD: might do more logging here...
    if (_i < 0) exitWith {
        false;
    };

    // Deleted logistics line namespace with best effort
    private _namespace = KPLIB_logistics_namespaces deleteAt _i;

    _namespace call CBA_fnc_deleteNamespace;

    true;
};

private _onSelectAdded = {
    private _uuid = _x;
    private _logistic = [_uuid] call KPLIB_fnc_logistics_createArray;
    private _namespace = [_logistic] call KPLIB_fnc_logistics_arrayToNamespace;
    private _i = KPLIB_logistics_namespaces pushBack _namespace;
    _i >= 0;
};

_toAdd = _toAdd apply { [] call KPLIB_fnc_uuid_create_string; };

// TODO: TBD: assuming that the UUID are all distinct and unique...
private _removed = _toRemove select _onSelectRemoved;
private _added = _toAdd select _onSelectAdded;

// TODO: TBD: notify the client, or turn around and re-publish...
private _cids = KPLIB_logisticsSM_namespace getVariable ["KPLIB_logistics_cids", []];

private _counts = [
    count _added
    , count _removed
    , {
        // Publish the new set of logistics lines to all cataloged managers
        [_x] call KPLIB_fnc_logisticsSM_onPublishLines;
        true;
    } count _cids
];

private _retval = (_counts#0) == (count _toAdd)
    && (_counts#1) == (count _toRemove)
    && (_counts#2) == (count _cids);

if (_debug) then {
    [format ["[fn_logisticsSM_onRequestLineChange] Fini: [_toAdd, _toRemove, count _cids, _counts]: %1"
        , str [_toAdd, _toRemove, count _cids, _counts]], "LOGISTICSSM", true] call KPLIB_fnc_common_log;
};

_retval;
