/*
    KPLIB_fnc_production_onReconcile

    File: fn_production_onReconcile.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-04 17:05:28
    Last Update: 2021-02-17 11:17:42
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reconciles the loaded '_this' array of CBA production namespaces versus the 'KPLIB_sectors_factory' array.

    Parameter(s):
        _this - reconciles the given array of CBA production namespaces with 'KPLIB_sectors_factory' [ARRAY, default: []]

    Returns:
        An up to date array of CBA production '_namespaces'.
*/

private _debug = [] call KPLIB_fnc_production_debug;

params [
    ["_namespaces", [], [[]]]
];

// Pick them up only once
private _sectors = +KPLIB_sectors_factory;

if (_debug) then {
    [format ["[fn_production_onReconcile] Discovered %1 sectors: %2"
        , count _sectors, str _sectors], "PRODUCTION", true] call KPLIB_fnc_common_log;
};

/*
    After dropping now-deleted markers, and picking up new ones. Note, we do not
    need to use the index variables themselves, but we do need to be aware of the
    appropriate indices, i.e.
        KPLIB_production_i_ident = 0
        KPLIB_production_ident_i_markerName = 0
 */
private _staged = _namespaces select {
    private _markerName = _x getVariable ["_markerName", KPLIB_production_markerNameDefault];
    _markerName in _sectors;
};

private _currentMarkerNames = _staged apply { _x getVariable ["_markerName", KPLIB_production_markerNameDefault]; };
private _pendingCreate = _sectors select { !(_x in _currentMarkerNames); };

if (_debug) then {
    [format ["[fn_production_onReconcile] [count _pendingCreate, _pendingCreate]: %1"
        , str [count _pendingCreate, _pendingCreate]], "PRODUCTION", true] call KPLIB_fnc_common_log;
};

// Then append any newly discovered sectors
_staged append (_pendingCreate apply { [_x] call KPLIB_fnc_production_create; });

if (_debug) then {
    [format ["[fn_production_onReconcile] %1 sectors created", count _staged], "PRODUCTION", true] call KPLIB_fnc_common_log;
};

// Last but not least arrange the production tuples by sector order
private _retval = _sectors apply {
    private _sectorName = _x;
    // Which by this point finding should be guaranteed
    private _i = _staged findIf {
        private _markerName = _x getVariable ["_markerName", KPLIB_production_markerNameDefault];
        _markerName isEqualTo _sectorName;
    };
    _staged select _i;
};

// TODO: TBD: so... we are rendering some marker text here... should we be leaving that for a per frame handler object (?)

/* And render the production sector '_markerText', which may be re-rendered at any
 * future point based on capability updates, sector alignment, etc. */
_retval = _retval apply { [_x] call KPLIB_fnc_production_onRenderMarkerText; };

+_retval;
