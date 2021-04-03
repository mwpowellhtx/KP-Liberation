/*
    KPLIB_fnc_core_postInit

    File: fn_core_postInit.sqf
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

if (isServer) then {
    ["Module initializing...", "POST] [CORE", true] call KPLIB_fnc_common_log;
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

    // TODO: TBD: captured, yes, partially...
    // TODO: TBD: could refactor this as a first class config function...
    ["KPLIB_sector_captured", {
        params [
            ["_markerName", "", [""]]
            , ["_toPlayerSide", true, [false]]
        ];

        // Save, update markers, and notify once change is reported
        [] call KPLIB_fnc_init_save;

        ["KPLIB_updateMarkers"] call CBA_fnc_serverEvent;

        private _sideText = if (_toPlayerSide) then { "blufor"; } else { "opfor"; };

        // TODO: TBD: could normalize names, factory suffixes, radio tower prefixes, introduce gridrefs, etc...
        [
            format [localize "STR_KPLIB_SETTINGS_SECTOR_SEC_CAP_FORMAT"
                , markerText _markerName, toUpper _sideText]
        ] remoteExec ["KPLIB_fnc_notification_hint", 0];

    }] call CBA_fnc_addEventHandler;

    //// TODO: TBD: refactored to 'KPLIB_updateMarkers' event handler
    //[] call KPLIB_fnc_core_updateSectorMarkers;
    execVM "modules\0130_core\scripts\server\sectorMonitor.sqf";
    execVM "modules\0130_core\scripts\server\eventLoop.sqf";
};

if (!hasInterface && !isDedicated) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["Module initialized", "POST] [CORE", true] call KPLIB_fnc_common_log;
};

true;
