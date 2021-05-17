#include "script_component.hpp"
/*
    KPLIB_fnc_missions_registerMany

    File: fn_missions_registerMany.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 17:28:36
    Last Update: 2021-03-22 12:53:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Registers zero or more MISSION TEMPLATES.

    Parameter(s):
        _missions - zero or more CBA MISSION namespaces to register [LOCATION, default: locationNull]

    Returns:
        An ARRAY of each individual REGISTER ONE result [ARRAY of BOOL]
 */

params [
    [Q(_missions), [], [[]]]
];

private _retvals = _missions apply { [_x] call MFUNC(_registerOne); };

_retvals;
