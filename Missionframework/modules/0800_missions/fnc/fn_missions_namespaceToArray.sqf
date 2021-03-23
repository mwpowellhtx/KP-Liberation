#include "script_component.hpp"
/*
    KPLIB_fnc_missions_namespaceToArray

    File: fn_missions_namespaceToArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 21:08:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns with a MISSION tuple array given the '_namespace'. May return
        empty array (i.e. []) for locationNull arguments.

    Parameters:
        _mission - A CBA MISSION namespace [LOCATION, default: locationNull]
        _payloadSpecs - the bundle of variables and default values to lift from
            the namespace [ARRAY, default: KPLIB_missions_variableNamesToPublish]

    Returns:
        An array bundle corresponding to the namespace [ARRAY]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
    , [Q(_payloadSpecs), MVAR(_variableNamesToPublish), [[]]]
];

private _onExitWithTelemetry = {
    params [
        [Q(_payload), [], [[]]]
    ];

    private _telemetry = [_mission] call MSFUNC(_getArrayTelemetry);

    if (!isNil Q(_telemetry)) then {
        _payload pushBack _telemetry;
    };

    _payload;
};

if (isNull _mission) exitWith {
    [_payloadSpecs apply { (_x#1); }] call _onExitWithTelemetry;
};

[[_mission, _payloadSpecs] call KPLIB_fnc_namespace_getVars] call _onExitWithTelemetry;
