#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getBluforGarrison

    File: fn_garrison_getBluforGarrison.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-01 15:53:40
    Last Update: 2021-05-03 19:53:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the BLUFOR GARRISON arrays: [UNITS, LIGHT VEHICLES, HEAVY VEHICLES]. See comments
        re: BLUFOR GARRISON COUNTS. By definition, BLUFOR sectors never include RESOURCE spawns.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The BLUFOR GARRISON arrays [ARRAY]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

// TODO: TBD: fill in the gap when we approach the UI...
[
    [QMVAR(_bluforUnits), []]
    , [QMVAR(_bluforGrps), []]
    , [QMVAR(_bluforLightVehicles), []]
    , [QMVAR(_bluforHeavyVehicles), []]
] apply { _namespace getVariable _x; };
