#include "script_component.hpp"
/*
    KPLIB_fnc_mission_onGC

    File: fn_mission_onGC.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 13:48:51
    Last Update: 2021-03-22 13:48:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Performs GARBAGE COLLECTION operations on the MISSION.

    Parameter(s):
        _mission - a CBA MISSION namespace on which to perform GARBAGE COLLECTION [LOCATION, default: locationNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    [Q(_mission), locationNull, [locationNull]]
];

if (isNull _mission) exitWith {
    false;
};

[
    MVAR(_registry)
    , keys MVAR(_registry)
    , _mission getVariable [QMVAR1(_uuid), ""]
] params [
    Q(_registry)
    , Q(_keys)
    , Q(_uuid)
];

if (!(_uuid in _keys)) exitWith {
    false;
};

private _deleted = _registry deleteAt _uuid;

if (!(_deleted isEqualTo _mission)) exitWith {
    false;
};

// We do not invoke ANY of the MISSION OBJECT callbacks apart from the state machine at this level
[_deleted] call KPLIB_fnc_namespace_onGC;

true;
