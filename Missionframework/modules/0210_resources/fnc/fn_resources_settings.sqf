#include "script_component.hpp"
/*
    KPLIB_fnc_resources_settings

    File: fn_resources_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-14
    Last Update: 2021-04-27 14:08:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA settings initialization for this module.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

/*
    ----- RESOURCES SETTINGS -----
 */

if (isServer) then {

    MPARAM(_loadData_debug)                 =   false;
    MPARAM(_saveData_debug)                 =   false;

    MPARAM(_onGatherIntel_debug)            =   false;
    MPARAM(_onIntelGC_debug)                =   false;

    MPARAM(_defaultIntel)                   =       0;
    MPARAM(_maxIntel)                       =  100000;
};

// Thresholds, CHANCE of seeing the respective INTEL
MPARAM(_intelThresholdS)                    =      10;
MPARAM(_intelRewardMinS)                    =       1;
MPARAM(_intelRewardRangeS)                  =       5;

// REWARD MIN, RANGE, what it says: MIN+RANGE, RANGE range: [0,RANGE)
MPARAM(_intelThresholdM)                    =      60;
MPARAM(_intelRewardMinM)                    =       3;
MPARAM(_intelRewardRangeM)                  =      10;

MPARAM(_intelThresholdL)                    =      85;
MPARAM(_intelRewardMinL)                    =       5;
MPARAM(_intelRewardRangeL)                  =      15;

// KPLIB_param_crateVolume
// The amount of resources which can be stored in a crate.
// Default: 100
[
    Q(KPLIB_param_crateVolume)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_RESOURCES_CRATEVOLUME", localize "STR_KPLIB_SETTINGS_RESOURCES_CRATEVOLUME_TT"]
    , localize "STR_KPLIB_SETTINGS_RESOURCES"
    , [50, 400, 100, 0] // range: [50, 400], default: 100
    , 1
    , {}
] call CBA_settings_fnc_init;

true;
