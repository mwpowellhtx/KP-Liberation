#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_getCivRepThresholds

    File: fn_hudFob_getCivRepThresholds.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 22:25:07
    Last Update: 2021-05-26 22:25:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a table of CIVILIAN REPUTATION THRESHOLDS, thresholds and
        corresponding colors with which to format the FOB HUD report.

        We do this functionally, as opposed to preset variables, for instance,
        because settings may change at a moment, so we do not want to hard code
        that dependency.

    Parameters:
        NONE

    Returns:
        A table of THRESHOLDS and corresponding COLORS [ARRAY]
 */

private _low = RAT(KPLIB_param_enemies_civRepBaseThreshold,100);

// TODO: TBD: for now calculating deltas, mediums, highs...
// TODO: TBD: however those could easily be actual CBA settings...
private _delta = (1 - _low) / 3;

private _medium = _low + _delta;
private _high = _medium + _delta;

// Should never be Less Than -1, so we provide -2 as a generous tolerance
+[
    [_medium, MPRESET(_greenColor)]
    , [_low, MPRESET(_blueColor)]
    , [-_low, MPRESET(_whiteColor)]
    , [-_medium, MPRESET(_yellowColor)]
    , [-_high, MPRESET(_orangeColor)]
    , [-2, MPRESET(_redColor)]
];
