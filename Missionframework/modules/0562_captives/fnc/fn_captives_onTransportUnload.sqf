#include "script_component.hpp"
/*
    KPLIB_fnc_captives_onTransportUnload

    File: fn_captives_onTransportUnload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-18 12:14:54
    Last Update: 2021-06-18 12:14:56
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when an UNLOAD CAPTIVES action is made on the VEHICLE.

    Parameter(s):
        _vehicle - a VEHICLE to consider [OBJECT, default: objNull]
        _escort - a ESCORT to consider [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_vehicle), objNull, [objNull]]
    , [Q(_escort), objNull, [objNull]]
];

private _debug = MPARAM(_onTransportUnload_debug)
    || (_escort getVariable [QMVAR(_onTransportUnload_debug), false])
    || (_vehicle getVariable [QMVAR(_onTransportUnload_debug), false])
    ;

_escort setVariable [QMVAR(_transport), _vehicle, true];

[_escort] call MFUNC(_showUnloadTransportMenu);

true;
