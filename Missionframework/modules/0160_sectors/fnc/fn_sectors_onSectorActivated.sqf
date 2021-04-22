#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onSectorActivated

    File: fn_sectors_onSectorActivated.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 14:44:17
    Last Update: 2021-04-21 14:44:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        SECTOR ACTIVATED event handler.

    Parameters:
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onSectorActivated_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectors_onSectorActivated] Activated: [_markerName]: %1"
        , str [_markerName]], "SECTORS"] call KPLIB_fnc_common_log;
};

true;
