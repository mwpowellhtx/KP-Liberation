#include "script_component.hpp"
/*
    KPLIB_fnc_assets_settings

    File: fn_assets_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 23:00:04
    Last Update: 2021-05-25 23:00:07
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Arranges the module settings variables.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {};

// The quota that each asset counts when totaled up
MPARAM(_defaultQuota)                           = 1;

if (isServer) then {};

true;
