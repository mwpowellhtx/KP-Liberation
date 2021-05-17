#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_openDialog

    File: fn_missionsMgr_openDialog.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Opens the missions manager dialog.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
 */

// Create dialog that is all everything is wired up via appropriate event handlers
createDialog "KPLIB_missionsMgr";

true;
