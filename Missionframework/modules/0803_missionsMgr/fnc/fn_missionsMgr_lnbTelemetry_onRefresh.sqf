#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbTelemetry_onRefresh

    File: fn_missionsMgr_lnbTelemetry_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:16:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the TELEMETRY LISTNBOX opens, 'onLoad'.

    Parameter(s):
        _lnbTelemetry - the TELEMETRY LISTNBOX control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/lnbAddRow
 */

params [
    [Q(_lnbTelemetry), uiNamespace getVariable [QMVAR(_lnbTelemetry), controlNull], [controlNull]]
];

private _loadedViewKeys = [_lnbTelemetry] call MFUNC(_lnbTelemetry_getViewKeys);

private _viewData = _lnbTelemetry getVariable [QMVAR(_viewData), []];

private _viewKeys = _viewData apply { (_x#0); };

if (!(_viewKeys isEqualTo _loadedViewKeys)) then {
    lnbClear _lnbTelemetry;

    private _rowIndex = _lnbTelemetry lnbAddRow [
        ""
        , toUpper (localize "STR_KPLIB_MISSIONSMGR_LNB_TELEMETRY_PARAM")
        , toUpper (localize "STR_KPLIB_MISSIONSMGR_LNB_TELEMETRY_VALUE")
    ];

    {
        _x params [
            [Q(_name), "", [""]]
            , Q(_datum)
            , [Q(_imagePath), "", [""]]
        ];

        _rowIndex = _lnbTelemetry lnbAddRow ["", _name, ""];

        if (count _imagePath > 0) then {
            _lnbTelemetry lnbSetPicture [[_rowIndex, 0], _imagePath];
        };
    } forEach _viewData;
};

{
    _x params [
        Q(_name)
        , [Q(_datum), "", [""]]
    ];

    private _rowIndex = _forEachIndex + 1;

    _lnbTelemetry lnbSetText [[_rowIndex, 1], _datum];

} forEach _viewData;

true;
