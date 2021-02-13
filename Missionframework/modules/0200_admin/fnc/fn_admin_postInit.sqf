#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_admin_postInit

    File: fn_admin_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2017-08-31
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The postInit function of a module takes care of starting/executing the modules functions or scripts.
        Basically it starts/initializes the module functionality to make all provided features usable.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
*/

["Module initializing...", "POST] [ADMIN", true] call KPLIB_fnc_common_log;

// Player section
if (hasInterface) then {
    // Action to open the dialog
    private _actionArray = [
        "<t color='#FF8000'>" + localize "STR_KPLIB_ACTION_ADMIN" + "</t>"
        , {[] call KPLIB_fnc_admin_openDialog}
        , nil
        , KPLIB_ACTION_PRIORITY_ADMIN
        , false
        , true
        , ""
        , '
            _target isEqualTo _originalTarget
            && serverCommandAvailable "#kick"
        '
        , -1
    ];
    [_actionArray] call CBA_fnc_addPlayerAction;

    // TODO: TBD: these are a really shorthand, short term helper
    KPLIB_fnc_admin_respawnOnFobBox = {
        _obj = vehicles select {typeOf _x isEqualTo KPLIB_preset_fobBoxF} select 0;
        _pos = getPos _obj;
        player setPos [(_pos#0), (_pos#1) + 10, 0.1];
    };

    KPLIB_fnc_admin_deleteFobBuildings = {
        {
            deleteVehicle _x;
        } forEach (nearestObjects [player, [], 100] select {
            _x isKindOf "Building";
        });
    };

    KPLIB_fnc_admin_resetFobs = {
        {
            deleteVehicle _x;
        } forEach KPLIB_persistence_objects;
        KPLIB_persistence_objects = [];
        {
            deleteMarker (_x#0);
        } forEach KPLIB_sectors_fobs;
        KPLIB_sectors_fobs = [];
        private _h = [] spawn KPLIB_fnc_init_save;
    };

    KPLIB_fnc_admin_onMoveFobBoxToMap = {
        params ["_pos", "_alt", "_shift"];
        systemChat format ["[fn_admin_postInit] Map clicked: [_pos]: %1", str [_pos]];
        private _obj = vehicles select {typeOf _x isEqualTo KPLIB_preset_fobBoxF} select 0;
        _obj setPos [(_pos#0), (_pos#1), 0.1];
        [] spawn {
            openMap false;
        };
        true;
    };

    KPLIB_fnc_admin_onTeleportPlayer = {
        params ["_pos", "_alt", "_shift"];
        systemChat format ["[fn_admin_postInit] Map clicked: [_pos]: %1", str [_pos]];
        player setPos [(_pos#0), (_pos#1), 0.1];
        [] spawn {
            openMap false;
        };
        true;
    };

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
            && serverCommandAvailable "#kick"
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
            && serverCommandAvailable "#kick"
        '
        , -1
    ];

    [_teleportActionArray] call CBA_fnc_addPlayerAction;
};

["Module initialized", "POST] [ADMIN", true] call KPLIB_fnc_common_log;

true
