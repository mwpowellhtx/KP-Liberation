/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onLBSelChanged

    File: fn_logisticsMgr_lnbConvoy_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 10:20:32
    Last Update: 2021-03-01 10:20:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to CONVOY LISTNBOX selection changes.

    Parameters:
        _lnbConvoy - the logistics CONVOY LISTNBOX control [CONTROL, default: controlNull]
        _selectedIndex - the CONVOY LISTNBOX selected index [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_lnbConvoy_onLBSelChanged_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_lnbConvoy", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

if (_debug) then {
    [format ["[fn_logisticsMgr_lnbConvoy_onLBSelChanged] Entering: [isNull _lnbConvoy, _selectedIndex]: %1"
        , str [isNull _lnbConvoy, _selectedIndex]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

// Disallow selecting the header row
if (_selectedIndex == 0) then {
    _lnbConvoy lnbSetCurSelRow -1;
};

if (_debug) then {
    ["[fn_logisticsMgr_lnbConvoy_onLBSelChanged] Fini", "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
