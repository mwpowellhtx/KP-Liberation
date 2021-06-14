#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getActiveSectors

    File: fn_sectors_getActiveSectors.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-24 20:01:52
    Last Update: 2021-06-14 16:49:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the ACTIVE SECTOR marker names.

    Parameter(s):
        NONE

    Returns:
        The ACTIVE SECTOR markers [ARRAY]
 */

// Which SECTORS STATE MACHJINE should have updated the KPLIB_sectors_allActive array already
MVAR(_active) = MVAR(_allActive) apply { _x getVariable [QMVAR(_markerName), ""]; };
MVAR(_inactive) = MVAR(_all) - MVAR(_active);

publicVariable QMVAR(_active);
publicVariable QMVAR(_inactive);

MVAR(_active);
