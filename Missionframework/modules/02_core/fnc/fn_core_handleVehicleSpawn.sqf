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
        // Set vehicle as mobile respawn
        _vehicle setVariable ["KPLIB_respawn", true, true];
        // Add redeploy action globaly and for JIP
        [
            _vehicle,
            "STR_KPLIB_ACTION_REDEPLOY",
            [{["KPLIB_respawn_requested", _this] call CBA_fnc_localEvent}, nil, -801, false, true, "", "_this == vehicle _this", 10]
        ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
    };

    case KPLIB_preset_addRotaryLightF: {
        // TODO: TBD: Allow for one or more start base proxies / https://github.com/mwpowellhtx/KP-Liberation/issues/2
        // TODO: TBD: identify places where startbase is being used...
        // TOPO: TBD: and we need to run that same exercise rendering to an array of discovered elements...
        // TODO: TBD: we could do with a module dealing with all that actually...
        // TODO: TBD: 2021-01-24 02:11:05 at this time estimating perhaps a dozen or so places need to be checked
        if ((_vehicle distance KPLIB_eden_startbase) < 20) then {
            // Add moving action for start helicopters
            [
                _vehicle,
                "STR_KPLIB_ACTION_HELIMOVE",
                [{[_this select 0] call KPLIB_fnc_core_heliToDeck;}, nil, 10, true, true, "", "(_target distance KPLIB_eden_startbase) < 20", 4],
                "#FF8000"
            ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
        };
    };
};

true
