#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_admin_setupPlayerActions

    File: fn_admin_setupPlayerActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-04 22:17:52
    Last Update: 2021-04-04 22:17:54
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
    private _actionArray = [
        "<t color='#FF8000'>" + localize "STR_KPLIB_ACTION_ADMIN" + "</t>"
        , {[] call KPLIB_fnc_admin_openDialog;}
        , nil
        , KPLIB_ACTION_PRIORITY_ADMIN
        , false
        , true
        , ""
        , '
            _target isEqualTo _originalTarget
                && ([] call KPLIB_fnc_permission_hasAdminPermission)
        '
        , -1
    ];
    [_actionArray] call CBA_fnc_addPlayerAction;

    // TODO: TBD: potentially with its own blend of an FSM... i.e. watches the callback, when not nil, opens the map...
    private _moveFobBoxActionArray = [
        "== MOVE FOB BOX TO MAP =="
        , {
            KPLIB_fnc_map_onMapSingleClick = KPLIB_fnc_admin_onMoveFobBoxToMap;
            [] spawn {
                openMap true;
            };
        }
        , nil
        , KPLIB_ACTION_PRIORITY_FOBBOXMOVE
        , false
        , true
        , ""
        , '
            _target isEqualTo _originalTarget
                && ([] call KPLIB_fnc_permission_hasAdminPermission)
        '
        , -1
    ];

    [_moveFobBoxActionArray] call CBA_fnc_addPlayerAction;

    private _teleportActionArray = [
        "== TELEPORT =="
        , {
            KPLIB_fnc_map_onMapSingleClick = KPLIB_fnc_admin_onTeleportPlayer;
            [] spawn {
                openMap true;
            };
        }
        , nil
        , KPLIB_ACTION_PRIORITY_TELEPORT
        , false
        , true
        , ""
        , '
            _target isEqualTo _originalTarget
                && ([] call KPLIB_fnc_permission_hasAdminPermission)
        '
        , -1
    ];

    [_teleportActionArray] call CBA_fnc_addPlayerAction;

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
    [[
        "== TERMINATE TARGET =="
        , { _this call KPLIB_fnc_admin_onTerminateTarget; }
        , nil
        , KPLIB_ACTION_PRIORITY_TERMINATE_TARGET
        , false
        , false
        , ""
        , "[_target] call KPLIB_fnc_admin_canTerminateTargets"
        , -1
    ]] call CBA_fnc_addPlayerAction;
};

true;