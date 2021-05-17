/*
    KPLIB_fnc_core_spawnPotato

    File: fn_core_spawnPotato.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-05-01
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Spawning of the Potato 01 helicopter.

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

/*
 * Was in while we troubleshot the rotary asset move startbase enhancements.
 * Leaving commented bit in for the time being.
 * https://github.com/mwpowellhtx/KP-Liberation/issues/6
 * //if (true) exitWith {};
*/

// TODO: TBD: "KPLIB_core_potato01" (?) we think there is an opportunity there allowing for potentially several such "managed" assets...
// TODO: TBD: possibly in state machines of their own...
// Check if there wasn't a Potato 01 already spawned or if the spawned one is destroyed.
// !NOTE! As the loading will happen before this function is called, it won't interfere with a loaded Potato 01.
if(!isServer || alive KPLIB_core_potato01) exitWith {};

// If Potato 01 wreck is too close to respawn we should delete it.
if((KPLIB_core_potato01 distance2D KPLIB_eden_potatospawn) < 10 && !alive KPLIB_core_potato01) exitWith {
    deleteVehicle KPLIB_core_potato01;
    // Spawn Helicopter after wreck was deleted
    [{[] call KPLIB_fnc_core_spawnPotato}, [], 1] call CBA_fnc_waitAndExecute;
};

// Position for the spawn.
private _spawnPos = getPosATL KPLIB_eden_potatospawn;

// Create Potato 01 at the spawn position with a slight height offset.
KPLIB_core_potato01 = [KPLIB_preset_potatoF, [_spawnPos select 0, _spawnPos select 1, (_spawnPos select 2) + 0.1], getDir KPLIB_eden_potatospawn, true] call KPLIB_fnc_common_createVehicle;

// Declare as ace medical vehicle (can also be set if ACE is not used)
KPLIB_core_potato01 setVariable ["ace_medical_medicClass", 1, true];

// Add event handler to call this script again if we have a "Potato down".
KPLIB_core_potato01 addMPEventHandler ["MPKilled", {[] call KPLIB_fnc_core_spawnPotato}];

true
