/*
    KPLIB_fnc_logistics_getEndpoints

    File: fn_logistics_getEndpoints.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 17:18:33
    Last Update: 2021-02-25 17:27:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the current set of friendly factory endpoints plus any FOB zone
        endpoints. Returns them in grid reference order.

    Parameters:
        _namespaces - a set of known CBA production namespaces [ARRAY, default: KPLIB_production_namespaces]
        _fobs - a set of known FOB zone tuples [ARRAY, default: KPLIB_sectors_fobs]

    Returns:
        The current set of available logistics endpoints sorted by grid reference [ARRAY]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

params [
    ["_namespaces", KPLIB_production_namespaces, [[]]]
    , ["_fobs", KPLIB_sectors_fobs, [[]]]
];

// TODO: TBD: this needs to be refactored...
private _selectedNamespaces = _namespaces select {
    private _markerName = (_x getVariable ["KPLIB_production_markerName", ""]);
    _markerName in KPLIB_sectors_blufor;
};

private _factoryEndpoints = _selectedNamespaces apply {
    private _namespace = _x;
    private _markerName = _namespace getVariable "KPLIB_production_markerName";
    private _baseMarkerText = _namespace getVariable "KPLIB_production_baseMarkerText";
    [markerPos _markerName, _markerName, _baseMarkerText];
};

private _fobEndpoints = _fobs apply {
    private _fob = _x;
    private _pos = (_fob#4);
    private _markerName = (_fob#0);
    private _baseMarkerText = (_fob#1);
    [_pos, _markerName, _baseMarkerText];
};

private _onSortBy = {
    _x params [
        ["_pos", [], [[]]]
    ];
    private _gridref = mapGridPosition _pos;
    parseNumber _gridref;
};

private _retval = [(_factoryEndpoints + _fobEndpoints), _onSortBy] call {
    params [
        ["_endpoints", [], [[]]]
        , ["_algo", { 0; }, [{}]]
    ];
    [_endpoints, [], _algo] call BIS_fnc_sortBy;
};

_retval;
