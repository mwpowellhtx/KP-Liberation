/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_onRefresh

    File: fn_logisticsMgr_lnbTelemetry_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-28 09:57:10
    Last Update: 2021-02-28 09:57:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Refreshes the known TELEMETRY LISTNBOX as recorded in the 'uiNamespace'
        with the current HASHMAP from the same.

    Parameters:
        NONE

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture

        https://community.bistudio.com/wiki/Category:Command_Group:_HashMap
        https://community.bistudio.com/wiki/getOrDefault
 */

private _lnbTelemetry = uiNamespace getVariable ["KPLIB_logisticsMgr_lnbTelemetry", controlNull];

// TODO: TBD: and perhaps some error handling...
if (isNull _lnbTelemetry) exitWith {
    false;
};

// If we add header rows, then adjust this accordingly...
private _minRowIndex = 0;

// Coordinates with the size of the expected TELEMETRY REPORT list...
private _size = lnbSize _lnbTelemetry;

// Gets the current report, whatever it happens to be...
private _report = [] call KPLIB_fnc_logisticsMgr_lnbTelemetry_getReport;

private _rowCount = (_size#0);

for "_rowIndex" from _minRowIndex to (_rowCount - 1) do {
    private _key = _lnbTelemetry lnbData [_rowIndex, 0];
    private _reportText = _report getOrDefault [_key, ""];
    _lnbTelemetry lnbSetText [[_rowIndex, 1], _reportText];
};

true;
