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
        Returns the CIVILIAN REPUTATION REWARD for the CBA SECTOR namespace.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The CIVILIAN REPUTATION REWARD corresponding to the SECTOR, if any [SCALAR, default: 0]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_getSectorCaptureReward_debug)
    || (_sector getVariable [QMVAR(_getSectorCaptureReward_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    // TODO: TBD: logging...
};

private _cityCapReward = KPLIB_param_enemies_cityCaptureReward;
private _metroCapCoef = KPLIB_param_enemies_metropolisCaptureCoef;

private _capRewardMap = createHashMapFromArray [
    [KPLIB_preset_eden_cityType, _cityCapReward]
    , [KPLIB_preset_eden_metropolisType, floor (_cityCapReward * _metroCapCoef)]
];

private _sectorType = [_markerName] call KPLIB_fnc_eden_getSectorType;
private _civRepReward = _capRewardMap getOrDefault [_sectorType, 0];

if (_debug) then {
    // TODO: TBD: logging...
};

_civRepReward;
