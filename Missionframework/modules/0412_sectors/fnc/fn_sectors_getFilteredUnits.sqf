#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getFilteredUnits

    File: fn_sectors_getFilteredUnits.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-28 17:35:09
    Last Update: 2021-06-14 16:50:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Picks up where GETALLUNITS left off, from the NAMESPACE ALLUNITS,
        and applies the FILTER OPTIONS to that set of objects.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _options - ASSOCIATIVE ARRAY of OPTIONS used to filter [ARRAY, default: []]

    Returns:
        A filtered set of UNITS already on the NAMESPACE [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_options), [], [[]]]
];

private _allUnits = _sector getVariable [QMVAR(_allUnits), []];

_allUnits select { [_x, _options] call KPLIB_fnc_common_filterObject; };
