#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_resequence

    File: fn_fobs_resequence.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 23:43:14
    Last Update: 2021-05-24 23:24:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Resequences the FOB building bits after one has been DEPLOYED, whether directly
        or RANDOMLY, REPACKAGED, to either BOX or TRUNK, lost, etc.

    Parameter(s):
        _buildings - an array of the FOB BUILDINGS to resequence [ARRAY, default: KPLIB_fobs_allBuildings]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_resequence_debug);

params [
    [Q(_buildings), MVAR(_allBuildings), [[]]]
];

private _oldMarkers = _buildings apply { _x getVariable [QMVAR(_markerName), ""]; };

// UNSET each of the FOB BUILDING VEHICLEVARNAMES first
{ [_x] call MFUNC(_unsetBuildingVarName); } forEach _buildings;

{
    private _global = true;
    private _fobBuilding = _x;
    private _fobIndex = _forEachIndex;

    // Sustain existing UUID when they exist
    private _fobUuid = _fobBuilding getVariable [QMVAR(_fobUuid), [] call KPLIB_fnc_uuid_create_string];

    // It is okay, if expected, to re-set everything else about it
    private _militaryAlpha = [_fobIndex] call KPLIB_fnc_common_indexToMilitaryAlpha;

    { _fobBuilding setVariable _x; } forEach [
        [QMVAR(_fobIndex), _fobIndex, _global]
        , [QMVAR(_fobUuid), _fobUuid, _global]
        , [QMVAR(_markerName), format ["%1%2", MPRESET(_markerPrefix), _fobUuid], _global]
        , [QMVAR(_markerText), format ["FOB %1", _militaryAlpha], _global]
        , [Q(KPLIB_sectors_markerText), format ["FOB %1", _militaryAlpha], _global]
        , [QMVAR(_militaryAlpha), _militaryAlpha, _global]
        , [QMVAR(_systemTime), systemTime, _global]
    ];

    [_fobBuilding] call MFUNC(_setBuildingVarName);

} forEach _buildings;

// Identify any markers that potentially no longer exist
private _newMarkers = _buildings apply { _x getVariable [QMVAR(_markerName), ""]; };
private _sharedMarkers = _oldMarkers arrayIntersect _newMarkers;

// No need to update ALL of the markers, only the FOB ones
[] call MFUNC(_onUpdateMarkers);

true;
