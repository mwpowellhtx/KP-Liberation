#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_ctrlsGrpSector_lblTimer_onLoad

    File: fn_hudSector_ctrlsGrpSector_lblTimer_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-06-14 17:03:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        SECTOR HUD TIMER control 'onLoad' event handler. Mainly responds by
        cataloging the control and configuration with the name space, followed
        by potentially refreshing the control.

    Parameters:
        _lblTimer - the timer control [CONTROL, default: controlNull]
        _config - a corresponding config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

private _debug = [
    [
        {MPARAM2(Sector,_ctrlsGrpSector_lblTimer_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblTimer), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _className = configName _config;

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblTimer_onLoad] Entering: [isNull _lblTimer, isNull _config, _className]: %1"
        , str [isNull _lblTimer, isNull _config, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

// Keep the CONTROL and its CONFIG for bookkeeping purposes later on
uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblTimer),_lblTimer];
uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblTimerConfig),_config];

[_lblTimer] call MFUNC2(Sector,_ctrlsGrpSector_lblTimer_onRefresh);

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblTimer_onLoad] Fini: [ctrlIDC _lblTimer]: %1"
        , str [ctrlIDC _lblTimer]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
