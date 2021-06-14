#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onRegimentBluforHeavyVehicles

    File: fn_garrison_onRegimentBluforHeavyVehicles.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 17:30:22
    Last Update: 2021-06-14 17:12:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Performs BLUFOR GARRISON REGIMENT for the CBA SECTOR namespace.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _garrisonMap - the GARRISON HASHMAP for the sector [HASHMAP, default: createHashMap]

    Returns:
        The event handler has finished [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
    , [Q(_garrisonMap), createHashMap, [emptyHashMap]]
];

private _debug = MPARAM(_onRegimentBluforHeavyVehicles_debug)
    || (_sector getVariable [QMVAR(_onRegimentBluforHeavyVehicles_debug), false])
    ;

if (_debug) then {
    // TODO: TBD: logging...
};

// TODO: TBD: ...

if (_debug) then {
    // TODO: TBD: logging...
};

true;