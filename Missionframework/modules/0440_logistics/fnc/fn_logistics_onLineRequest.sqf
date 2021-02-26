/*
    KPLIB_fnc_logistics_onLineRequest

    File: fn_logistics_onLineRequest.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 21:22:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Request either to add or remove some lines.

    Parameters:
        _toAdd - an array of UUID to add as logistic lines [ARRAY, default: []]
        _toRemove - an array of UUID to remove from the logistic lines [ARRAY, default: []]

    Returns:
        The number of lines added or removed [ARRAY, retval: [_added, _removed]]
            - _added - count of added UUID
            - _removed - count of removed UUID
 
    References:
        https://community.bistudio.com/wiki/findIf
        https://community.bistudio.com/wiki/deleteAt
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_deleteNamespace-sqf.html
 */

params [
    ["_toAdd", [], [[]]]
    , ["_toRemove", [], [[]]]
];

private _onSelectRemoved = {
    private _targetUuid = _x;

    private _i = KPLIB_logistic_namespaces findIf {
        private _uuid = getVariable "KPLIB_logistic_uuid";
        _uuid isEqualTo _targetUuid;
    };

    private _namespace = (KPLIB_logistic_namespaces deleteAt _i);

    if (!isNull _namespace) then {
        _namespace call CBA_fnc_deleteNamespace;
    };

    _i >= 0;
};

private _onSelectAdded = {
    private _uuid = _x;
    private _logistic = [_uuid] call KPLIB_fnc_logistics_createArray;
    private _namespace = [_logistic] call KPLIB_fnc_logistic_arrayToNamespace;
    private _i = KPLIB_logistics_namespaces pushBack _namespace;
    _i >= 0;
};

// TODO: TBD: assuming that the UUID are all distinct and unique...
private _removed = _toRemove select _onSelectRemoved;
private _added = _toAdd select _onSelectAdded;

[count _added, count _removed];
