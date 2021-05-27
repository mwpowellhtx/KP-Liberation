#include "script_component.hpp"
/*
    KPLIB_fnc_hud_getReport

    File: fn_hud_getReport.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 00:59:45
    Last Update: 2021-05-26 08:48:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        We shall maintain a single CBA REPORT namespace instance for purposes
        of notifying FOB HUD elements.

    Parameters:
        _reportUuid - a REPORT UUID for which to register a HUD REPORT [STRING, default: _defaultUuid]

    Returns:
        An FOB HUD REPORT namespace [LOCATION]
 */

private _defaultUuid = [] call KPLIB_fnc_uuid_create_string;

params [
    [Q(_reportUuid), _defaultUuid, [""]]
];

private _debug = MPARAM(_getReport_debug)
    ;

if (_debug) then {
    [format ["[fn_hud_getReport] Entering: [_reportUuid]: %1"
        , str [_reportUuid]], "HUD", true] call KPLIB_fnc_common_log;
};

private _registry = uiNamespace getVariable QMVAR(_registry);
if (isNil { _registry; }) then {
    _registry = createHashMap;
    uiNamespace setVariable [QMVAR(_registry), _registry];
};

if (!(_reportUuid in _registry)) then {
    if (_debug) then {
        [format ["[fn_hud_getReport] New report: [_reportUuid]: %1"
            , str [_reportUuid]], "HUD", true] call KPLIB_fnc_common_log;
    };
    private _newReport = [] call KPLIB_fnc_namespace_create;
    _newReport setVariable [QMVAR(_reportUuid), _reportUuid];
    _registry set [_reportUuid, _newReport];
};

private _report = _registry get _reportUuid;

if (_debug) then {
    [format ["[fn_hud_getReport] Fini: [isNull _report, _reportUuid]: %1"
        , str [isNull _report, _reportUuid]], "HUD", true] call KPLIB_fnc_common_log;
};

_report;
