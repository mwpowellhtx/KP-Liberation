#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_onReportingFriendly

    File: fn_hudFob_onReportingFriendly.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:41:35
    Last Update: 2021-06-14 17:01:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the HUD SUBSCRIPTION REPORTING events are raised. Reports
        PLAYER+SLOT COUNTS to the FOB HUD report.

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

private _debug = MPARAM(_onReportingFriendly_debug)
    || (_player getVariable [QMVAR(_onReportingFriendly_debug), false])
    || (_report getVariable [QMVAR(_onReportingFriendly_debug), false])
    ;

if (!([_report, MVAR(_reportUuid)] call KPLIB_fnc_hud_aligned)) exitWith { false; };

// TODO: TBD: also parse through colors, images...
if (isNull _player || isNull _report || !alive _player) exitWith { false; };

private _playerStrength = [KPLIB_preset_sideF, false] call KPLIB_fnc_core_getPlayerStrength;

_playerStrength params [
    [Q(_playerCount), 0, [0]]
    , [Q(_slotCount), 0, [0]]
];

// Pay close attention to the bouncing ball, there are many tuple levels going on here
{ _report setVariable _x; } forEach [
    [Q(_playerCount), _playerCount]
    , [Q(_slotCount), _slotCount]
    , [Q(_unitOptions), [
        [Q(_varNames), [Q(_playerCount), Q(_slotCount)]]
        , [Q(_formatString), MPRESET(_formatStringCountOf)]
        , [Q(_imagePath), MPRESET(_unitsPath)]
    ]]
];

true;
