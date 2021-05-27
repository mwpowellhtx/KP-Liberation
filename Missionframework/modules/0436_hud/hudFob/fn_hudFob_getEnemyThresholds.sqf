#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_getEnemyThresholds

    File: fn_hudFob_getEnemyThresholds.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 22:16:02
    Last Update: 2021-05-26 22:16:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a table of ENEMY THRESHOLDS, thresholds and corresponding colors
        with which to format the FOB HUD report.

        We do this functionally, as opposed to preset variables, for instance,
        because settings may change at a moment, so we do not want to hard code
        that dependency.

    Parameters:
        NONE

    Returns:
        A table of THRESHOLDS and corresponding COLORS [ARRAY]
 */

// Should never be Less Than 0, so we provide a generous tolerance at -1
+[
    [MPARAM(_enemyHigh), KPLIB_preset_hud_redColor]
    , [MPARAM(_enemyMedium), KPLIB_preset_hud_orangeColor]
    , [MPARAM(_enemyLow), KPLIB_preset_hud_yellowColor]
    , [-1, KPLIB_preset_hud_whiteColor]
];
