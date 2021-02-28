/*
    KPLIB_fnc_logisticsMgr_lnbLines_onLoad

    File: fn_logisticsMgr_lnbLines_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-27 15:14:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _lnbLines - the logistics lines LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbLines", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

private _getRowCount = {
    params [
        ["_lnb", controlNull, [controlNull]]
    ];
    (lnbSize _lnb)#0;
};

private _lines = uiNamespace getVariable ["KPLIB_logistics_lines", []];
private _lineCount = count _lines;

// In order to re-select the currently selected row...
private _selectedRow = lnbCurSelRow _lnbLines;

lnbClear _lnbLines;

for "_i" from 0 to (_lineCount - 1) do {

    (_lines select _i) params [
        ["_uuid", "", [""]]
    ];

    // Assuming that lines are presented in a deterministic system wide order
    private _mil = [_i] call KPLIB_fnc_common_indexToMilitaryAlpha;

    private _rowIndex = _lnbLines lnbAddRow [_mil];

    // Logistics line requests begin by knowing the corresponding UUID
    _lnbLines lnbSetData [[_rowIndex, 0], _uuid];
};

// Re-select any rows that might have been previously selected
if (_selectedRow >= 0 && _selectedRow < ([_lnbLines] call _getRowCount)) then {
    _lnbLines lnbSetCurSelRow _selectedRow;
};

true;
