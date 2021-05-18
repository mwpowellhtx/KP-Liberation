#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_settings

    File: fn_fobs_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:06:46
    Last Update: 2021-05-17 20:06:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

[
    QMPARAM(_range)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_FOBS_RANGE", localize "STR_KPLIB_SETTINGS_GENERAL_RANGE_TT"]
    , localize "STR_KPLIB_SETTINGS_FOBS"
    , [100, 250, 125, 0] // range: [100, 250], default: 125
    , 2
    , {}
] call CBA_fnc_addSetting;

if (isServer) then {

    MPARAM(_onPreInit_debug)                = false;
    MPARAM(_onPostInit_debug)               = false;
    MPARAM(_onUpdateMarkers_debug)          = false;
};

true;
