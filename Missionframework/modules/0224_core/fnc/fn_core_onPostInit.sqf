/*
    KPLIB_fnc_core_onPostInit

    File: fn_core_onPostInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2017-08-31
    Last Update: 2021-04-16 08:37:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

if (isServer) then {
    ["[fn_core_onPostInit] Initializing...", "POST] [CORE", true] call KPLIB_fnc_common_log;
};

// Initialize BIS Revive
[] call KPLIB_fnc_core_reviveInit;

// Initialize actions
[] call KPLIB_fnc_core_setupPlayerActions;

// Server section (dedicated and player hosted)
if (isServer) then {
    [] call KPLIB_fnc_core_spawnStartFobBox;
    [] call KPLIB_fnc_core_spawnStartVeh;
    [] call KPLIB_fnc_core_spawnPotato;

    private _onTearDownFob = {
        params [
            ["_markerName", "", [""]]
        ];

        private _fobIndex = KPLIB_sectors_fobs findIf { ((_x#0) isEqualTo _markerName); };

        private _fob = KPLIB_sectors_fobs deleteAt _fobIndex;

        // TODO: TBD: delete FOB building at the site
        private _fobBuilding = nearestObject [(markerPos _markerName), KPLIB_preset_fobBuildingF];
        deleteVehicle _fobBuilding;
        deleteMarker _markerName;

        _milal = [_fobIndex] call KPLIB_fnc_common_indexToMilitaryAlpha;

        private _cid = if (clientOwner == 2) then {0} else {-2};
        [format [localize "STR_KPLIB_FOB_ONTEARDOWN_FORMAT", _milal]] remoteExec ["KPLIB_fnc_notification_hint", _cid];

        ["KPLIB_updateMarkers"] call CBA_fnc_serverEvent;

        [] remoteExec ["KPLIB_fnc_init_save", 2];
    };

    KPLIB_core_tearDownFob = "KPLIB_core_tearDownFob";

    [KPLIB_core_tearDownFob, _onTearDownFob] call CBA_fnc_addEventHandler;

    execVM "modules\0224_core\scripts\server\eventLoop.sqf";
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["[fn_core_onPostInit] Initialized", "POST] [CORE", true] call KPLIB_fnc_common_log;
};

true;
