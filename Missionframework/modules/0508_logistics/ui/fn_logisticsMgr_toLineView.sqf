/*
    KPLIB_fnc_logisticsMgr_onViewLine

    File: fn_logisticsMgr_onViewLine.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 17:35:10
    Last Update: 2021-02-28 17:35:12
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Transforms one of the logistics lines tuples to a form expected by the LINES LISTNBOX.

    Parameters:
        _line - the logistics line tuple [ARRAY, default: []]

    Returns:
        The transformed LINES LISTNBOX row view [ARRAY]
 */

params [
    ["_line", [], [[]]]
    , ["_lineIndex", 0, [0]]
];

_line params [
    ["_lineUuid", "", [""]]
    , ["_status", KPLIB_logistics_status_na, [0]]
    , ["_timer", +KPLIB_timers_default, [[]], 4]
    , ["_endpoints", [], [[]]]
    , ["_convoy", [], [[]]]
    , ["_telemetry", [], [[]]]
];

private _lineMil = [_lineIndex] call KPLIB_fnc_common_indexToMilitaryAlpha;

[
    [
        _lineMil
    ]
    , _lineUuid
];
