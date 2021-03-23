// Ditto shorthand...
#include "script_component.hpp"
/*
    KPLIB_fnc_missions_cloneMission

    File: fn_missions_cloneMission.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 18:53:28
    Last Update: 2021-03-22 11:00:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Clones the CBA MISSION namespace using the nominal variables. Always assigns
        a unique identifier to the clone just besides that. In theory CLONE may support
        any instance in which the developer wants to duplicate an existing MISSION, however,
        the most common, probably only, use case is that of when asked to RUN a MISSION for
        the first time.

    Parameter(s):
        _runningMissionOrTemplate - a CBA MISSION namespace, usually a MISSION TEMPLATE [LOCATION, default: locationNull]
        _variableNamesToClone - the variable names to clone [ARRAY, default: KPLIB_missions_variablesNamesToClone]
        _targetStatus - a target STATUS in which to land [SCALAR, default: MSTATUS(_running)]

    Returns:
        Clone of the CBA RUNNING MISSION or TEMPLATE namespace [LOCATION]
 */

params [
    [Q(_runningMissionOrTemplate), locationNull, [locationNull]]
    , [Q(_variableNamesToClone), +MVAR(_variablesNamesToClone), [[]]]
    , [Q(_targetStatus), MSTATUS(_running), [0]]
];

private _missionClone = [_runningMissionOrTemplate, _variableNamesToClone] call KPLIB_fnc_namespace_clone;

// Requires a bit of additional effort when cloning to a RUNNING MISSION
if (_targetStatus == MSTATUS(_running)) then {
    [
        _runningMissionOrTemplate getVariable [QMVAR(_uuid), ""]
        , _runningMissionOrTemplate getVariable [QMVAR(_templateUuid), ""]
    ] params [
        Q(_uuid)
        , Q(_templateUuid)
    ];
    private _targetTemplateUuid = if (_templateUuid isEqualTo "") then {
        _uuid;
    } else {
        _templateUuid;
    };
    [_missionClone, [
        [QMVAR(_templateUuid), _targetTemplateUuid]
    ]] call KPLIB_fnc_namespace_setVars;
};

/* Which is entirely unique to the clone of the given namespace; not to be confused with
 * the TEMPLATE unique identifier, which can be used to identify its template of origin. */

// Otherwise, simply cloning a MISSION TEMPLATE is pretty straightforward
[_missionClone, [
    [QMVAR(_uuid), [] call KPLIB_fnc_uuid_create_string]
    , [QMVAR(_status), _targetStatus]
    , [QMVAR(_serverTime), serverTime]
]] call KPLIB_fnc_namespace_setVars;

_missionClone;
