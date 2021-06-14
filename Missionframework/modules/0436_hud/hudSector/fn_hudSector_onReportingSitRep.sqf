#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_onReportingSitRep

    File: fn_hudSector_onReportingSitRep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-07 10:02:17
    Last Update: 2021-06-14 17:02:53
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the HUD SUBSCRIPTION REPORTING events are raised. Reports
        MARKER TEXT to the FOB SECTOR report.

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

private _debug = MPARAM(_onReportingSitRep_debug)
    || (_player getVariable [QMVAR(_onReportingSitRep_debug), false])
    || (_report getVariable [QMVAR(_onReportingSitRep_debug), false])
    ;

if (_debug) then {
    [format ["[fn_hudSector_onReportingSitRep] Entering: [isNull _player, isNull _report]: %1"
        , str [isNull _player, isNull _report]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

if (!([_report, MVAR(_reportUuid)] call KPLIB_fnc_hud_aligned)) exitWith { false; };

// TODO: TBD: also include colors... images...
if (isNull _player || isNull _report || !alive _player) exitWith { false; };

// We do not care about PLAYER NEAREST SECTOR so long as we received a SITREP
private _sitRep = _player getVariable [QMVAR(_sitRep), []];
private _sitRepMap = createHashMapFromArray _sitRep;

if (_debug) then {
    [format ["[fn_hudSector_onReportingSitRep] Sitrep: [count _sitRep]: %1"
        , str [count _sitRep]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

// Preserve known vars that should be
private _preserve = MPRESETUI(_preserveVars) apply { [_x#0, _report getVariable _x]; };

// Clear out the old vars
allVariables _report apply { _report setVariable [_x, nil]; };

// Then refresh the report itself from the SITREP
{
    _x params [Q(_varName), Q(_value)];

    if (_debug) then {
        [format ["[fn_hudSector_onReportingSitRep] Sitrep: [_varName, _value]: %1"
            , str [_varName, _value]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
    };

    _report setVariable [_varName, _value];

} forEach (_preserve + _sitRep);

// ACK depending on SITREP content
_report setVariable [QMVAR(_ack), _sitRep isNotEqualTo []];

if (_debug) then {
    ["[fn_hudSector_onReportingSitRep] Fini", "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

true;
