#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getCurrentMaxAct

    File: fn_sectors_getCurrentMaxAct.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 00:24:01
    Last Update: 2021-06-14 16:50:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the CURRENT MAX ACT. The MAX ACT CBA setting minus the count
        of currently ALL ACTIVE sectors.

    Parameter(s):
        NONE

    Returns:
        The CURRENT MAX ACT value [SCALR]
 */

private _currentMaxAct = MPARAM(_maxAct) - (count MVAR(_allActive));

_currentMaxAct;
