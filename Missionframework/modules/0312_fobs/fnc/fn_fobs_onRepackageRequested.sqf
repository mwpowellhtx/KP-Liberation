#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onRepackageRequested

    File: fn_fobs_onRepackageRequested.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 10:30:14
    Last Update: 2021-05-19 11:28:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        REPACKAGE FOB requested, to either BOX|TRUCK, depending on the arguments.

    Parameter(s):
        ...

    Returns:
        The CBA event handler has finished [BOOL]
 */

params [
    [Q(_player), objNull, [objNull]]
    , Q(_1)
    , Q(_2)
    , [Q(_args), [], [[]]]
];

private _debug = MPARAM(_onRepackageRequested_debug)
    || (_player getVariable [QMVAR(_onRepackageRequested_debug), false])
    ;

_args params [
    [Q(_className), "", [""]]
];

private _fobBuilding = [_player, MPARAM(_range)] call MFUNC(_getNearestBuilding);

if (_debug) then {
    [format ["[fn_fobs_onRepackageRequested] Entering: [_className, isNull _fobBuilding]: %1"
        , str [_className, isNull _fobBuilding]], "FOBS", true] call KPLIB_fnc_common_log;
};

if (!(_className in MPRESET(_boxClassNames)) || isNull _fobBuilding) exitWith {
    [localize "STR_KPLIB_FOBS_FOB_PACK_INVALID"] call KPLIB_fnc_notification_hint;
};

// Reserved for cleanup later on during item built events
_player setVariable [QMVAR(_packBuilding), _fobBuilding];

// Start single item build for fob repackaging
[getPos _fobBuilding, MPARAM(_range), [_className, 0, 0, 0]] call KPLIB_fnc_build_start_single;

if (_debug) then {
    ["[fn_fobs_onRepackageRequested] Fini", "FOBS", true] call KPLIB_fnc_common_log;
};

true;
