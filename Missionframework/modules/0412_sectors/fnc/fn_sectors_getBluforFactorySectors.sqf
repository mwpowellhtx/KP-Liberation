#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getBluforFactorySectors

    File: fn_sectors_getBluforFactorySectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 15:05:37
    Last Update: 2021-05-18 15:05:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the FACTORY SECTOR markers aligned with the known BLUFOR SECTOR markers.

    Parameter(s):
        NONE

    Returns:
        The BLUFOR FACTORY markers [ARRAY]
 */

MVAR(_factory) arrayIntersect MVAR(_blufor);
