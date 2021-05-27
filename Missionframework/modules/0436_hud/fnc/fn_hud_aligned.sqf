#include "script_component.hpp"
/*
    KPLIB_fnc_hud_aligned

    File: fn_hud_aligned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-27 13:58:17
    Last Update: 2021-05-27 13:58:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the REPORT is ALIGNED with an EXPECTED UUID. We will do this many
        times over, during the REPORTING events as well as the actual REPORT event, so it
        is best to contain this in one place.

    Parameters:
        _report - a REPORT for which to verify alignment [LOCATION, default: locationNull]
        _expectedUuid - an EXPECTED UUID to align with [STRING, default: ""]

    Returns:
        Whether the REPORT is ALIGNED with the EXPECTED UUID [BOOL]
 */

params [
    [Q(_report), locationNull, [locationNull]]
    , [Q(_expectedUuid), "", [""]]
];

private _debug = MPARAM(_aligned_debug)
    || (_report getVariable [QMVAR(_aligned_debug), false])
    ;

_expectedUuid = toLower _expectedUuid;

private _actualUuid = toLower (_report getVariable [QMVAR(_reportUuid), ""]);

if (_debug) then {
    [format ["[fn_hud_aligned] Entering: [isNull _report, _expectedUuid, _actualUuid]: %1"
        , str [isNull _report, _expectedUuid, _actualUuid]], "HUD", true] call KPLIB_fnc_common_log;
};

private _aligned = _actualUuid isEqualTo _expectedUuid;

if (_debug) then {
    [format ["[fn_hud_aligned] Fini: [_aligned]: %1"
        , str [_aligned]], "HUD", true] call KPLIB_fnc_common_log;
};

_aligned;
