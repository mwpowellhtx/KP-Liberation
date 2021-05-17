#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onShow

    File: fn_hud_onShow.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-17 14:04:21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        May show PLAYER the indicated HUD layers.

    Parameters:
        _player - the player for whom HUD layers may be shown [OBJECT, default: objNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/deleteAt
 */

private _debug = [
    [
        {MPARAM(_onShow_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

[
    toLower KPLIB_hudSM_dispatchStatus in allVariables _player
    , toLower KPLIB_hudSM_dispatchReport in allVariables _player
    , _player getVariable [KPLIB_hudSM_dispatchStatus, MSTATUS(_standby)]
    , _player getVariable [KPLIB_hudSM_dispatchReport, []]
] params [
    Q(_hasStatus)
    , Q(_hasReport)
    , Q(_dispatchStatus)
    , Q(_dispatchReport)
];

if (_debug) then {
    [format ["[fn_hud_onShow] Entering: [isNull _player, _hasStatus, _hasReport, _dispatchStatus, count _dispatchReport]: %1"
        , str [isNull _player, _hasStatus, _hasReport, _dispatchStatus, count _dispatchReport]], "HUD", true] call KPLIB_fnc_common_log;
};

[_player, _dispatchStatus, +_dispatchReport] call MFUNC(_onReconcileOverlayMap);

// TODO: TBD: in the process of connecting some dots between SECTOR REPORT and its respective controls...
[_player] call MFUNC(_onShowSector);

[_player] call MFUNC(_onShowFob);

// TODO: TBD: we wonder whether [player] as an arg array doesn't make a 'copy' of player for OBJECT comparison, variables included
[
    MFUNC(_onShow)
    , [player]
    , MPARAM(_showPeriod)
] call CBA_fnc_waitAndExecute;

if (_debug) then {
    ["[fn_hud_onShow] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
