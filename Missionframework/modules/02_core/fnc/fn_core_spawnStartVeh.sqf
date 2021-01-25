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
    , ["KPLIB_eden_boat_", KPLIB_preset_addBoatF, nil, nil, true]
    , ["KPLIB_eden_turret_gun_", KPLIB_preset_turretGunF]
    , ["KPLIB_eden_turret_phalanx_", KPLIB_preset_turretPhalanxMinigunF]
    , ["KPLIB_eden_turret_sam_short_", KPLIB_preset_turretShortRangeSamF]
    , ["KPLIB_eden_turret_sam_medium_", KPLIB_preset_turretMediumRangeSamF]
    , ["KPLIB_eden_turret_vls_", KPLIB_preset_turretVlsF]
];

// TODO: TBD: instead of "just doing" this algo, we may need/want to wait for the proxies to have been initialized...
// TODO: TBD: as based on observations below, does not seem to be the case...
{
    _x params [
        "_prefix"
        , "_classname"
        , ["_justSpawn", true]
        , ["_withCrew", false]
        , ["_addVicToCargo", false]
    ];

    for [{_i = 0}, {!isNil (_prefix + str _i)}, {_i = _i + 1}] do {

        // TODO: TBD: cannot wait for the individual object init to occur (?), does not seem to align properly...
        // Get the spawn point grasscutter
        _proxyObj = missionNamespace getVariable (_prefix + str _i);

        private _proxyObj_addVicToCargo = _proxyObj getVariable ["KPLIB_eden_addVicToCargo", false];
        private _proxyObj_withCrew = _proxyObj getVariable ["KPLIB_eden_withCrew", false];

        [format ["Creating vic %1 at proxy %2: {""withCrew"": %3, ""addVicToCargo"": %4}"
            , _classname, _prefix + str _i, str _proxyObj_addVicToCargo, str _proxyObj_withCrew]
            , "SPAWN START VIC", true] call KPLIB_fnc_common_log;

        // Current position for the proxy object
        _proxyPos = if (_addVicToCargo) then {KPLIB_zeroPos} else {
            private _pos = getPosATL _proxyObj;
            [_pos select 0, _pos select 1, (_pos select 2) + 0.1];
        };

        // Spawn the vehicle at the spawn position with a slight height offset.
        _vic = [_classname, _proxyPos, getDir _proxyObj, _justSpawn, _withCrew] call KPLIB_fnc_common_createVehicle;

        // TODO: TBD: see, anticipating: https://github.com/mwpowellhtx/KP-Liberation/issues/8
        _vic setVariable ["KPLIB_asset_accounting", false, true];

        [format ["Vic created %1 at proxy %2", _classname, _prefix + str _i], "SPAWN START VIC", true] call KPLIB_fnc_common_log;

        if (_addVicToCargo) then {_proxyObj setVehicleCargo _vic};
    };
} forEach _specs;

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
