#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getInactiveSectors

    File: fn_sectors_getInactiveSectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 20:32:37
    Last Update: 2021-04-25 19:59:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the INACTIVE MARKERS. Basically ALL MARKERS less ACTIVE MARKERS.

    Parameter(s):
        NONE

    Returns:
        The INACTIVE markers [ARRAY]
 */

// Returns "all" of the CANDIDATE MARKERS sans the ACTIVE SECTORS
private _active = [] call MFUNC(_getActiveSectors);

// Which is a biproduct of the ACTIVE SECTORS
MVAR(_inactive);
