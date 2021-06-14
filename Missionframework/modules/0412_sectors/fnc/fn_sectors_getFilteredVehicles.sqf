#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getFilteredVehicles

    File: fn_sectors_getFilteredVehicles.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 17:46:49
    Last Update: 2021-06-14 16:50:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Picks up where GETALLVEHICLES left off, from the NAMESPACE ALLVEHICLES,
        and applies the FILTER OPTIONS to that set of objects.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _options - ASSOCIATIVE ARRAY of OPTIONS used to filter [ARRAY, default: []]

    Returns:
        A filtered set of VEHICLES already on the NAMESPACE [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_options), [], [[]]]
];

private _allVehicles = _sector getVariable [QMVAR(_allVehicles), []];

_allVehicles select { [_x, _options] call KPLIB_fnc_common_filterObject; };
