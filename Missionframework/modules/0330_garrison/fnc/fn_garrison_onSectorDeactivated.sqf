#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorDeactivated

    File: fn_garrison_onSectorDeactivated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-20 22:51:04
    Last Update: 2021-04-20 22:51:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs necessary vehicle clean up in response to SECTOR DEACTIVATED event.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

// Assumes that we 'should' be here so clear to proceed
[QMVAR(_units), QMVAR(_assets)] apply { _namespace getVariable [_x, []]; } params [
    Q(_units)
    , Q(_assets)
];

// Yes, UNITS+ASSETS... but which have not yet been captured
private _objsToGc = (_units + _assets) select { !(_x getVariable [Q(KPLIB_captured), false]); };

{ deleteVehicle _x; } forEach _objsToGc;

{ _namespace setVariable _x; } forEach [
    [QMVAR(_units), []]
    , [QMVAR(_assets), []]
    , [Q(KPLIB_sectors_status), KPLIB_sectors_status_standby]
];

true;
