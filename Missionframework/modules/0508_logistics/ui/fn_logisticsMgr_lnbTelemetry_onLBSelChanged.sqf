/*
    KPLIB_fnc_logisticsMgr_lnbTelemetry_onLBSelChanged

    File: fn_logisticsMgr_lnbTelemetry_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:45
    Last Update: 2021-03-01 17:00:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to the LISTNBOX 'onLBSelChanged' event.

    Parameters:
        _lnbTelemetry - the logistics TELEMETRY LISTNBOX control [CONTROL, default: controlNull]
        _selectedIndex - the selected index of the LISTNBOX control [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbTelemetry", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

// There is "nothing" to select with TELEMETRY, per se, since it is informational only
if (_selectedIndex >= 0) then {
    _lnbTelemetry lnbSetCurSelRow -1;
};

true;
