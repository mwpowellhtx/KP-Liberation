#include "script_component.hpp"
/*
    KPLIB_fnc_firedrill_settings

    File: fn_firedrill_settings.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 16:42:28
    Last Update: 2021-03-20 16:42:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA Settings initialization for this module.

    Parameter(s):
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
    // TODO: TBD: name is changing? from 'CBA_settings_fnc_init' to 'CBA_fnc_addSetting'
        http://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

[
    QMPARAM(_durationSeconds)
    , Q(SLIDER)
    , [
        localize "STR_KPLIB_SETTINGS_MISSIONS_FIREDRILL_DURATION_SECONDS"
        , localize "STR_KPLIB_SETTINGS_MISSIONS_FIREDRILL_DURATION_SECONDS_TT"
    ]
    , localize "STR_KPLIB_SETTINGS_MISSIONS_FIREDRILL"
    , [5, (15 * KPLIB_uom_time_secondsPerMinute), (5 * KPLIB_uom_time_secondsPerMinute), 0]
    // range: [5, 15*KPLIB_uom_time_secondsPerMinute], default: 5*KPLIB_uom_time_secondsPerMinute
    , 2
    , {}
] call CBA_settings_fnc_init;

true;
