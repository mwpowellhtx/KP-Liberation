#include "script_component.hpp"
/*
    KPLIB_fnc_triggers_onGC

    File: fn_triggers_onGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-08 17:16:18
    Last Update: 2021-05-09 00:48:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs the routine GC on the TRIGGER object. Which is effectively removes
        it from the registry and deletes the object vehicle.

    Parameter(s):
        _trigger - a TRIGGER object being garbage collected [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_trigger), objNull, [objNull]]
];

private _debug = MPARAM(_onGC_debug)
    || (_trigger getVariable [QMVAR(_onGC_debug), false]);

if (isServer) then {
    ["[fn_triggers_onGC] Entering...", "TRIGGERS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: this may be too much bookkeeping...
// TODO: TBD: filing in the possibly YAGNI category, KISS, etc
private _uuid = _trigger getVariable [QMVAR(_uuid), ""];

if (isServer) then {
    [format ["[fn_triggers_onGC] Deleting trigger: [_uuid, isNull _trigger]: %1"
        , str [_uuid, isNull _trigger]], "TRIGGERS", true] call KPLIB_fnc_common_log;
};

if (_uuid in MVAR(_registry)) then {
    MVAR(_registry) deleteAt _uuid;
};

if (!isNull _trigger) then {
    deleteVehicle _trigger;
};

if (isServer) then {
    ["[fn_triggers_onGC] Fini", "TRIGGERS", true] call KPLIB_fnc_common_log;
};

true;
