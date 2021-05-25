#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_getBuildings

    File: fn_fobs_getBuildings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 10:33:15
    Last Update: 2021-05-19 15:03:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a SORTED array of ALL of the FOB BUILDINGS. Buildings may be known,
        by default, or presented as optional arguments. Filters each BUILDING object
        for validity in terms of whether it can be considered an FOB BUILDING.

    Parameter(s):
        _direction - DIRECTION in which the array shall be sorted [STRING, default: 'ASCEND']
        _buildings - may specify an array of BUILDINGS [ARRAY, default: KPLIB_fobs_allBuildings]

    Returns:
        An array of SORTED FOB BUILDINGS [ARRAY]

    References:
        https://community.bistudio.com/wiki/BIS_fnc_sortBy
 */

private _debug = MPARAM(_getBuildings_debug);

params [
    [Q(_direction), Q(ascend), [""]]
    , [Q(_allBuildings), MVAR(_allBuildings), [[]]]
];

// Should not need to filter but we will to air on the safe side
private _validatedAndSortedBuildings = [
    _allBuildings
    , []
    , { _x getVariable [QMVAR(_fobIndex), -1]; }
    , _direction
    , { [_x] call MFUNC(_isBuildingValid); }
] call BIS_fnc_sortBy;

_validatedAndSortedBuildings;
