#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onReportingEnemy

    File: fn_hudFob_onReportingEnemy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:52:54
    Last Update: 2021-06-14 17:01:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the HUD SUBSCRIPTION REPORTING events are raised. Reports
        ENEMY STRENGTH+AWARENESS RATIOS to the FOB HUD report.

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

private _debug = MPARAM(_onReportingEnemy_debug)
    || (_player getVariable [QMVAR(_onReportingEnemy_debug), false])
    || (_report getVariable [QMVAR(_onReportingEnemy_debug), false])
    ;

if (!([_report, MVAR(_reportUuid)] call KPLIB_fnc_hud_aligned)) exitWith { false; };

// TODO: TBD: also include color thresholds... images...
if (isNull _player || isNull _report || !alive _player) exitWith { false; };

private _strengthRatio = [] call KPLIB_fnc_enemies_getStrengthRatio;
private _awarenessRatio = [] call KPLIB_fnc_enemies_getAwarenessRatio;

private _enemyThresholds = [] call MFUNC(_getEnemyThresholds);
private _strengthColor = [_strengthRatio, _enemyThresholds] call MFUNC(_getThresholdColor);
private _awarenessColor = [_awarenessRatio, _enemyThresholds] call MFUNC(_getThresholdColor);

// Pay close attention to the bouncing ball, there are many tuple levels going on here
{ _report setVariable _x; } forEach [
    [Q(_strengthRatio), PCT(_strengthRatio)]
    , [Q(_awarenessRatio), PCT(_awarenessRatio)]
    , [Q(_strengthOptions), [
        [Q(_varNames), [Q(_strengthRatio)]]
        , [Q(_suffix), MPRESET(_suffixPct)]
        , [Q(_imagePath), MPRESET(_strengthRatioPath)]
        , [Q(_color), +_strengthColor]
    ]]
    , [Q(_awarenessOptions), [
        [Q(_varNames), [Q(_awarenessRatio)]]
        , [Q(_suffix), MPRESET(_suffixPct)]
        , [Q(_imagePath), MPRESET(_awarenessRatioPath)]
        , [Q(_color), +_awarenessColor]
    ]]
];

true;
