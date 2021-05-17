#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onTransferConvoyEnd

    File: fn_enemies_onTransferConvoyEnd.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-23
    Last Update: 2021-04-05 09:52:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles convoy processing, after it reached the destination.

    Parameter(s):
        _units - Arrived units of convoy [ARRAY, default: []]
        _destination - Destination of the convoy [STRING, default: ""]

    Returns:
        The event handler finished [BOOL]
 */

private _debug = true;

params [
    ["_units", [], [[]]]
    , ["_destination", "", [""]]
];

// Get group
private _grp = group (_units select 0);

if (_debug) then {
    // !DEBUG!
    hint format ["Arrived: %1\nUnits: %2\nDestination: %3 (%4)"
        , units _grp, _units, markerText _destination, _destination];
};

private _garrisonRef = [_destination, true] call KPLIB_fnc_garrison_getGarrison;

if (_garrisonRef isEqualTo []) then {
    // Determine kind of arrived vehicle
    private _vehicle = objNull;
    {
        if (!(objectParent _x isEqualTo objNull)) exitWith {
            // TODO: TBD: should exit with the vehicle?
            _vehicle = objectParent _x;
            _vehicle;
        };
    } forEach (units _grp);

    switch (true) do {

        case ((typeOf _vehicle) in KPLIB_preset_vehLightArmedPlE): {
            [_destination, typeOf _vehicle] call KPLIB_fnc_garrison_addVeh;
        };

        case ((typeOf _vehicle) in (KPLIB_preset_vehHeavyApcPlE + KPLIB_preset_vehHeavyPlE)): {
            [_destination, typeOf _vehicle, true] call KPLIB_fnc_garrison_addVeh;
        };

        default {
            [_destination, count _units] call KPLIB_fnc_garrison_addInfantry;
        };
    };

    {
        deleteVehicle (vehicle _x);
        deleteVehicle _x;
    } forEach (units _grp);
} else {
    // Add infantry and vehicles to active garrison array for a possible later despawn
    {
        private _vehicle = objectParent _x;

        // Assign to active garrison arrays according to arrived type of reinforcement
        switch (true) do {

            case ((typeOf _vehicle) in KPLIB_preset_vehLightArmedPlE): {
                (_garrisonRef select 3) pushBackUnique _vehicle;
            };

            case ((typeOf _vehicle) in (KPLIB_preset_vehHeavyApcPlE + KPLIB_preset_vehHeavyPlE)): {
                (_garrisonRef select 4) pushBackUnique _vehicle;
            };

            default {
                (_garrisonRef select 2) pushBackUnique _x;
                // If it's infantry with a transport vehicle, let them disembark
                if (!(isNull _vehicle)) then {
                    _grp leaveVehicle _vehicle;
                    (_garrisonRef select 3) pushBackUnique _vehicle;
                };
            };
        };
    } forEach (units _grp);

    // Add patrol task to arrived group
    [_grp, markerPos _destination, 150, 3, 1, 0.6] call CBA_fnc_taskDefend;
};

true;
