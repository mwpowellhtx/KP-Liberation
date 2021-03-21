#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbTelemetry_onLoadDummy

    File: fn_missionsMgr_lnbTelemetry_onLoadDummy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
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
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_lnbTelemetry), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

{
    uiNamespace setVariable _x;
} forEach [
    [QMVAR(_lnbTelemetry), _lnbTelemetry]
    , [QMVAR(_lnbTelemetry_config), _config]
];

for "_i" from 0 to 29 do {
    private _rowIndex = _lnbTelemetry lnbAddRow [Q(_0), Q(_1), Q(_2)];
    _lnbTelemetry lnbSetData [[_rowIndex, 0], [] call KPLIB_fnc_uuid_create_string];
};

true;
