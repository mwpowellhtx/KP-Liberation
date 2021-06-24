#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onWatchInterrogateOne

    File: fn_captives_onWatchInterrogateOne.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-19 23:37:34
    Last Update: 2021-06-19 23:37:35
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Verifies whether the UNIT may be INTERROGATED, and does so if possible.
        Following successful interrogation, resets the 'KPLIB_captives_timer'
        accordingly.

    Parameter(s):
        _unit - a UNIT to interrogate [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_unit), objNull, [objNull]]
];

private _debug = MPARAM(_onWatchInterrogateOne_debug)
    || (_unit getVariable [QMVAR(_onWatchInterrogateOne_debug), false])
    ;

if (isNull _unit || !alive _unit) exitWith {
    false;
};

private _intel = _unit getVariable [QMVAR(_intel), -1];

// TODO: TBD: may need to include some sort of ACE comprehension here, i.e. lift the cuffs, etc...
if (_intel > 0 && ([_unit] call MFUNC(_isUnitCaptured))) then {
    [QMVAR(_interrogated), [_unit, _intel]] call CBA_fnc_serverEvent;
};

true;
