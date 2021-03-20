// Ditto shorthand...
#include "script_component.hpp"
/*
    KPLIB_fnc_missions_cloneMission

    File: fn_missions_cloneMission.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 18:53:28
    Last Update: 2021-03-19 18:53:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Clones the CBA MISSION namespace using the nominal variables. Always
        assigns a unique identifier to the clone just besides that.

    Parameter(s):
        _namespace - [LOCATION, default: locationNull]
        _variableNamesToClone - the variable names to clone [ARRAY, default: KPLIB_missions_variablesNamesToClone]
        _cloneUuid - given or created unique identifier [UUID, default: _defaultUuid]

    Returns:
        A created CBA MISSION namespace [LOCATION]
 */

private _defaultUuid = [] call KPLIB_fnc_uuid_create_string;

params [
    ["_namespace", locationNull, [locationNull]]
    , ["_variableNamesToClone", +MSVAR(_variablesNamesToClone), [[]]]
    , ["_cloneUuid", _defaultUuid, [""]]
];

private _clone = [_namespace, _variableNamesToClone] call KPLIB_fnc_namespace_clone;

/* Which is entirely unique to the clone of the given namespace; not to be confused with
 * the TEMPLATE unique identifier, which can be used to identify its template of origin. */

[_clone, [
    [QMVAR(_uuid), _cloneUuid]
]] call KPLIB_fnc_namespace_setVars;

_clone;
