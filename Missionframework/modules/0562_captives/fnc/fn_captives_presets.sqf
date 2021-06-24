#include "script_component.hpp"
/*
    KPLIB_fnc_captives_presets

    File: fn_captives_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 12:06:33
    Last Update: 2021-06-17 10:28:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module preset variables.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {
    // Server section

};

if (hasInterface) then {
    MPRESET(_actionRange)               = 5;
    MPRESET(_escortOffset)              = [0, 1, 0];
    MPRESET(_transportTypes)            = [Q(Air), Q(LandVehicle), Q(Ship)];
};

true;
