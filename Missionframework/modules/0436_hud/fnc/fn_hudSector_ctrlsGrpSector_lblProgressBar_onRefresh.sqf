#include "script_component.hpp"
/*
    KPLIB_fnc_hudSector_ctrlsGrpSector_lblProgressBar_onRefresh

    File: fn_hudSector_ctrlsGrpSector_lblProgressBar_onRefresh.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:05:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes the SECTOR HUD OPFOR progress bar label control.

    Parameters:
        _lblPbOpfor - the OPFOR progress bar label control [CONTROL, default: controlNull]

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
        {MPARAM2(Sector,_ctrlsGrpSector_lblProgressBar_onRefresh_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_lblPbOpfor), controlNull, [controlNull]]
];

[
    MPARAM2(Sector,_lblProgressBarCommitPeriod)
] params [
    Q(_lblPbCommitPeriod)
];

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblProgressBar_onRefresh] Entering: [isNull _lblPbOpfor, _lblPbCommitPeriod]: %1"
        , str [isNull _lblPbOpfor, _lblPbCommitPeriod]], "HUD", true] call KPLIB_fnc_common_log;
};

// Which requires BOTH PROGRESS BARS in order to properly REFRESH
if (isNull _lblPbOpfor) exitWith {
    false;
};

([nil, KPLIB_hudSM_sectorReport_progressBar_viewDataKeys] call MFUNC2(Sector,_getViewData)) params [
    [Q(_pbOpforWidthCoefficient), 0, [0]]
];

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblProgressBar_onRefresh] Refreshing: [_pbOpforWidthCoefficient]: %1"
        , str [_pbOpforWidthCoefficient]], "HUD", true] call KPLIB_fnc_common_log;
};

[_pbOpforWidthCoefficient, _lblPbCommitPeriod] call MFUNC2(Sector,_ctrlsGrpSector_progressSetPosition);

if (_debug) then {
    [format ["[fn_hudSector_ctrlsGrpSector_lblProgressBar_onRefresh] Fini: [ctrlIDC _lblPbOpfor]: %1"
        , str [ctrlIDC _lblPbOpfor]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
