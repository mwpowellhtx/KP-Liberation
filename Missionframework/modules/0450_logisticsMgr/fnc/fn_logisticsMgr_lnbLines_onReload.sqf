/*
    KPLIB_fnc_logisticsMgr_lnbLines_onReload

    File: fn_logisticsMgr_lnbLines_onReload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:51:44
    Last Update: 2021-02-28 19:20:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Reloads the LINES LISTNBOX with the current UI cached bits. We separate
        this from the actual 'onLoad' event so as to avoid hitting the event handler
        more than once, and especially so that the event handler itself may focus on
        handling event handler bookkeeping duties apart from the actual loading of
        the LINES LISTNBOX rows.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/displayNull
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_lnbLines_onReload_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

// (Re-)set the selection approaching the new set of things...
uiNamespace setVariable ["KPLIB_logisticsMgr_selectedLine", nil];

private _lnbLines = uiNamespace getVariable ["KPLIB_logisticsMgr_lnbLines", controlNull];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbLines_onReload] Entering: [isNull _lnbLines]: %1"
        , str [isNull _lnbLines]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _getRowCount = {
    params [
        ["_lnb", controlNull, [controlNull]]
    ];
    (lnbSize _lnb)#0;
};

// In order to re-select the currently selected row...
private _selectedRow = lnbCurSelRow _lnbLines;
private _lines = uiNamespace getVariable ["KPLIB_logisticsMgr_lines", []];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbLines_onReload] [_selectedRow, count _lines, _lines apply { (_x#0); }]: %1"
        , str [_selectedRow, count _lines, _lines apply { (_x#0); }]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

private _linesView = [_lines, KPLIB_fnc_logisticsMgr_toLineView] call KPLIB_fnc_linq_select;

private _linesViewCount = count _linesView;

lnbClear _lnbLines;

private _onAddLineRow = {
    _x params [
        ["_view", [], [[]]]
        , ["_lineUuid", "", [""]]
    ];

    private _rowIndex = _lnbLines lnbAddRow _view;

    // Logistics line requests begin by knowing the corresponding UUID
    _lnbLines lnbSetData [[_rowIndex, 0], _lineUuid];

    true;
};

private _added = _linesView select _onAddLineRow;

// Re-select any rows that might have been previously selected
if (_selectedRow >= 0) then {
    // Allowing for scenarios that truncate the lines, i.e. upon a removal
    private _rowCount = [_lnbLines] call _getRowCount;
    _lnbLines lnbSetCurSelRow (_selectedRow min (_rowCount - 1));
};

private _retval = (count _added) == (count _linesView);

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbLines_onReload] Fini: [_selectedRow, count _added, count _linesView]: %1"
        , str [_selectedRow, count _added, count _linesView]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

_retval;
