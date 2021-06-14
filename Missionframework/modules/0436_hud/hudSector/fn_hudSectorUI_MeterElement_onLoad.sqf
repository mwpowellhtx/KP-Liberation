#include "script_component.hpp"
/*
    KPLIB_fnc_hudSectorUI_MeterElement_onLoad

    File: fn_hudSectorUI_MeterElement_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-06 12:22:21
    Last Update: 2021-06-14 17:02:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        SECTOR HUD METER ELEMENT 'onLoad' event handler.

    Parameters:
        _ctrl - the CONTROL being loaded [CONTROL, default: controlNull]
        _config - the corresponding CONFIG being loaded [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

params [
    [Q(_ctrl), controlNull, [controlNull]]
    // TODO: TBD: note, we have to 'help' provide the CONFIG for the DISPLAY because A3 does not do so for this particular event
    , [Q(_config), configNull, [configNull]]
];

private _debug = MPARAMUI(_MeterElement_onLoad_debug);

private _meter = getText (_config >> "meter");
private _background = getNumber (_config >> "background");
private _maxWidth = getNumber (_config >> "maxWidth");
private _color = getArray (_config >> "colorBackground");

if (_debug) then {
    [format ["[fn_hudSectorUI_MeterElement_onLoad] Entering: [isNull _ctrl, isNull _config, _meter, _background, _maxWidth]: %1"
        , str [isNull _ctrl, isNull _config, _meter, _background, _maxWidth]], "HUDSECTORUI", true] call KPLIB_fnc_common_log;
};

_ctrl setVariable [QMVAR(_maxWidth), _maxWidth];
_ctrl setVariable [QMVAR(_color), _color];

// We do not necessarily need the CONFIG, or BACKGROUND versions of the same
private _ctrlMap = uiNamespace getVariable [QMVAR(_ctrlMap), createHashMap];

private _callback = [
    {
        _ctrlMap set [toLower _meter, _ctrl];
        _ctrlMap set [format ["%1_cfg", toLower _meter], _config];
    }
    , {
        _ctrlMap set [format ["%1_bg", toLower _meter], _ctrl];
        _ctrlMap set [format ["%1_bg_cfg", toLower _meter], _config];
    }
] select _background;

[] call _callback;

uiNamespace setVariable [QMVAR(_ctrlMap), _ctrlMap];

if (_debug) then {
    ["[fn_hudSectorUI_MeterElement_onLoad] Fini", "HUDSECTORUI", true] call KPLIB_fnc_common_log;
};

true;
