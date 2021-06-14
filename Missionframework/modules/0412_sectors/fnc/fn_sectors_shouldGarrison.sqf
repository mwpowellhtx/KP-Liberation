#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_shouldGarrison

    File: fn_sectors_shouldGarrison.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-03 15:33:04
    Last Update: 2021-06-14 16:52:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the CBA SECTOR namespace SHOULD GARRISON. This function leaves
        ample space whether garrison ought to occur in stages, phased, or whether it may
        better occur all at once, i.e. UNITS+LIGHT_VEHICLES+HEAVY_VEHICLES, or individually.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        Whether the sector SHOULD GARRISON [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _garrisonMap = _sector getVariable [Q(KPLIB_garrison_garrisonMap), emptyHashMap];
private _ready = _garrisonMap getOrDefault [Q(KPLIB_garrison_ready), false];

// This is it simply verify whether garrison map is in and ready
!_ready;
