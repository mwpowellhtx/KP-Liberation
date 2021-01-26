/*
    KPLIB_fnc_core_handleVehicleSpawn

    File: fn_core_handleVehicleSpawn.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-09-10
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handle vehicle spawn event

    Parameter(s):
        _vehicle - Vehicle which was spawned [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_vehicle", objNull, [objNull]]
];

// TODO: TBD: consider, "on create callbacks" ...
// TODO: TBD: better yet, class-based initializers...
// TODO: TBD: possibly also requiring managers/FSMs for new join players, proxmity objects, i.e. add actions on the fly...
switch (typeOf _vehicle) do {
    // TODO: TBD: supports "F" side only at this time...
    case KPLIB_preset_fobBoxF;
    case KPLIB_preset_fobTruckF: {
        // Add FOB build action globaly and for JIP
        [
            _vehicle,
            "STR_KPLIB_ACTION_DEPLOY",
            [{["KPLIB_fob_build_requested", _this select 0] call CBA_fnc_localEvent}, true, -800, false, true, "", "[_target, _this] call KPLIB_fnc_core_canBuildFob", 10]
        ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
    };

    case KPLIB_preset_respawnTruckF;
    case KPLIB_preset_potatoF: {

        ////// TODO: TBD: "KPLIB_respawn" is already "in use" in a manner of speaking...
        ////// TODO: TBD: we think it is a bad idea to confuse terminology, usage, when it should be a "class CfgRespawnTemplates {...}" member.
        //// Set vehicle as mobile respawn
        //_vehicle setVariable ["KPLIB_respawn", true, true];

        // Handle some additional MR bookkeeping.
        _vehicle setVariable ["KPLIB_uuid", [] call KPLIB_fnc_uuid_create_string, true];
        _vehicle setVariable ["KPLIB_deployType", KPLIB_deployType_mob, true];

        // Add redeploy action globaly and for JIP
        [
            _vehicle,
            "STR_KPLIB_ACTION_REDEPLOY",
            [{["KPLIB_respawn_requested", _this] call CBA_fnc_localEvent}, nil, -801, false, true, "", "_this == vehicle _this", 10]
        ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
    };

    case KPLIB_preset_addRotaryLightF: {

        // TODO: TBD: startbases / https://github.com/mwpowellhtx/KP-Liberation/issues/2
        // TODO: TBD: rotary flight decks / https://github.com/mwpowellhtx/KP-Liberation/issues/6

        // TODO: TBD: we think there are still considerations concerning whether flight deck actually clear as part of the conditions...

        // Adds moving action for start rotary assets.
        [
            _vehicle
            , "STR_KPLIB_ACTION_ROTARYMOVE"
            , [{[_this select 0] call KPLIB_fnc_core_rotaryToFlightDeck;}, nil, 10, true, true, "", "count ([_target] call KPLIB_fnc_core_findStartbasesWithFlightDeck) > 0", 4]
            , "#FF8000" // TODO: TBD: colors could be defined as first class config variables
        ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
    };
};

true
