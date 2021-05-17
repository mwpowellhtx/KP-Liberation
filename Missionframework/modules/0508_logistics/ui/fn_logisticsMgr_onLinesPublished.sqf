/*
    KPLIB_fnc_logisticsMgr_onLinesPublished

    File: fn_logisticsMgr_onLinesPublished.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 17:24:55
    Last Update: 2021-02-28 17:24:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Client side 'KPLIB_logisticsMgr_onRefreshLogistics' event handler.

    Parameters:
        _lines - an array of the logistics lines tuples [ARRAY, default: []]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_onLinesPublished_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_lines", [], [[]]]
];

_lines = +_lines;

if (_debug) then {
    [format ["[fn_logisticsMgr_onLinesPublished] Entering: [count _lines, _lines apply { (_this#0); }]: %1"
        , str [count _lines, _lines apply { (_this#0); }]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// (Re-)set the '_lines' in the 'uiNamespace' and (re-)load the LINES LISTNBOX accordingly...
uiNamespace setVariable ["KPLIB_logisticsMgr_lines", _lines];

// Dissect the views and present them starting with the logistics lines LISTNBOX control
private _lnbLines = uiNamespace getVariable ["KPLIB_logisticsMgr_lnbLines", controlNull];

// Everything else works its way out from there, selected indexes, etc...
[_lnbLines] call KPLIB_fnc_logisticsMgr_lnbLines_onReload;

// TODO: TBD: should also consider re-selecting endpoints here...

if (_debug) then {
    ["[fn_logisticsMgr_onLinesPublished] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
