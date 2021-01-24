/*
    KPLIB_fnc_core_spawnStartVeh

    File: fn_core_spawnStartVeh.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell (22nd MEU SOC)
    Date: 2017-05-01
    Last Update: 2021-01-23 22:59:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Spawning of the start vehicles like the little birds and rubber dinghies. Also spawns crew for the destroyer weapon systems.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// local variables
private _proxyObj = objNull;
private _proxyPos = KPLIB_zeroPos;
private _vic = objNull;

// ["_prefix", "_classname"]
// ["_prefix", "_classname", "_pos", "_dir"]

// TODO: TBD: could potentially refactor these to init config area...
// TODO: TBD: and potentially with macro-driven initialization...
// TODO: TBD: at least in keeping with other config inits...

// Refactor static gun placements in terms of object proxies / https://github.com/mwpowellhtx/KP-Liberation/issues/3
// TODO: TBD: so... this is hard-coded at the moment favoring the "F" faction...
// TODO: TBD: not sure whether possible to allow for "E" or other factions in terms of spawn points...
// TODO: TBD: may expose these by conf settings...
private _specs = [
    ["KPLIB_eden_rotary_light_", KPLIB_preset_addRotaryLightF]
    , ["KPLIB_eden_rotary_unarmed_", KPLIB_preset_addRotaryUnarmedF]
    , ["KPLIB_eden_rotary_armed_", KPLIB_preset_addRotaryArmedF]
    , ["KPLIB_eden_ground_light_", KPLIB_preset_addGroundLightF]
    , ["KPLIB_eden_ground_armed_", KPLIB_preset_addGroundArmedF]
    , ["KPLIB_eden_ground_armored_", KPLIB_preset_addGroundArmoredF]
    // TODO: TBD: which assumes that they are loading in boat actual racks...
    , ["KPLIB_eden_boat_", KPLIB_preset_addBoatF, true]
];

// B_SAM_System_01_F / Mk49 Spartan
// B_AAA_System_01_F / Praetorian 1C
// B_Ship_MRLS_01_F / Mk41 VLS
// B_Ship_Gun_01_F Mk45 Hammer

{
    _x params [
        "_prefix"
        , "_classname"
        , ["_addVicToProxyCargo", false]
    ];

    for [{_i = 0}, {!isNil (_prefix + str _i)}, {_i = _i + 1}] do {

        // Get the spawn point grasscutter
        _proxyObj = missionNamespace getVariable (_prefix + str _i);

        // Current position for the proxy object
        _proxyPos = if (_addVicToProxyCargo) then {KPLIB_zeroPos} else {
            private _pos = getPosATL _proxyObj;
            [_pos select 0, _pos select 1, (_pos select 2) + 0.1]
        };

        // Spawn the vehicle at the spawn position with a slight height offset.
        _vic = [_classname, _proxyPos, getDir _proxyObj, true] call KPLIB_fnc_common_createVehicle;

        if (_addVicToProxyCargo) then {_proxyObj setVehicleCargo _vic};
    };
} forEach _specs;

// UH-80 Ghost Hawk / B_Heli_Transport_01_F
// UH-80 Ghost Hawk (Sand) / B_CTRG_Heli_Transport_01_sand_F (requires Apex)
// UH-80 Ghost Hawk (Tropic) / B_CTRG_Heli_Transport_01_tropic_F (requires Apex)
// AH-99 Blackfoot / B_Heli_Attack_01_dynamicLoadout

// Prowler / B_LSV_01_unarmed_F (requires Apex)
// Prowler (HMG) / B_LSV_01_armed_F (requires Apex)
// Hunter / B_MRAP_01_F

//// TODO: TBD: no need either of these for this one when we can script a loop for a suite of specs...
//// Go through the available markers for the little bird spawn. Adapts to the amount of placed markers.
//for [{_i=0}, {!isNil ("KPLIB_eden_littlebird_" + str _i)}, {_i = _i + 1}] do {
//    // Get the spawn point grasscutter
//    _proxyObj = missionNamespace getVariable ("KPLIB_eden_littlebird_" + str _i);
//
//    // Current position for the spawn
//    _proxyPos = getPosATL _proxyObj;
//
//    // Spawn the vehicle at the spawn position with a slight height offset.
//    [_classname, [_proxyPos select 0, _proxyPos select 1, (_proxyPos select 2) + 0.1], getDir _proxyObj, true] call KPLIB_fnc_common_createVehicle;
//};

//// Spawn the boats and move them in the boat racks
//for [{_i=0}, {!isNil ("KPLIB_eden_boat_" + str _i)}, {_i = _i + 1}] do {
//    // Get the current rack
//    _proxyObj = missionNamespace getVariable ("KPLIB_eden_boat_" + str _i);
//
//    // TODO: TBD: "zero pos", better yet the "ghost spot" (?)
//    // TODO: TBD: zero which "works" in this case because it is a boat...
//    // Spawn the boat
//    _vic = [KPLIB_preset_addBoatF, KPLIB_zeroPos, getDir _proxyObj, true] call KPLIB_fnc_common_createVehicle;
//
//    // Move the boat to the rack
//    _proxyObj setVehicleCargo _vic;
//};

// Spawn crew for the destroyer weapons, so they're available through the UAV terminal
for [{_i = 0}, {!isNil ("KPLIB_eden_destroyer_w" + str _i)}, {_i = _i + 1}] do {
    // Get the current weapon
    _vic = missionNamespace getVariable ("KPLIB_eden_destroyer_w" + str _i);

    // Create crew
    createVehicleCrew _vic;
};

true
