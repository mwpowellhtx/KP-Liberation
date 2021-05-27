#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onReportCivilian

    File: fn_hudFob_onReportCivilian.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:41:35
    Last Update: 2021-05-26 11:57:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reports CIVILIAN REPUTATION RATIO to the FOB HUD report.

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

private _debug = MPARAM(_onReportCivilian_debug)
    || (_player getVariable [QMVAR(_onReportCivilian_debug), false])
    || (_report getVariable [QMVAR(_onReportCivilian_debug), false])
    ;

// TODO: TBD: also include color thresholds... images...
if (isNull _player || isNull _report || !alive _player) exitWith { false; };

private _civRepRatio = [] call KPLIB_fnc_enemies_getCivRepRatio;
private _color = [_civRepRatio, [] call MFUNC(_getCivRepThresholds)] call MFUNC(_getThresholdColor);

// Pay close attention to the bouncing ball, there are many tuple levels going on here
{ _report setVariable _x; } forEach [
    [Q(_civRepRatio), PCT(_civRepRatio)]
    , [Q(_civRepOptions), [
        [Q(_varNames), [Q(_civRepRatio)]]
        , [Q(_suffix), MPRESET(_suffixPct)]
        , [Q(_imagePath), MPRESET(_civRepPath)]
        , [Q(_color), _color]
    ]]
];

true;
