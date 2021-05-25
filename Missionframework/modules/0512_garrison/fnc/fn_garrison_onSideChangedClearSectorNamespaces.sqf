#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSideChangedClearSectorNamespaces

    File: fn_garrison_onSideChangedClearSectorNamespaces.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 16:28:41
    Last Update: 2021-04-21 12:32:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Clears the GARRISON bits by performing GARRISON scoped GC on CBA SECTOR namespaces.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

{ [_x] call MFUNC(_onGC); } forEach KPLIB_sectors_namespaces;

// This is a save-worthy trigger
[Q(fn_garrison_onSideChangedClearSectorNamespaces)] call KPLIB_fnc_init_save;

true;
