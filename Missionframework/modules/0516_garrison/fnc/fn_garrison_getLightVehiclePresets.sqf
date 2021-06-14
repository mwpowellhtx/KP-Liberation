#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getLightVehiclePresets

    File: fn_garrison_getLightVehiclePresets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-01 12:39:51
    Last Update: 2021-06-02 21:15:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the LIGHT VEHICLE PRESETS taking into consideration CITY, METROPOLIS, and
        FACTORY GARRISON settings. May include APC PRESETS depending on the settings.

    Parameter(s):
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The LIGHT VEHICLE PRESETS for the target sector [ARRAY]
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_getLightVehiclePresets_debug)
    || (_sector getVariable [QMVAR(_getLightVehiclePresets_debug), false])
    ;

private _markerName = _sector getVariable [Q(KPLIB_sectors_markerName), ""];

if (_debug) then {
    // TODO: TBD: logging...
};

private _garrisonApcPrefixes = [
    [KPLIB_preset_eden_cityPrefix           , MPARAM(_cityGarrisonApcs)         ]
    , [KPLIB_preset_eden_metropolisPrefix   , MPARAM(_metropolisGarrisonApcs)   ]
    , [KPLIB_preset_eden_factoryPrefix      , MPARAM(_factoryGarrisonApcs)      ]
];

private _index = _garrisonApcPrefixes findIf {
    _x params [Q(_expectedPrefix), Q(_apcs)];
    // _markerName find _prefix == 0 && _apcs;
    private _actualPrefix = _markerName select [
        0
        , (count _markerName) min (count _prefix)
    ];
    _actualPrefix == _expectedPrefix
        && _apcs;
};

private _presets = +KPLIB_preset_vehLightArmedPlE;

if (_index >= 0) then {
    _presets append KPLIB_preset_vehHeavyApcPlE;
};

if (_debug) then {
    // TODO: TBD: logging...
};

_presets;
