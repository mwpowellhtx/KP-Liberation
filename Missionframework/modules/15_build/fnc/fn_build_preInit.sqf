/*
    KPLIB_fnc_build_preInit

    File: fn_build_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-01-27 22:27:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The preInit function defines global variables, adds event handlers and set some vital settings which are used in this module.

    Parameters:
        NONE

    Returns:
        Module preInit finished [BOOL]
*/

if (isServer) then {
    ["Module initializing...", "PRE] [BUILD", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
*/

KPLIB_build_buildMode_move = 0;
KPLIB_build_buildMode_build = 1;

// Build camera
KPLIB_build_camera = objNull;

// TODO: TBD: what's going on with the whole build event handling subsystem...
// TODO: TBD: especially vis-a-vis player, deploy, uuid, etc...
// TODO: TBD: let's put build on the shelf for the time being, except possibly whether we see a menu item.
// TODO: TBD: and focus on that much, menu items, conditions, etc...
KPLIB_buildLogic = locationNull;

// Build camera PFH ticker id
KPLIB_build_ticker = -1;

// Object from which FOB build event originated
KPLIB_build_fobBuildObject = objNull;

// Categorized buildable items
KPLIB_build_categoryItems = [];

if (isServer) then {

    // Register sector info var for persistence
    ["KPLIB_sector_info", true] call KPLIB_fnc_persistence_addPersistentVar;

    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_build_loadData}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_build_saveData}] call CBA_fnc_addEventHandler;

    ["KPLIB_build_item_built", {
        // _markerName of the FOB at which the object was built
        params [
            ["_object", objNull, [objNull]]
            , ["_markerName", "", [""]]
        ];

        if (KPLIB_param_builddebug) then {
            [format ["[KPLIB_build_item_built::callback] [_object, _markerName]: %1"
                , str [_object, _markerName]], "BUILD", true] call KPLIB_fnc_common_log;
        };

        // Skip storage areas
        if (!((typeOf _object) in KPLIB_resources_storageClasses)) then {
            private _fobs = KPLIB_sectors_fobs select {(_x select 3 select 0) isEqualTo _markerName};
            // TODO: TBD: if we're here we can be confident we're here?
            // TODO: TBD: see pattern: fn_build_preInit, fn_build_loadData
            private _fob = _fobs select 0;
            _object setVariable ["KPLIB_sector_info", [
                _fob select 3 select 0
                , _fob select 1 select 0
                , _fob select 2 select 0
            ], true];
            _object call KPLIB_fnc_persistence_makePersistent;
        };
    }] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    // Register build item movement handler
    ["KPLIB_build_item_moved", KPLIB_fnc_build_validatePosition] call CBA_fnc_addEventHandler;

    // Register Build module as FOB building provider
    ["KPLIB_fob_build_requested", {
        params [
            ["_object", objNull, [objNull]]
            , ["_pos", KPLIB_zeroPos, [[]], 3]
        ];
        if (KPLIB_param_debug || KPLIB_param_builddebug) then {
            [format ["[KPLIB_fob_build_requested::callback] [_object, getPos _object]: %1"
                , str [_object, getPos _object]], "BUILD", true] call KPLIB_fnc_common_log;
        };
        KPLIB_build_fobBuildObject = _object;
        if (_pos isEqualTo KPLIB_zeroPos) then {
            _pos = getPos KPLIB_build_fobBuildObject;
        };
        // Start single item build for fob building
        [_pos, nil, [KPLIB_preset_fobBuildingF, 0, 0, 0], {
            // On confirm callback, create FOB on server
            [_this select 0, KPLIB_build_fobBuildObject] remoteExec ["KPLIB_fnc_build_handleFobBuildConfirm", 2];
         }] call KPLIB_fnc_build_start_single;
    }] call CBA_fnc_addEventHandler;

    player addEventHandler ["Killed", KPLIB_fnc_build_stop];

    // Handle server notification about not enough resources
    ["KPLIB_build_not_enough_resources", {
        params ["_classname"];
        // TODO common func with caching
        private _name = getText (configFile >> "CfgVehicles" >> _className >> "displayName");
        [format [localize "STR_KPLIB_HINT_BUILD_NO_RESOURCES", _name]] call CBA_fnc_notify;
    }] call CBA_fnc_addEventHandler;

    // Add default buildables from preset
    {
        [
            localize (_x select 0),
            // Add preset vars as code so if preset is changed during gameplay the lists will update dynamically
            compile format ["KPLIB_preset_%1F", _x select 1]
        ] call KPLIB_fnc_build_addBuildables;
    } forEach [
        // Infantry
        ["STR_KPLIB_CAT_INFANTRY", "units"],
        ["STR_KPLIB_CAT_INFANTRY", "specOps"],
        // Light
        ["STR_KPLIB_CAT_LIGHT", "vehLightUnarmed"],
        ["STR_KPLIB_CAT_LIGHT", "vehLightArmed"],
        // Heavy
        ["STR_KPLIB_CAT_HEAVY", "vehHeavyApc"],
        ["STR_KPLIB_CAT_HEAVY", "vehHeavy"],
        // Transport
        ["STR_KPLIB_CAT_TRANSPORT", "vehTrans"],
        // Helicopters
        ["STR_KPLIB_CAT_HELI", "heliTrans"],
        ["STR_KPLIB_CAT_HELI", "heliAttack"],
        // Planes
        ["STR_KPLIB_CAT_PLANES", "planeTrans"],
        ["STR_KPLIB_CAT_PLANES", "jets"],
        // Statics
        ["STR_KPLIB_CAT_AA", "vehAntiAir"],
        // Artillery
        ["STR_KPLIB_CAT_ARTY", "vehArty"],
        // Anti-Air
        ["STR_KPLIB_CAT_STATICS", "statics"],
        // Boats
        ["STR_KPLIB_CAT_BOATS", "boats"],
        // Logistic
        ["STR_KPLIB_CAT_LOGISTIC", "logistic"],
        // Decoration
        ["STR_KPLIB_CAT_DECO", "deco"]
    ];
};

if (isServer) then {
    ["Module initialized", "PRE] [BUILD", true] call KPLIB_fnc_common_log;
};

true
