#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onSectorDeactivating

    File: fn_garrison_onSectorDeactivating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-24 12:26:04
    Last Update: 2021-05-05 11:22:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Tries to peel off one of the specified VARIABLE NAME OBJECTS at random.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]
        _variableNames - the variable names to consider being un-GARRISONED [ARRAY, default: _defaultVariableNames]

    Returns:
        The event handler has finished [BOOL]
 */

private _defaultVariableNames = [
    QMVAR(_units)
    , QMVAR(_vehicles)
    , QMVAR(_resources)
];

params [
    [Q(_namespace), locationNull, [locationNull]]
    , [Q(_variableNames), _defaultVariableNames, [[]]]
];

private _trySectorDeactivating = {
    params [
        [Q(_variableName), "", [""]]
    ];

    if (_variableName isEqualTo "") exitWith {
        false;
    };

    private _objs = _namespace getVariable [_variableName, []];

    // Select the UNITS+ASSETS objects that are NOT CAPTURED
    _objs = _objs select { !(_x getVariable [Q(KPLIB_captured), false]); };

    _objs = if (count _objs <= 1) then { _objs; } else {
        _obj call BIS_fnc_arrayShuffle;
    };

    // May be NIL when there were no remaining objects
    _objs params [
        Q(_obj)
    ];

    if (!isNil { _obj; }) then {
        _objs = _objs - [_obj];
        _namespace setVariable [_variableName, _objs];
        deleteVehicle _obj;
    };

    true;
};

{ [_x] call _trySectorDeactivating; } forEach _variableNames;

// Peels off the next available INTEL OBJECT and performs its GC effects
(_namespace getVariable [QMVAR(_intel), []]) call {
    params [
        [Q(_targetObj), objNull, [objNull]]
    ];
    [_targetObj] call KPLIB_fnc_resources_onIntelGC;
};

true;
