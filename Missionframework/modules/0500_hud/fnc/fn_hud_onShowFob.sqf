#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/cutRsc

private _debug = [
    [
        {MPARAM(_onShowFob_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_hud_onShowFob] Entering: [isNull _player]: %1"
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
    , [_overlayStatus, MSTATUS(_fob)] call MFUNC(_checkPlayerStatus)
    , uiNamespace getVariable [QMVAR(_lnbFob), controlNull]
    , uiNamespace getVariable [QMVAR(_lnbFobShadow), controlNull]
    , uiNamespace getVariable [QMVAR(_lnbFobConfig), configNull]
    , uiNamespace getVariable [QMVAR(_lnbFobShadowConfig), configNull]
] params [
    Q(_overlayKeys)
    , Q(_fob)
    , Q(_lnbFob)
    , Q(_lnbFobShadow)
    , Q(_lnbFobConfig)
    , Q(_lnbFobShadowConfig)
];

[
    _player isEqualTo vehicle _player
    , { !isNull _x; } count [_lnbFob, _lnbFobShadow]
    , {
        [_x, KPLIB_hudDispatchSM_fobReportPrefix] call KPLIB_fnc_string_startsWith;
    } count _overlayKeys
] params [
    Q(_playerIsPlayer)
    , Q(_ctrlCount)
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

// TODO: TBD: is key count necessary? (_keyCount == count KPLIB_hudDispatchSM_fobReportKeys) (?)
// TODO: TBD: also what happens on the other side of HUD duration, i.e. timeout?

if (_debug) then {
    [format ["[fn_hud_onShowFob] Cutting or refreshing: [_dialog, _display, _fob, _playerIsPlayer, _ctrlCount]: %1"
        , str [_dialog, _display, _fob, _playerIsPlayer, _ctrlCount]], "HUD", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: "''" or BLANK cuts? layers?
switch (true) do {

    case ((_dialog || _display || !(_fob && _playerIsPlayer)) && _ctrlCount == 2): {
        if (_debug) then {
            [format ["[fn_hud_onShowFob] Cutting: [_className]: %1"
                , str [QMVAR(_blank)]], "HUD", true] call KPLIB_fnc_common_log;
        };
        MLAYER2(FOB,_overlay) cutRsc [QMVAR(_blank), _effect, _speed, _showInMap];
    };

    // And allow the resource control onLoad events to do the heavy lifting
    case (!(_dialog || _display) && _fob && _playerIsPlayer && _ctrlCount == 0): {
        if (_debug) then {
            [format ["[fn_hud_onShowFob] Cutting: [_className]: %1"
                , str [QMVAR(_overlay)]], "HUD", true] call KPLIB_fnc_common_log;
        };
        MLAYER2(FOB,_overlay) cutRsc [QMVAR(_overlay), _effect, _speed, _showInMap];
    };

    // RESOURCE already CUT, refresh BOTH sets of controls, PRIMARY and SHADOW
    case (!(_dialog || _display) && _fob && _playerIsPlayer && _ctrlCount == 2): {
        if (_debug) then {
            [format ["[fn_hud_onShowFob] Refreshing: [isNull _lnbFob, isNull _lnbFobShadow, isNull _lnbFobConfig, isNull _lnbFobShadowConfig]: %1"
                , str [isNull _lnbFob, isNull _lnbFobShadow, isNull _lnbFobConfig, isNull _lnbFobShadowConfig]], "HUD", true] call KPLIB_fnc_common_log;
        };
        [_lnbFob, _lnbFobConfig] call MFUNC(_lnbFob_onRefresh);
        [_lnbFobShadow, _lnbFobShadowConfig] call MFUNC(_lnbFob_onRefresh);
    };
};

if (_debug) then {
    ["[fn_hud_onShowFob] Fini", "HUD", true] call KPLIB_fnc_common_log;
};

true;
