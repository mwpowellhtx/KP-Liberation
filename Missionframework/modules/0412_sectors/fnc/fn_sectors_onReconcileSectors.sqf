#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onReconcileSectors

    File: fn_sectors_onReconcileSectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-06-14 16:51:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Reconciles, self-heals, the CBA SECTORS namespaces with currently known
        mission sector markers.

    Parameters:
        _namespaces - the CBA SECTORS namespaces to reconcile [ARRAY, default: []]

    Returns:
        The reconciled namespaces [ARRAY]

    Remarks:
        One key note, we happen to know that "local", rather, "not global" CBA namespaces
        are created, then these are actually an Arma 3 LOCATION vis-a-vis line 34. So, we
        will leverage that to the hilt.

    References:
        https://community.bistudio.com/wiki/Location
        https://community.bistudio.com/wiki/createLocation
        https://community.bistudio.com/wiki/setPosition
        https://community.bistudio.com/wiki/nearestLocations
        https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_createNamespace.sqf
        https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_createNamespace.sqf#L34
        https://community.bistudio.com/wiki/Category:Command_Group:_Locations

        // TODO: TBD: might be able to do things like 'setting type', i.e. 'factory', 'radio tower', etc...
        https://community.bistudio.com/wiki/setType
        // TODO: TBD: see also: 'CfgLocationTypes'
 */

private _debug = MPARAM(_onReconcileSectors_debug);

params [
    [Q(_namespaces), [], [[]]]
];

if (_debug) then {
    [format ["[fn_sectors_onReconcileSectors] Entering: []: %1"
        , str [count _namespaces]], "SECTORS"] call KPLIB_fnc_common_log;
};

private _reconciled = +_namespaces;

// Identify namespaces for GC
private _namespacesForGc = _namespaces select {
    private _targetMarker = _x getVariable QMVAR(_markerName);
    private _all = _targetMarker in MVAR(_all);
    !_all;
};

// Namespaces minus those that are no longer on mission
_reconciled = _reconciled - _namespacesForGc;

// 'New' sectors that might have been added or updated as the case may be
private _namespacesToAppend = MVAR(_all) select {
    private _targetMarker = _x;
    private _sectorIndex = _namespaces findIf {
        private _markerName = _x getVariable QMVAR(_markerName);
        _targetMarker isEqualTo _markerName;
    };
    _sectorIndex < 0;
} apply {
    [_x] call MFUNC(_createSector);
};

// Append when there is something to append
if (count _namespacesToAppend > 0) then {
    _reconciled append _namespacesToAppend;
};

if (_debug) then {
    [format ["[fn_sectors_onReconcileSectors] Reconciled: [count _reconciled, count _namespacesForGc, count _namespacesToAppend]: %1"
        , str [count _reconciled, count _namespacesForGc, count _namespacesToAppend]], "SECTORS"] call KPLIB_fnc_common_log;
};

/* Self-heal STATUS and POSITION; the intent here is not to 'replace' the map markers. Indeed,
 * we do not think this is possible, least of all without introducing static location based
 * configuration classes. That is not what we want to do, but rather, to leave the map portion
 * as loosely coupled from the sister framework as possible. So, in a word, rather the goal here
 * is to augment the markers with a more elaborate sitrep. */

{
    private _namespace = _x;
    private _markerName = _namespace getVariable QMVAR(_markerName);
    private _markerPos = markerPos _markerName;
    // This is key, we will be able to probe the variables as well:
    _namespace setPosition _markerPos;
    //         ^^^^^^^^^^^^^^^^^^^^^^
    { _namespace setVariable _x; } forEach [
        [QMVAR(_markerPos), _markerPos]
        //                  ^^^^^^^^^^
        , [QMVAR(_gridref), mapGridPosition _markerPos]
    ];
} forEach _reconciled;

if (_debug) then {
    ["[fn_sectors_onReconcileSectors] Fini", "SECTORS"] call KPLIB_fnc_common_log;
};

_reconciled;
