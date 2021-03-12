#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_core_handleVehicleSpawn

    File: fn_core_handleVehicleSpawn.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-09-10
    Last Update: 2021-02-12 08:24:30
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
            _vehicle
            , "STR_KPLIB_ACTION_DEPLOY"
            , [
                {["KPLIB_fob_build_requested", [_this select 0]] call CBA_fnc_localEvent}
                , true
                , KPLIB_ACTION_PRIORITY_DEPLOY_FOB
                , false
                , true
                , ""
                , '
                    [_target, _this] call KPLIB_fnc_core_canBuildFob
                '
                , 10
            ]
        ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
    };

    case KPLIB_preset_respawnTruckF;
    case KPLIB_preset_potatoF: {

        _vehicle setVariable ["KPLIB_asset_isMobileRespawn", true, true];

        ////// TODO: TBD: "KPLIB_respawn" is already "in use" in a manner of speaking...
        ////// TODO: TBD: we think it is a bad idea to confuse terminology, usage, when it should be a "class CfgRespawnTemplates {...}" member.
        //// Set vehicle as mobile respawn
        //_vehicle setVariable ["KPLIB_respawn", true, true];

        // Handle some additional MR bookkeeping.
        //// TODO: TBD: don't think we care about setting a UUID on the object itself any longer...
        //_vehicle setVariable ["KPLIB_uuid", [] call KPLIB_fnc_uuid_create_string, true];

        //// TODO: TBD: because we are walking away from the notion of "sector type" ...
        //_vehicle setVariable ["KPLIB_sectorType", KPLIB_sectorType_mob, true];

        // Add redeploy action globaly and for JIP
        [
            // TODO: TBD: was: "_this == vehicle _this"
            // TODO: TBD: the action condition is very similar to actually "querying" for available mobile respawns we think...
            // TODO: TBD: max speed 5, setup a parameter (?)
            // TODO: TBD: max alt, setup a parameter (?)
            _vehicle
            , "STR_KPLIB_ACTION_REDEPLOY"
            , [
                {["KPLIB_respawn_requested", _this] call CBA_fnc_localEvent}
                , nil
                , KPLIB_ACTION_PRIORITY_REDEPLOY
                , false
                , true
                , ""
                , '
                    _this == vehicle _this
                    && ([_target, KPLIB_fnc_eden_callback_onWithinRange] call KPLIB_fnc_eden_select) isEqualTo []
                    && ([_target, KPLIB_fnc_core_fob_callback_onWithinRange] call KPLIB_fnc_core_selectFobs) isEqualTo []
                    && abs (speed _target) < 5
                    && (getPos _target)#2 < 5
                '
                , 10
            ]
        ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
    };

    case KPLIB_preset_addRotaryLightF: {

        // TODO: TBD: startbases / https://github.com/mwpowellhtx/KP-Liberation/issues/2
        // TODO: TBD: rotary flight decks / https://github.com/mwpowellhtx/KP-Liberation/issues/6

        // TODO: TBD: we think there are still considerations concerning whether flight deck actually clear as part of the conditions...

        // Adds moving action for start rotary assets.
        [
            _vehicle
            , "STR_KPLIB_ACTION_ASSETMOVE"
            , [
                {[(_this#0)] call KPLIB_fnc_eden_assetToFlightDeck;}
                , nil
                , KPLIB_ACTION_PRIORITY_ASSETMOVE
                , true
                , true
                , ""
                , '
                    !(([_target] call KPLIB_fnc_eden_selectWithFlightDeck) isEqualTo [])
                '
                , 4
            ]
            , "#FF8000" // TODO: TBD: colors could be defined as first class config variables
        ] remoteExecCall ["KPLIB_fnc_common_addAction", 0, _vehicle];
    };
};

true
