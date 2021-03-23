#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_settings

    File: fn_firedrill_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-20 16:42:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA Settings initialization for this module.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]
 */

if (isServer) then {
    MPARAM(_durationSeconds)                = 10 * KPLIB_uom_time_secondsPerMinute;
};

true;
