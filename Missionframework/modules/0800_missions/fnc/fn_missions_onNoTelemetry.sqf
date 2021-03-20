#include "script_component.hpp"
/*
    KPLIB_fnc_missions_onNoTelemetry

    File: fn_missions_onNoTelemetry.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 15:33:11
    Last Update: 2021-03-20 15:33:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        A default, no-op placeholder.

    Parameter(s):
        _namespace - [LOCATION, default: locationNull]
        _args - the arguments [ARRAY, default: []]
        _callerName - the caller name invoking the event handler [STRING, default: "fn_missions_onNoOp"]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

[];
