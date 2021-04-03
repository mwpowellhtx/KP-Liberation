#include "script_component.hpp"
/*
    KPLIB_fnc_hud_onShowSector

    File: fn_hud_onShowSector.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        May show the SECTOR HUD for the given PLAYER.

    Parameters:
        _player - the player for which a SECTOR HUD may be shown [OBJECT, default: objNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/cutRsc
 */

private _debug = [
    [
        {MPARAM(_onShowSector_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_hud_onShowSector] Entering: [isNull _player]: %1"
        , str [isNull _player]], "HUD", true] call KPLIB_fnc_common_log;
};

// Contain several key conditions in several steps
[
    uiNamespace getVariable [QMVAR(_overlayMap), emptyHashMap]
    , uiNamespace getVariable [QMVAR(_overlayStatus), MSTATUS(_standby)]
    , dialog
    , _player getVariable ["KPLIB_display_open", false]
    //                      ^^^^^^^^^^^^^^^^^^
    // Mostly concerning REDEPLOY 'display' which is not a 'dialog'
] params [
    Q(_overlayMap)
    , Q(_overlayStatus)
    , Q(_dialog)
    , Q(_display)
];

[
    keys _overlayMap
    , [_overlayStatus, MSTATUS(_sector)] call MFUNC(_checkPlayerStatus)
    // TODO: TBD: yes, we want to controls, we probably do not also require the configs here...
    , uiNamespace getVariable [QMVAR2(Sector,_ctrlsGrpSector_lblTimer), controlNull]
    , uiNamespace getVariable [QMVAR2(Sector,_ctrlsGrpSector_lblSectorText), controlNull]
    , uiNamespace getVariable [QMVAR2(Sector,_ctrlsGrpSector_lblPbOpfor), controlNull]
    , uiNamespace getVariable [QMVAR2(Sector,_ctrlsGrpSectorBackground_lblPbBlufor), controlNull]
] params [
    Q(_overlayKeys)
    , Q(_sector)
    , Q(_lblTimer)
    , Q(_lblSectorText)
    , Q(_lblPbOpfor)
    , Q(_lblPbBlufor)
];

if (_debug) then {
    [format ["[fn_hud_onShowSector] Evaluating: [isNull _lblTimer, isNull _lblSectorText, isNull _lblPbOpfor, isNull _lblPbBlufor]: %1"
        , str [isNull _lblTimer, isNull _lblSectorText, isNull _lblPbOpfor, isNull _lblPbBlufor]], "HUD", true] call KPLIB_fnc_common_log;
};

[
    { !isNull _x; } count [_lblTimer, _lblSectorText, _lblPbOpfor, _lblPbBlufor]
    , {
        [_x, KPLIB_hudDispatchSM_sectorReportPrefix] call KPLIB_fnc_string_startsWith;
    } count _overlayKeys
] params [
    Q(_ctrlCount)
    , Q(_keyCount)
];

[
    Q(plain)
    , 0
    , false
] params [
    Q(_effect)
    , Q(_speed)
    , Q(_showInMap)
];

if (_debug) then {
    [format ["[fn_hud_onShowSector] Cutting or refreshing: [_dialog, _display, _sector, _ctrlCount]: %1"
        , str [_dialog, _display, _sector, _ctrlCount]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: "''" or BLANK cuts? layers?
switch (true) do {

    case ((_dialog || _display || !_sector) && _ctrlCount == 4): {
        if (_debug) then {
            [format ["[fn_hud_onShowSector] Cutting: [_className]: %1"
                , str [QMVAR2(Sector,_blank)]], "HUD", true] call KPLIB_fnc_common_log;
        };
        MLAYER2(Sector,_overlay) cutRsc [QMVAR2(Sector,_blank), _effect, _speed, _showInMap];
    };

    // And allow the resource control onLoad events to do the heavy lifting
    case (!(_dialog || _display) && _sector  && _ctrlCount == 0): {
        if (_debug) then {
            [format ["[fn_hud_onShowSector] Cutting: [_className]: %1"
                , str [QMVAR2(Sector,_overlay)]], "HUD", true] call KPLIB_fnc_common_log;
        };
        MLAYER2(Sector,_overlay) cutRsc [QMVAR2(Sector,_overlay), _effect, _speed, _showInMap];
    };

    // RESOURCE already CUT, refresh BOTH sets of controls, PRIMARY and SHADOW
    case (!(_dialog || _display) && _sector && _ctrlCount == 4): {
        if (_debug) then {
            [format ["[fn_hud_onShowSector] Refreshing: [isNull _lblTimer, isNull _lblSectorText, isNull _lblPbOpfor]: %1"
                , str [isNull _lblTimer, isNull _lblSectorText, isNull _lblPbOpfor]], "HUD", true] call KPLIB_fnc_common_log;
        };
        [_lblTimer] call MFUNC2(Sector,_ctrlsGrpSector_lblTimer_onRefresh);
        [_lblSectorText] call MFUNC2(Sector,_ctrlsGrpSector_lblSectorText_onRefresh);
        [_lblPbOpfor] call MFUNC2(Sector,_ctrlsGrpSector_lblProgressBar_onRefresh);
    };
};

if (_debug) then {
    ["[fn_hud_onShowSector] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
