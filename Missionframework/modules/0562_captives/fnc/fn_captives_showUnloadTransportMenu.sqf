#include "script_component.hpp"
/*
    KPLIB_fnc_captives_showUnloadTransportMenu

    File: fn_captives_showUnloadTransportMenu.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-18 11:50:44
    Last Update: 2021-06-18 11:50:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Iteratively camps out in an UNLOAD TRANSPORT COMMANDING MENU until either the
        player elects to STOP UNLOADING or the number of CAPTIVES on board have been
        exhausted, whichever happens first.

    Parameter(s):
        _escort - an ESCORT object to consider [OBJECT, default: objNull]
        _show - [BOOL, default: true]

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/showCommandingMenu
        https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#GetIn
        https://github.com/CBATeam/CBA_A3/blob/master/addons/events/fnc_addBISEventHandler.sqf#L54
 */

params [
    [Q(_escort), objNull, [objNull]]
    , [Q(_show), true, [true]]
];

private _transport =_escort getVariable [QMVAR(_transport), objNull];
private _unitsToUnload = [_transport] call MFUNC(_getLoadedCaptives);

private _debug = MPARAM(_showUnloadTransportMenu_debug)
    || (_escort getVariable [QMVAR(_showUnloadTransportMenu_debug), false])
    || (_transport getVariable [QMVAR(_showUnloadTransportMenu_debug), false])
    || (_unitsToUnload findIf { _x getVariable [QMVAR(_showUnloadTransportMenu_debug), false]; } >= 0)
    ;

if (_debug) then {
    [format ["[fn_captives_showUnloadTransportMenu] Entering: [name _escort, _show, count _unitsToUnload]: %1"
        , str [name _escort, _show]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

// Serves as our terminal use case when there are no further UNITS to unload, etc
if (isNull _transport || !alive _transport || !_show || _unitsToUnload isEqualTo []) exitWith {
    if (_debug) then {
        ["[fn_captives_showUnloadTransportMenu] Hidden", "CAPTIVES", true] call KPLIB_fnc_common_log;
    };
    _escort setVariable [QMVAR(_transport), nil, true];
    MVAR(_unloadTransportMenu) = nil;
    showCommandingMenu "";
    true;
};

private _commandingMenu = [
    [localize "STR_KPLIB_SETTINGS_CAPTIVES_UNLOAD", false]
];

for "_i" from 0 to (count _unitsToUnload - 1) do {

    private _unit = _unitsToUnload select _i;
    private _unitUuid = _unit getVariable [QMVAR(_uuid), ""];

    _commandingMenu pushBack [
        format [localize "STR_KPLIB_ACTIONS_CAPTIVES_UNLOAD_FORMAT", name _unit]
        , [2 + _i]
        , ""
        , -5
        , [
            [Q(expression), format ["[player, '%1'] spawn KPLIB_fnc_captives_onUnitUnloadOne", _unitUuid]]
        ]
        , "1"
        , "1"
        // , "optional icon path"
    ];
};

_commandingMenu pushBack [
    localize "STR_KPLIB_SETTINGS_CAPTIVES_STOP_UNLOADING"
    , [(count _commandingMenu + 1)]
    , ""
    , -3
    , [
        [Q(expression), "[player, false] spawn KPLIB_fnc_captives_showUnloadTransportMenu"]
    ]
    , "1"
    , "1"
];

MVAR(_unloadTransportMenu) = _commandingMenu;

showCommandingMenu format ["#USER:%1", QMVAR(_unloadTransportMenu)];

if (_debug) then {
    ["[fn_captives_showUnloadTransportMenu] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
