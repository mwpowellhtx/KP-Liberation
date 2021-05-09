#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_settings

    File: fn_triggers_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 13:10:41
    Last Update: 2021-05-09 00:46:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for the module settings.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {
    // Server section

    MPARAM(_create_debug)                   = false;
    MPARAM(_onGC_debug)                     = false;
};

if (hasInterface) then {
    // Player section
};

true;
