#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getOpforSectors

    File: fn_sectors_getOpforSectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 20:32:37
    Last Update: 2021-04-22 14:57:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the OPFOR MARKERS. Basically ALL MARKERS less BLUFOR MARKERS.

    Parameter(s):
        NONE

    Returns:
        The OPFOR markers [ARRAY]
 */

// Returns "all" of the CANDIDATE MARKERS sans the BLUFOR SECTORS
MVAR(_opfor) = MVAR(_all) - MVAR(_blufor);

MVAR(_opfor);
