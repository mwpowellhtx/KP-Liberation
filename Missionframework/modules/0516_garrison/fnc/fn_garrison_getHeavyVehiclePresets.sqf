#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getHeavyVehiclePresets

    File: fn_garrison_getHeavyVehiclePresets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-01 12:42:03
    Last Update: 2021-06-02 21:15:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the HEAVY VEHICLE PRESETS.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The HEAVY VEHICLE PRESETS for the target sector [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _presets = +KPLIB_preset_vehHeavyPlE;

_presets append KPLIB_preset_vehHeavyApcPlE;

_presets;
