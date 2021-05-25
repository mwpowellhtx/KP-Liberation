#include "script_component.hpp"
/*
    KPLIB_fnc_garrisonUI_settings

    File: fn_garrisonUI_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 21:47:20
    Last Update: 2021-05-24 17:00:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initializes the module settings.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
};

MPARAM(_setupPlayerActions_debug)                       = true;

if (hasInterface) then {
};

true;
