/*
    KPLIB_fnc_captive_presets

    File: fn_captive_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-31 12:06:33
    Last Update: 2021-06-14 17:19:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges the module preset variables.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

/* Intentionally specified in reverse order to what we expect, which allows for
 * the most recent phase to be timed accordingly, and appropriate GC take place
 * when subsequent timer elapse occurs.
 */
KPLIB_preset_captive_types = [
    "interrogated"
    , "captured"
    , "surrender"
];

if (isServer) then {
    KPLIB_preset_captive_minScuttleTimeout                                  = 3;
};

true;
