#include "script_component.hpp"
/*
    KPLIB_fnc_ieds_onGC

    File: fn_ieds_onGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 18:25:20
    Last Update: 2021-06-14 17:09:26
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs GARBAGE COLLECTION duties on the target IED object. May or may not bave
        heen TRIGGERED, DISARMED, or may have also just been deleted.

    Parameter(s):
        _target - the TARGET IED object being GC'ed [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]
 */

private _debug = MPARAM(_onGC_debug);

params [
    [Q(_target), objNull, [objNull]]
];

if (_debug) then {
    [format ["[fn_ieds_onGC] Entering: [isNull _target]: %1"
        , str [isNull _target]], "IEDS", true] call KPLIB_fnc_common_log;
};

if (!isNull _target) then {
    // TODO: TBD: clean up any other variables, triggers, etc, attached to the object...

    // TODO: TBD: may be other bits we need to consider...
    // TODO: TBD: like remove it from the associated sector(s) name space 'KPLIB_garrison_ieds' array...
    deleteVehicle _target;
};

if (_debug) then {
    ["[fn_ieds_onGC] Fini", "IEDS", true] call KPLIB_fnc_common_log;
};

true;
