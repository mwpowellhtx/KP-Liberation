#include "script_component.hpp"
/*
    KPLIB_fnc_missions_onGetLists

    File: fn_missions_onGetLists.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 14:37:13
    Last Update: 2021-03-22 14:37:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns an array of currently registered MISSIONS from the REGISTRY, separated
        by TEMPLATE MISSIONS and RUNNING MISSIONS, and sorted by SERVERTIME, no questions
        asked. Ignores STATUS concerning COMPLETED, GARBAGE COLLECTION, etc.

    Parameter(s):
        _status - a MISSION STATUS used to filter the REGISTERED MISSIONS
            [SCALAR, default: KPLIB_mission_status_running]

    Returns:
        Two arrays of available MISSIONS: [_missionTemplates, _runningMissions] [ARRAY]
 */

[
    MSTATUS1(_template)
    , MSTATUS1(_running)
] params [
    Q(_template)
    , Q(_running)
];

params [
    [Q(_status), (_template+_running), [0]]
];

// Because we may "see" REGISTRY prior to its being created
if (isNil QMVAR(_registry)) exitWith {
    [];
};

[
    MVAR(_registry)
    , keys MVAR(_registry)
] params [
    Q(_registry)
    , Q(_uuids)
];

// Identify ALL of the MISSIONS by their UUID keys
private _allMissions = _uuids apply { _registry getOrDefault [_x, locationNull]; };

// Get the STATUS MISSIONS ordered by SERVERTIME
private _statusMissions = _allMissions select { !isNull _x && [_x, _status] call MFUNC1(_checkStatus); };
private _sorted = [_statusMissions, [], { _x getVariable [QMVAR1(_serverTime), -1]; }] call BIS_fnc_sortBy;

[
    _sorted select { [_x, _template] call MFUNC1(_checkStatus); }
    , _sorted select { [_x, _running] call MFUNC1(_checkStatus); }
] params [
    Q(_missionTemplates)
    , Q(_runningMissions)
];

// Now return the [MISSION TEMPLATES, RUNNING MISSIONS] in that order, already sorted among themselves
[_missionTemplates, _runningMissions];
