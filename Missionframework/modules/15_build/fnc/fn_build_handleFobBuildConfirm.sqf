/*
    KPLIB_fnc_build_handleFobBuildConfirm

    File: fn_build_handleFobBuildConfirm.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Created: 2018-11-29
    Last Update: 2021-01-26 10:29:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles FOB build confirmation

    Parameter(s):
        _fobBuilding    - Building on which FOB will be created [OBJECT, defaults: objNull]
        _fobBoxObject   - Object from which FOB build orignated [OBJECT, defaults: objNull]

    Returns:
        Confirmation was handled [BOOL]
*/
params [
    ["_fobBuilding", objNull, [objNull]],
    ["_fobBoxObject", objNull, [objNull]]
];

if (isNull _fobBuilding) exitWith {
    ["Null object passed, cannot create FOB", "BUILD"] call KPLIB_fnc_common_log;
};

// Create FOB on position of building
private _fobName = [getPos _fobBuilding] call KPLIB_fnc_core_buildFob;

/* AMEN for determinism, we KNOW that we know we are creating a FOB at this moment,
 * without needing to parse through a needlessly complex global event trees. */
_fobBuilding setVariable ["KPLIB_uuid", [] call KPLIB_fnc_uuid_create_string, true];
_fobBuilding setVariable ["KPLIB_deployType", KPLIB_deployType_fob, true];

// Emit the built event with FOB and object to assign the object to freshly built FOB
["KPLIB_build_item_built", [_fobBuilding, _fobName]] call CBA_fnc_globalEvent;

// Remove FOB box from which FOB build originated
deleteVehicle _fobBoxObject;

true
