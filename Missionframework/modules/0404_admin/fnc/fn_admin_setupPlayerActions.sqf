#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_admin_setupPlayerActions

    File: fn_admin_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-04 22:17:52
    Last Update: 2021-06-23 13:17:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up player actions for the module.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
        https://community.bistudio.com/wiki/addAction
 */

if (hasInterface) then {

    addMissionEventHandler ["MapSingleClick", {
        params ["_units", "_pos", "_alt", "_shift"];
        if (isNil "KPLIB_fnc_map_onMapSingleClick") exitWith {
            true;
        };
        private _callback = KPLIB_fnc_map_onMapSingleClick;
        KPLIB_fnc_map_onMapSingleClick = nil;
        private _retval = [_pos, _alt, _shift] call _callback;
        if (_alt) then {
            [] call KPLIB_fnc_admin_respawnOnFobBox;
        };
        _retval;
    }];

    // Action to open the dialog
    [
        [
            "STR_KPLIB_ACTION_ADMIN"
            , { [] call KPLIB_fnc_admin_openDialog; }
            , []
            , KPLIB_ACTION_PRIORITY_ADMIN
            , false
            , true
            , ""
            , "
                _target isEqualTo vehicle _target
                    && _target isEqualTo _originalTarget
                    && ([] call KPLIB_fnc_permission_hasAdminPermission)
            "
            , -1
        ]
        , [["_color", "#ff8000"]]
    ] call KPLIB_fnc_common_addPlayerAction;

    // TODO: TBD: potentially with its own blend of an FSM... i.e. watches the callback, when not nil, opens the map...
    [
        [
            "Move FOB box to map"
            , {
                KPLIB_fnc_map_onMapSingleClick = KPLIB_fnc_admin_onMoveFobBoxToMap;
                [] spawn { openMap true; };
            }
            , []
            , KPLIB_ACTION_PRIORITY_FOBBOXMOVE
            , false
            , true
            , ""
            , "
                _target isEqualTo vehicle _target
                    && _target isEqualTo _originalTarget
                    && ([] call KPLIB_fnc_permission_hasAdminPermission)
            "
            , -1
        ]
        , [["_color", "#ff8000"], ["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            "Create surrendering unit"
            , { _this call KPLIB_fnc_admin_onCreateSurrenderingUnit; }
            , []
            , KPLIB_ACTION_PRIORITY_CREATE_SURRENDERING_UNIT
            , false
            , false
            , ""
            , "[] call KPLIB_fnc_permission_hasAdminPermission"
            , -1
        ]
        , [["_color", "#ff8000"], ["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            "Teleport"
            , {
                KPLIB_fnc_map_onMapSingleClick = KPLIB_fnc_admin_onTeleportPlayer;
                [] spawn { openMap true; };
            }
            , []
            , KPLIB_ACTION_PRIORITY_TELEPORT
            , false
            , true
            , ""
            , "
                !(isNull vehicle _target)
                    && ([] call KPLIB_fnc_permission_hasAdminPermission)
            "
            , -1
        ]
        , [["_color", "#11cc11"], ["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            // TODO: TBD: may teleport including vehicle...
            "Teleport to nearest surrender"
            , {
                params ["_target"];
                private _units = allUnits select { _x getVariable ["KPLIB_surrender", false]; };
                private _nearest = [_units, [], { _x distance _target; }] call BIS_fnc_sortBy;
                private _dist = random [2, 2.5, 3];
                // TODO: TBD: crude, does not avoid obstacles...
                // TODO: TBD: may use garrison instead to identify the position...
                private _vehicle = vehicle _target;
                if (_vehicle isNotEqualTo _target) then {
                    _dist = [typeOf _vehicle] call KPLIB_fnc_common_vehicleSafeRadius;
                };
                private _pos = (_nearest#0) getPos [_dist, random 360];
                private _dir = _target getDir (_nearest#0);
                _target setPos _pos;
                _target setDir _dir;
            }
            , []
            , KPLIB_ACTION_PRIORITY_TELEPORT
            , false
            , true
            , ""
            , "
                ({ _x getVariable ['KPLIB_surrender', false]; } count allUnits) > 0
                    && ([] call KPLIB_fnc_permission_hasAdminPermission)
            "
            , -1
        ]
        , [["_color", "#11cc11"], ["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    KPLIB_fnc_admin_onTerminateTarget = {
        params ["_player", "_caller", "_actionId", "_arguments"];
        private _canTarget = _player getVariable ["KPLIB_admin_candidateTarget", objNull];
        private _crew = crew _canTarget select { alive _x; };
        if (count _crew > 0) then { (_crew#0) setDamage 1; };
        _player getVariable ["KPLIB_admin_candidateTarget", nil];
        true;
    };

    KPLIB_fnc_admin_canTerminateTargets = {
        params ["_player"];
        private _aim = _player weaponDirection currentWeapon _player;
        private _at = getPos _player vectorAdd (_aim vectorMultiply 1000);
        private _playerDir = _player getRelDir _at;
        private _units = allUnits select { (side _x != side _player) && _x distance2D _player < 1000 };
        private _sorted = [_units, [], { (_player getRelDir _x) - _playerDir; }] call BIS_fnc_sortBy;
        _player setVariable ["KPLIB_admin_candidateTarget", nil];
        if (count _sorted > 0) then {
            _player setVariable ["KPLIB_admin_candidateTarget", (_sorted#0)];
        };
        !isNull (_player getVariable ["KPLIB_admin_candidateTarget", objNull]);
    };

    // For more targeted strikes...
    [
        [
            "== TERMINATE TARGET =="
            , { _this call KPLIB_fnc_admin_onTerminateTarget; }
            , []
            , KPLIB_ACTION_PRIORITY_TERMINATE_TARGET
            , false
            , false
            , ""
            , "[_target] call KPLIB_fnc_admin_canTerminateTargets"
            , -1
        ]
        , [["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    KPLIB_fnc_admin_canOpforCaptureSector = { count KPLIB_sectors_blufor > 1; };

    KPLIB_fnc_admin_onOpforSectorCapture = {
        private _sectors = KPLIB_sectors_namespaces select {
            private _markerName = _x getVariable ["KPLIB_sectors_markerName", ""];
            _markerName in KPLIB_sectors_blufor;
        };
        private _sector = selectRandom _sectors;
        private _blufor = true;
        _sector setVariable ["KPLIB_sectors_blufor", _blufor];
        _sector setVariable ["KPLIB_sectors_opfor", !_blufor];
        [_sector] call kplib_fnc_sectors_onSectorCaptured;
    };

    // Allowing admin testing for OPFOR conversion of BLUFOR sectors
    [
        [
            "== OPFOR SECTOR CAPTURE =="
            , { _this call KPLIB_fnc_admin_onOpforSectorCapture; }
            , []
            , KPLIB_ACTION_PRIORITY_OPFOR_CAPTURE
            , false
            , false
            , ""
            , "[_target] call KPLIB_fnc_admin_canOpforCaptureSector"
            , -1
        ]
        , [["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            "-- CIVILIAN NOTIFICATION --"
            , {
                private _image = "\A3\ui_f\data\map\mapcontrol\tourism_CA.paa";
                ["KPLIB_notification_civilian", ["KP LIBERATION - CIVILIAN", _image, "A civilian event occurred."]] call KPLIB_fnc_notification_show;
            }
            , []
            , KPLIB_ACTION_PRIORITY_CIVILIAN_EVENT
            , false
            , false
            , ""
            , "true"
            , -1
        ]
        , [["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            "-- RESISTANCE NOTIFICATION --"
            , {
                private _image = "\A3\ui_f\data\map\mapcontrol\tourism_CA.paa";
                ["KPLIB_notification_resistance", ["KP LIBERATION - RESISTANCE", _image, "A resistance event occurred."]] call KPLIB_fnc_notification_show;
            }
            , []
            , KPLIB_ACTION_PRIORITY_RESISTANCE_EVENT
            , false
            , false
            , ""
            , "true"
            , -1
        ]
        , [["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            "-- DESTROY BUILDINGS --"
            , {
                [] spawn {
                    private _buildings = nearestObjects [getPos player, ["Building"], (KPLIB_param_sectors_capRange/2)];
                    private _toDestroy = 10;
                    private _count = count _buildings;
                    while { (count _buildings > 0) && (count _buildings > _count - _toDestroy); } do {
                        _buildings = _buildings select { alive _x; };
                        if (count _buildings > 0) then {
                            private _building = selectRandom _buildings;
                            _building setDamage 1;
                        };
                    };
                };
            }
            , []
            , KPLIB_ACTION_PRIORITY_DESTROY_BUILDINGS
            , false
            , false
            , ""
            , "true"
            , -1
        ]
        , [["_localize", false]]
    ] call KPLIB_fnc_common_addPlayerAction;

    [
        [
            "STR_KPLIB_ADMIN_TOGGLE_GOD_MODE"
            , {
                params ["_target", "_caller", "_actionId", "_arguments"];
                // This is a separate ID from the ACTIONID
                private _handleDamageID = _caller getVariable ["KPLIB_admin_handleDamageID", -1];
                private _godMode = if (_handleDamageID < 0) then {
                    _handleDamageID = _caller addEventHandler ["HandleDamage", {false}];
                    _caller setVariable ["KPLIB_admin_handleDamageID", _handleDamageID];
                    true;
                } else {
                    _caller removeEventHandler ["HandleDamage", _handleDamageID];
                    _caller setVariable ["KPLIB_admin_handleDamageID", nil];
                    false;
                };
                // TODO: TBD: may be worthwhile adding an API function to update menus...
                _caller setUserActionText [
                    _actionId
                    , ["STR_KPLIB_ADMIN_TOGGLE_MORTAL_MODE", [["_localize", true], ["_color", "#ff0000"]]] call KPLIB_fnc_common_renderActionTitle
                ];
            }
            , []
            , KPLIB_ACTION_PRIORITY_GOD_MODE
            , false
            , true
            , ""
            , "true"
            , -1
        ]
        , [["_localize", true], ["_color", "#ff0000"]]
    ] call KPLIB_fnc_common_addPlayerAction;
};

true;
