#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onSectorCaptured

    File: fn_enemies_onSectorCaptured.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-23 15:50:12
    Last Update: 2021-06-14 17:17:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to 'KPLIB_sectors_captured' event. Records the CIVILIAN REPUTATION REWARD
        staged during the ACTIVATION phase when the SECTOR first got engaged during the
        current life cycle.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: [locationNull]]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onSectorCaptured_debug)
    || (_sector getVariable [QMVAR(_onSectorCaptured_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];
private _civRepReward = _sector getVariable [QMVAR(_civRepReward), 0];

if (_debug) then {
    [format ["[fn_enemies_onSectorCaptured] Entering: [_markerName, markerText _markerName, _civRepReward]: %1"
        , str [_markerName, markerText _markerName, _civRepReward]], "ENEMIES", true] call KPLIB_fnc_common_log;
};

[_civRepReward] call MFUNC(_addCivRep);

if (_debug) then {
    ["[fn_enemies_onSectorCaptured] Fini", "ENEMIES", true] call KPLIB_fnc_common_log;
};

true;
