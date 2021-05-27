#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_hudFobUI_lnbFob_onLoad

    File: fn_hudFobUI_lnbFob_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-05-26 13:40:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        FOB HUD LISTNBOX 'onLoad' event handler.

    Parameters:
        _lnbFob - a FOB LISTNBOX control [CONTROL, default: controlNull]
        _config - a corresponding config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_lnbFob), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

private _debug = MPARAMUI(_lnbFob_onLoad_debug);

if (_debug) then {
    [format ["[fn_hudFobUI_lnbFob_onLoad] Entering: [isNull _lnbFob, isNull _config]: %1"
        , str [isNull _lnbFob, isNull _config]], "HUDFOB", true] call KPLIB_fnc_common_log;
};

// Configure the namespace bits and prepare to register
private _registerArgs = [getArray (_config >> Q(colorShadow))] call {
    params [
        [Q(_colorShadow), [], [[]]]
    ];

    if (_debug) then {
        [format ["[fn_hudFobUI_lnbFob_onLoad] Prepare: [_colorShadow]: %1"
            , str [_colorShadow]], "HUDFOB", true] call KPLIB_fnc_common_log;
    };

    /* Set for purposes of STATUS REPORT later on. If the instance is around when a
     * next REPORT happens, then we attempt to use it. And if not, then we do not. */

    if (_colorShadow isEqualTypeArray [0, 0, 0, 0]) exitWith {
        _lnbFob setVariable [QMVARUI(_colorShadow), _colorShadow];
        [
            [QMVARUI(_lnbFobShadow), _lnbFob]
            , [QMVARUI(_lnbFobShadowConfig), _config]
        ];
    };

    [
        [QMVARUI(_lnbFob), _lnbFob]
        , [QMVARUI(_lnbFobConfig), _config]
    ];
};

{ uiNamespace setVariable _x; } forEach _registerArgs;

if (_debug) then {
    [format ["[fn_hudFobUI_lnbFob_onLoad] Refreshing: [ctrlIDC _lnbFob]: %1"
        , str [ctrlIDC _lnbFob]], "HUDFOB", true] call KPLIB_fnc_common_log;
};

[_lnbFob, _config] call MFUNCUI(_lnbFob_onRefresh);

if (_debug) then {
    ["[fn_hudFobUI_lnbFob_onLoad] Fini", "HUDFOB", true] call KPLIB_fnc_common_log;
};

true;
