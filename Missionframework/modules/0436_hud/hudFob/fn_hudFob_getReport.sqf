#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_getReport

    File: fn_hudFob_getReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:59:45
    Last Update: 2021-05-26 08:48:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        We shall maintain a single CBA REPORT namespace instance for purposes
        of notifying FOB HUD elements.

    Parameters:
        _player - a PLAYER for whom to report the FOB HUD bits [OBJECT, default: objNull]

    Returns:
        An FOB HUD REPORT namespace [LOCATION]
 */

params [
    [Q(_player), player, [objNull]]
];

private _debug = MPARAM(_getReport_debug)
    || (_player getVariable [QMVAR(_getReport_debug), false])
    ;

// First make sure we have a REPORT namespace we can populate
private _report = uiNamespace getVariable [QMVAR(_report), locationNull];

if (isNull _report) then {
    _report = [] call KPLIB_fnc_namespace_create;
};

uiNamespace setVariable [QMVAR(_report), _report];

_report;
