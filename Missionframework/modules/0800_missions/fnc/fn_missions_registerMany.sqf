#include "script_component.hpp"
/*
    KPLIB_fnc_missions_registerMany

    File: fn_missions_registerMany.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 17:28:36
    Last Update: 2021-03-20 17:42:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Registers zero or more MISSION TEMPLATES.

    Parameter(s):
        _namespaces - zero or more CBA MISSION namespaces to register [LOCATION, default: locationNull]

    Returns:
        The indexes of the registered MISSION namespaces [SCALAR]
 */

params [
    [Q(_namespaces), [], [[]]]
];

private _namespaceIndexes = _namespaces apply { [_x] call MFUNC(_registerOne); };

_namespaceIndexes;
