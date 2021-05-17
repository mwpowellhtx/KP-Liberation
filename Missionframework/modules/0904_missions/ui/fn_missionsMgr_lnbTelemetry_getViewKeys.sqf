#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbTelemetry_getViewKeys

    File: fn_missionsMgr_lnbTelemetry_getViewKeys.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reads the currently presented TELEMETRY VIEW KEYS from the entire LISTNBOX.

    Parameter(s):
        _lnbTelemetry - The TELEMETRY LISTNBOX control which contains the data [CONTROL, default: controlNull]

    Returns:
        View keys backing the entire TELEMETRY LISTNBOX [ARRAY]
 */

params [
    [Q(_lnbTelemetry), uiNamespace getVariable [QMVAR(_lnbTelemetry), controlNull], [controlNull]]
];

private _keys = [];

if (isNull _lnbTelemetry) exitWith {
    _keys;
};

private _rowCount = (lnbSize _lnbTelemetry)#0;

for "_rowIndex" from 1 to _rowCount do {
    private _key = _lnbTelemetry lnbData [_rowIndex, 0];
    _keys pushBack _key;
};

_keys;
