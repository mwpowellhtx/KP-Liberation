#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_ctrlsGrpSector_lblSectorText_onLoad

    File: fn_hudSector_ctrlsGrpSector_lblSectorText_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        SECTOR HUD SECTOR TEXT label control 'onLoad' event handler.

    Parameters:
        _lblSectorText - the sector text label control [CONTROL, default: controlNull]
        _config - a corresponding config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

private _debug = [
    [
        {MPARAM2(Sector,_ctrlsGrpSector_lblSectorText_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblSectorText), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _className = configName _config;

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblSectorText_onLoad] Entering: [isNull _lblSectorText, isNull _config, _className]: %1"
        , str [isNull _lblSectorText, isNull _config, _className]], "HUD", true] call KPLIB_fnc_common_log;
};

uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblSectorText), _lblSectorText];
uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblSectorTextConfig), _config];

[_lblSectorText] call MFUNC2(Sector,_ctrlsGrpSector_lblSectorText_onRefresh);

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblSectorText_onLoad] Fini: [ctrlIDC _lblSectorText]: %1"
        , str [ctrlIDC _lblSectorText]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
