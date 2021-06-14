#include "script_component.hpp"
/*
    KPLIB_fnc_hudSectorUI_onLoad

    File: fn_hudSectorUI_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-06-14 17:02:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        SECTOR HUD 'onLoad' event handler.

    Parameters:
        _display - the DISPLAY being loaded [DISPLAY, default: displayNull]
        _config - the corresponding CONFIG being loaded [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

params [
    [Q(_display), displayNull, [displayNull]]
    // TODO: TBD: note, we have to 'help' provide the CONFIG for the DISPLAY because A3 does not do so for this particular event
    , [Q(_config), configNull, [configNull]]
];

private _debug = MPARAM(_onLoad_debug);

// // // TODO: TBD: will figure out these bits next...
// // Lift the CLASS NAME back from the DISPLAY instance itself
_display setVariable [QMVAR(_className), (configName _config)];
private _className = _display getVariable [QMVAR(_className), ""];

if (_debug) then {
    [format ["[fn_hudSectorUI_onLoad] Entering: [isNull _display, isNull _config, _className]: %1"
        , str [isNull _display, isNull _config, _className]], "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

if (toLower _className find QMVAR(_blank) > 0) exitWith {
    private _ctrlMap = uiNamespace getVariable [QMVAR(_ctrlMap), createHashMap];

    private _formats = [
        "%1"
        , "%1_cfg"
        , "%1_bg"
        , "%1_bg_cfg"
    ];

    private _metersToNil = MPRESETUI(_meters) apply {
        private _meter = _x;
        _formats apply { format [_x, _meter]; };
    };

    { _ctrlMap set [_x, nil]; } forEach (flatten _metersToNil);

    _ctrlMap set [Q(lblMarkerText), nil];
    _ctrlMap set [Q(lblMarkerTextConfig), nil];

    uiNamespace setVariable [QMVAR(_ctrlMap), _ctrlMap];
};

if (_debug) then {
    ["[fn_hudSectorUI_onLoad] Fini", "HUDSECTOR", true] call KPLIB_fnc_common_log;
};

true;
