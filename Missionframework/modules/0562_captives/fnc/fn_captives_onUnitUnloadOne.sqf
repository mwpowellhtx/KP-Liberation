#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onUnitUnloadOne

    File: fn_captives_onUnitUnloadOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-17 12:23:07
    Last Update: 2021-06-20 12:48:01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when UNIT UNLOAD action has occurred.

    Parameter(s):
        _escort - the ESCORT to consider [OBJECT, default: objNull]
        _unitUuid - a UNIT UUID to consider [STRING, default: "]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_escort), objNull, [objNull]]
    , [Q(_unitUuid), "", [""]]
];

private _transport = _escort getVariable [QMVAR(_transport), objNull];

private _debug = MPARAM(_onUnitUnloadOne_debug)
    || (_escort getVariable [QMVAR(_onUnitUnloadOne_debug), false])
    || (_transport getVariable [QMVAR(_onUnitUnloadOne_debug), false])
    ;

if (_debug) then {
    [format ["[fn_captives_onUnitUnloadOne] Entering: [name _escort, typeOf _transport]: %1"
        , str [name _escort, typeOf _transport]], "CAPTIVES", true] call KPLIB_fnc_common_log;
};

private _unit = [_transport, _unitUuid] call MFUNC(_getLoadedCaptives);

if (_unit isEqualType []) exitWith {
    if (_debug) then {
        [format ["[fn_captives_onUnitUnloadOne] Array: [_unitUuid, count _unit]: %1"
            , str [_unitUuid, count _unit]], "CAPTIVES", true] call KPLIB_fnc_common_log;
    };
    false;
};

if (isNull _unit || !alive _unit) exitWith {
    if (_debug) then {
        ["[fn_captives_onUnitUnloadOne] Null or dead", "CAPTIVES", true] call KPLIB_fnc_common_log;
    };
    false;
};

[QMVAR(_unload), [_unit, _escort]] call CBA_fnc_serverEvent;

if (_debug) then {
    ["[fn_captives_onUnitUnloadOne] Fini", "CAPTIVES", true] call KPLIB_fnc_common_log;
};

true;
