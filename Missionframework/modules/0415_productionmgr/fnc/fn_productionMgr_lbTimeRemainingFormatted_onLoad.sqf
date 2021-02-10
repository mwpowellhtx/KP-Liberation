#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lbTimeRemainingFormatted_onLoad

    File: fn_productionMgr_lbTimeRemainingFormatted_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 00:59:57
    Last Update: 2021-02-10 01:00:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module formatted time remaining label onLoad event handler.

    Parameter(s):
        _lblTimeRemainingFormatted - the label control [CONTROL]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
*/

params [
    ["_lblTimeRemainingFormatted", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _productionElem = _display getVariable ["_productionElem", []];

_productionElem params [
    ["_ident", [], [[]]]
    , ["_timer", KPLIB_timers_default, [[]], 4]
];

private _renderedTimeRemaining = _timer call KPLIB_fnc_timers_renderTimeRemainingString;

_lblTimeRemainingFormatted ctrlSetText _renderedTimeRemaining;
