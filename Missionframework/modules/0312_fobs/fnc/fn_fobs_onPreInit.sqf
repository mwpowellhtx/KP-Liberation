#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_onPreInit

    File: fn_fobs_onPreInit.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:05:28
    Last Update: 2021-05-19 09:43:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Initialization phase event handler.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onPreInit_debug);

if (_debug) then {
    ["[fn_fobs_onPreInit] Initializing...", "PRE] [FOBS", true] call KPLIB_fnc_common_log;
};

// Apply some module presets, settings
[] call MFUNC(_presets);
[] call MFUNC(_settings);

if (isServer) then {
    // Server side init

    // Prepare the SECTORS variable for server and client side usage
    KPLIB_sectors_fobs = [];
    publicVariable Q(KPLIB_sectors_fobs);

    // TODO: TBD: how to deal with destroyed FOB buildings?
    // TODO: TBD: or overrun FOB zones...
    MVAR(_allBuildings)                             = [];

    [[
        QMVAR(_fobIndex)
        , QMVAR(_fobUuid)
        , QMVAR(_markerName)
        , QMVAR(_markerText)
        , QMVAR(_militaryAlpha)
        , QMVAR(_systemTime)
        ], true] call KPLIB_fnc_persistence_addPersistentVars;

    // We respond to LOAD events only, assuming PERSISTENT OBJECTS have been successfully restored
    [Q(KPLIB_doLoad), { [] call MFUNC(_onLoadData); }] call CBA_fnc_addEventHandler;
    // No need to SAVE anything, rather we will lean on the PERSISTENCE module to save the FOB BUILDINGS for us

    [Q(KPLIB_updateMarkers), { [] call MFUNC(_onUpdateMarkers); }] call CBA_fnc_addEventHandler;

    [Q(KPLIB_vehicle_created), { _this call MFUNC(_onVehicleCreated); }] call CBA_fnc_addEventHandler;

    [Q(KPLIB_build_item_built), { _this call MFUNC(_onBuildItemBuilt); }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {

    // REDEPLOY event handling, when PLAYER actually respawns, or when simply 'moving' between sites
    [Q(KPLIB_player_redeploy), { _this call MFUNC(_setupPlayerActions); }] call CBA_fnc_addEventHandler;

    [Q(KPLIB_build_item_moveValidated), { _this call MFUNC(_onBuildingMoved)}] call CBA_fnc_addEventHandler;

    [Q(KPLIB_build_item_built_local), { _this call MFUNC(_onBuildItemBuiltLocal); }] call CBA_fnc_addEventHandler;
};

if (_debug) then {
    ["[fn_fobs_onPreInit] Initialized", "PRE] [FOBS", true] call KPLIB_fnc_common_log;
};

true;
