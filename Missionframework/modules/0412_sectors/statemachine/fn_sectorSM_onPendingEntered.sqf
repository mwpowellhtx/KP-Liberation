#include "script_component.hpp"
/*
    KPLIB_fnc_sectorSM_onPendingEntered

    File: fn_sectorSM_onPendingEntered.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 00:01:05
    Last Update: 2021-06-14 16:56:52
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the CBA SECTOR namespace with current situational report details.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onPendingEntered_debug)
    || (_sector getVariable [QMVARSM(_onPendingEntered_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

if (_debug) then {
    [format ["[fn_sectorSM_onPendingEntered] Entering: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

// (Re)-set the TIMER
_sector setVariable [QMVAR(_timer), nil];

if (_debug) then {
    [format ["[fn_sectorSM_onPendingEntered] Fini: [_markerName, markerText _markerName]: %1"
        , str [_markerName, markerText _markerName]], "SECTORSM", true] call KPLIB_fnc_common_log;
};

true;
