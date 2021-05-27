#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onReportIntel

    File: fn_hudFob_onReportIntel.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 01:40:13
    Last Update: 2021-05-26 21:40:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reports INTEL to the FOB HUD report.

    Parameters:
        _player - the PLAYER for whom the REPORT centers [OBJECT, default: objNull]
        _report - a REPORT for which to summarize [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_player), objNull, [objNull]]
    , [Q(_report), locationNull, [locationNull]]
];

private _debug = MPARAM(_onReportIntel_debug)
    || (_player getVariable [QMVAR(_onReportIntel_debug), false])
    || (_report getVariable [QMVAR(_onReportIntel_debug), false])
    ;

// TODO: TBD: also include colors... images...
if (isNull _player || isNull _report || !alive _player) exitWith { false; };

// Report the INTEL as part of the RESOURCES bits
private _intel = missionNamespace getVariable [Q(KPLIB_resources_intel), 0];

// Pay close attention to the bouncing ball, there are many tuple levels going on here
{ _report setVariable _x; } forEach [
    [Q(_intel), _intel]
    , [Q(_intelOptions), [
        [Q(_varNames), [Q(_intel)]]
        , [Q(_imagePath), KPLIB_preset_common_intelPath]
        , [Q(_color), +KPLIB_preset_common_intelColor]
    ]]
];

true;
