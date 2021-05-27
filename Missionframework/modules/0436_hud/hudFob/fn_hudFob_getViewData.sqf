#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_getViewData

    File: fn_hudFob_getViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-26 15:40:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Assembles an array of VIEW DATA given the PLAYER and corresponding REPORT.

    Parameters:
        _player - PLAYER for whom to get the VIEW DATA tuples [OBJECT, default: player]
        _report - a CBA REPORT namespace from which to assemble [LOCATION, default: locationNull]

    Returns:
        An array of VIEW DATA tuples corresponding to the PLAYER and REPORT [ARRAY]
 */

params [
    [Q(_player), player, [objNull]]
    , [Q(_report), locationNull, [locationNull]]
];

private _debug = MPARAM(_getViewData_debug)
    || (_player getVariable [QMVAR(_getViewData_debug), false])
    || (_report getVariable [QMVAR(_getViewData_debug), false])
    ;

if (_debug) then {
    [format ["[fn_hudFob_getViewData] Entering: [%1]: %2"
        , QMPRESET(_viewDataOptionKeys)
        , str [MPRESET(_viewDataOptionKeys)]], "HUDFOB", true] call KPLIB_fnc_common_log;
};

// Lift each VIEW DATUM given REPORT and an OPTIONS KEY
private _viewData = MPRESET(_viewDataOptionKeys) apply { [_player, _report, _x] call MFUNC(_getViewDatum); };

if (_debug) then {
    [format ["[fn_hudFob_getViewData] Fini: [count _viewData]: %1"
        , str [count _viewData]], "HUDFOB", true] call KPLIB_fnc_common_log;
};

_viewData;
