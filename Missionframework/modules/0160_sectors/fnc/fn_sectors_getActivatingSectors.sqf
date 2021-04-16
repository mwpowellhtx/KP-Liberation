#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getActivatingSectors

    File: fn_sectors_getActivatingSectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-07 16:57:12
    Last Update: 2021-04-10 12:59:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the potentially ACTIVATING SECTORS for consideration by the state machine
        GET SECTOR LIST callback. For now we focus on just those SECTORS potentially being
        activated that are done so by BLUFOR UNITS, but could very easily see this happening
        for OPFOR UNITS as well, i.e. during aspects such as REINFORCE, COUNTERATTACK, etc.

    Parameter(s):
        NONE

    Returns:
        A next set of ACTIVATING SECTORS [ARRAY]

    References:
        https://community.bistudio.com/wiki/select#Alternative_Syntax_4
        https://community.bistudio.com/wiki/distance2D
        https://community.bistudio.com/wiki/getPos
        https://community.bistudio.com/wiki/getPosATL
        https://community.bistudio.com/wiki/sort
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

private _debug = MPARAM(_getActivatingSectors_debug);

if (_debug) then {
    [format ["[fn_sectors_getActivatingSectors] Entering: [count MVAR(_active)]: %1"
        , str [count MVAR(_active)]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// The ACTIVATING SECTOR marker names themselves
private _activatingSectors = [];

// TODO: TBD: which may also trigger a HUD...
// Already reached maximum sector activation
if (count MVAR(_active) >= MPARAM(_maxAct)) exitWith {
    if (_debug) then {
        ["[fn_sectors_getActivatingSectors] Max sectors", "SECTORS", true] call KPLIB_fnc_common_log;
    };
    // Which should be empty, but for emphasis we want the NAMESPACES not the MARKER NAMES
    _activatingSectors;
};

private _inactiveSectors = MVAR(_all) - MVAR(_active);
private _targetActivatingCount = MPARAM(_maxAct) - (count MVAR(_active));

// TODO: TBD: for now including just BLUFOR activation...
// TODO: TBD: but could very easily see OPFOR activation being a thing...
// TODO: TBD: i.e. [KPLIB_preset_sideF, KPLIB_preset_sideE]
// TODO: TBD: which would, of course, shift how sectors are dealt with...
private _getMinimumUnitRange = {
    params [
        [Q(_markerName), "", [""]]
        , [Q(_ascending), true, [true]]
    ];
    private _markerPos = markerPos _markerName;
    private _units = [_markerPos, MPARAM(_actRange), [KPLIB_preset_sideF]] call KPLIB_fnc_units_getNear;
    // We do not care about the unit itself we just need the range
    private _ranges = _units apply { _x distance2D _markerPos; };
    _ranges sort _ascending;
    _ranges params [
        [Q(_range), -1, [0]]
    ];
    _range;
};

// Identify SECTORS with UNITS within any range
private _sectorRanges = _inactiveSectors apply { [_x, [_x] call _getMinimumUnitRange]; } select { (_x#1) >= 0; };

if (_debug) then {
    [format ["[fn_sectors_getActivatingSectors] Activating: [count _sectorRanges, _sectorRanges]: %1"
        , str [count _sectorRanges, _sectorRanges]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// Order those SECTORS in ASCENDING order and splice just the first several i.e. to target count
private _sortedSectorRanges = [_sectorRanges, [], { _x#1; }] call BIS_fnc_sortBy;
private _activatingSectors = _sortedSectorRanges select [0, (count _sortedSectorRanges) min _targetActivatingCount];

if (_debug) then {
    [format ["[fn_sectors_getActivatingSectors] Fini: [_targetActivatingCount, count _activatingSectors]: %1"
        , str [_targetActivatingCount, count _activatingSectors]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// We just want the sector MARKER NAME slice
_activatingSectors apply { (_x#0); };
