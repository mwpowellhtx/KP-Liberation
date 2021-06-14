#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_ctrlsGrpSector_lblProgressBar_onLoad

    File: fn_hudSector_ctrlsGrpSector_lblProgressBar_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-06-14 17:03:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        SECTOR HUD PROGRESS BAR label control 'onLoad' event handler. Responds to
        both BLUFOR as well as OPFOR label controls by registering with the name
        space and potentially refreshing itself.

    Parameters:
        _lblProgressBar - either the BLUFOR or OPFOR progress bar label controls
            [CONTROL, default: controlNull]
        _config - a corresponding config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
        https://community.bistudio.com/wiki/progressPosition
        https://community.bistudio.com/wiki/progressSetPosition
        https://community.bistudio.com/wiki/ctrlSetPositionW
        https://community.bistudio.com/wiki/ctrlSetPositionX
        https://community.bistudio.com/wiki/GUI_Tutorial#BIS_fnc_initDisplay
        https://community.bistudio.com/wiki/GUI_Tutorial#createDialog_vs_createDisplay_vs_cutRsc
        https://community.bistudio.com/wiki/CT_CONTROLS_GROUP
        https://community.bistudio.com/wiki/CT_PROGRESS
 */

private _debug = [
    [
        {MPARAM2(Sector,_ctrlsGrpSector_lblProgressBar_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblProgressBar), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _className = configName _config;
private _lblProgressBarSide = getText (_config >> Q(progressBarSide));

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblProgressBar_onLoad] Entering: [isNull _lblProgressBar, isNull _config, _className, _lblProgressBarSide]: %1"
        , str [isNull _lblProgressBar, isNull _config, _className, _lblProgressBarSide]], "HUD", true] call KPLIB_fnc_common_log;
};

// Relay the PROGRESSBARSIDE through the PROGRESSBAR itself, however, should not need this beyond namespace insertion
_lblProgressBar setVariable [QMVAR2(Sector,_lblProgressBarSide), _lblProgressBarSide];

// Set aside PROGRESSBAR for either DEFENDING or ATTACKING depending on its CONFIG
switch (toLower _lblProgressBarSide) do {
    case (MVAR2(Sector,_pbSide_blufor)): {
        uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSectorBackground_lblPbBlufor), _lblProgressBar];
        uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSectorBackground_lblPbBluforConfig), _config];
    };
    case (MVAR2(Sector,_pbSide_opfor)): {
        uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblPbOpfor), _lblProgressBar];
        uiNamespace setVariable [QMVAR2(Sector,_ctrlsGrpSector_lblPbOpforConfig), _config];
    };
};

[
    uiNamespace getVariable [QMVAR2(Sector,_ctrlsGrpSector_lblPbOpfor), controlNull]
] params [
    Q(_lblPbOpfor)
];

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblProgressBar_onLoad] Refreshing: [isNull _lblPbOpfor]: %1"
        , str [isNull _lblPbOpfor]], "HUD", true] call KPLIB_fnc_common_log;
};

// Must refresh in either case, depending on SECTOR alignment and so forth
[_lblPbOpfor] call MFUNC2(Sector,_ctrlsGrpSector_lblProgressBar_onRefresh);

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblProgressBar_onLoad] Fini: [ctrlIDC _lblProgressBar]: %1"
        , str [ctrlIDC _lblProgressBar]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
