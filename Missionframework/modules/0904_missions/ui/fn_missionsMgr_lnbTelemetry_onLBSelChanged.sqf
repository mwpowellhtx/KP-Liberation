#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbTelemetry_onLBSelChanged

    File: fn_missionsMgr_lnbTelemetry_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 17:27:52
    Last Update: 2021-03-22 17:27:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the TELEMETRY LISTNBOX selection changed, 'onLBSelChanged'.

    Parameter(s):
        _lnbTelemetry - the TELEMETRY LISTNBOX control [CONTROL, default: controlNull]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
 */

params [
    [Q(_lnbTelemetry), controlNull, [controlNull]]
    , [Q(_selectedIndex), -1, [0]]
];

if (_selectedIndex < 0) exitWith {
    true;
};

// Disallow row level selections
_lnbTelemetry lnbSetCurSelRow -1;

true;
