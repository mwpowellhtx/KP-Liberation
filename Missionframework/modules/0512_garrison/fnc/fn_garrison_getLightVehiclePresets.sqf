#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getLightVehiclePresets

    File: fn_garrison_getLightVehiclePresets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-01 12:39:51
    Last Update: 2021-05-01 12:39:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the LIGHT VEHICLE PRESETS taking into consideration CITY, METROPOLIS,
        and FACTORY GARRISON settings.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The LIGHT VEHICLE PRESETS for the target sector [ARRAY]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _presets = +KPLIB_preset_vehLightArmedPlE;
private _markerName = _namespace getVariable [QMVAR(_markerName), ""];

if ((_markerName find KPLIB_preset_eden_cityPrefix == 0             && MPARAM(_cityGarrisonsApcs))
    || (_markerName find KPLIB_preset_eden_metropolisPrefix == 0    && MPARAM(_metropolisGarrisonsApcs))
    || (_markerName find KPLIB_preset_eden_factoryPrefix == 0       && MPARAM(_factoryGarrisonsApcs))) then {
    _presets append KPLIB_preset_vehHeavyApcPlE;
};

_presets;
