#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_getSectorCaptureReward

    File: fn_enemies_getSectorCaptureReward.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-26 13:06:07
    Last Update: 2021-04-28 20:31:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the CIVILIAN REPUTATION REWARD for the SECTOR MARKER.

    Parameter(s):
        _markerName - the SECTOR marker name [STRING, default: ""]

    Returns:
        The CIVILIAN REPUTATION reward [SCALAR]
 */

private _debug = MPARAM(_getSectorCaptureReward_debug);

params [
    [Q(_markerName), "", [""]]
];

// Starting with nominal defaults
[0, 1] params [
    Q(_cityCaptureReward)
    , Q(_metropolisCaptureCoef)
];

// Set to parameters accordingly
if (_markerName in (KPLIB_sectors_city + KPLIB_sectors_metropolis)) then {
    _cityCaptureReward = MPARAM(_cityCaptureReward);
};

if (_markerName in KPLIB_sectors_metropolis) then {
    _metropolisCaptureCoef = MPARAM(_metropolisCaptureCoef);
};

// Return with the product
_metropolisCaptureCoef * _cityCaptureReward;
