/*
    KPLIB_fnc_build_preInit

    File: fn_build_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-05-22 15:13:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Initialization phase event handler.

    Parameters:
        NONE

    Returns:
        The event handler has finished [BOOL]
 */

// TODO: TBD: setup proper settings file for the module... including debug params...
private _debug = false;

if (isServer) then {
    ["[fn_build_preInit] Initializing...", "PRE] [BUILD", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
 */

KPLIB_build_buildMode_move          = 0;
KPLIB_build_buildMode_build         = 1;

KPLIB_build_upVectorMode_terrain    = 0;
KPLIB_build_upVectorMode_true       = 1;

KPLIB_build_upVector_true           = [0, 0, 1];

// Left and right mouse buttons are supported
KPLIB_build_mouseButton_left        = 0;
KPLIB_build_mouseButton_right       = 1;
// TODO: TBD: does not seem as though middle mouse button events, down, up, click, are supported; scroll wheel is just fine, but not the button itself
KPLIB_build_mouseButton_middle      = 2;

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

/*
 * Let this serve as documentation for the shape of the builtItem tuple:
 *  _className - the class name of the object being built
 *  _costSupply - the cost in terms of [S]upply
 *  _costAmmo - the cost in terms of [A]mmo
 *  _costFuel - the cost in terms of [F]uel
 */
KPLIB_build_buildItemTemplate = [
    ""
    , 0
    , 0
    , 0
];

if (isServer) then {

    // TODO: TBD: for when we close the gap on building storage at factory sector...
    // TODO: TBD: remember to add the sector variable to said built object

    /* TODO: TBD: caveat, we may be able to conditionally support storage container
     * movement, provided they are not currently hosting any resources attachments. */

    /*
     * KPLIB_asset_isMovable, indicates whether an asset is considered to be movable. Most
     *      objects are; storage containers are a rare exception. See caveat above.
     *
     * KPLIB_fobs_fobUuid, indicates the UUID of the FOB where the asset was originally
     *      built. The current set of FOBs can change during the course of a campaign, and
     *      UUIDs can come and go. But we need to maintain some record that assets were
     *      actually built, and could therefore be managed consequent to their existence.
     *      In addition, we can use this to differentiate between enemy and civilian assets,
     *      apart from friendly ones.
     *
     * KPLIB_sectors_markerName, the current sector of the asset. Storage containers build
     *      supporting a factory sector receive this marker forever and ever more, while the
     *      sector remains "blue". Whereas, assets in transit into or away from FOB zones may
     *      see this variable populate or clear, according to their proximity within the FOB
     *      zone. Both are helpful when determining which assets to stage for serialization,
     *      saving, and loading. Players also receive this variable for the same sorts of
     *      reasons, determing whether actions may be performed associated with FOB zones,
     *      factory sectors, and so on.
     *
     * KPLIB_resources_storageValue, keeps track of a storage container resource summary in
     *      the typical shape, i.e. [0, 0, 0], literally, [[S]upply, [A]ammo, [F]uel].
     *
     * KPLIB_storageTransport_sum, keeps track of the sum of resources being transported
     *      by a given vehicle resource transport, in the same shape as 'KPLIB_resources_storageValue'.
     *      The only difference is, this attribute will not be persistent. Meaning, any resources
     *      caught out of an actual storage container at the time when a server session is restarted
     *      will effectively be lost.
     */
    [[
        "KPLIB_asset_isMovable"
        , "KPLIB_sectors_markerName"
        , "KPLIB_resources_storageValue"], true] call KPLIB_fnc_persistence_addPersistentVars;

    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_build_loadData}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_build_saveData}] call CBA_fnc_addEventHandler;

    ["KPLIB_build_item_built", {
        params [
            ["_object", objNull, [objNull]]
            , ["_markerName", "", [""]]
        ];

        /* We must allow players to select, move, rotate even storage container classes,
         * and FOB buildings. Why is that, because when "building" for the first time,
         * it is unrealistic, even improbable, that the position, alignment, etc, will
         * be correct straight out of the gate. Therefore, we must be able to position,
         * reposition, and align them, just like any other class of object. And, if it
         * means there are stored resources on a particular storage container, so be it,
         * then we must relay that issue as an event on any of the attached objects, set
         * their simulation so they do not cause catastrophic failures, explosions, etc,
         * and re-attach. So be it. */

        // TODO: TBD: may need to connect some dots allowing for FACTORY SECTORY movability...
        _object setVariable ["KPLIB_asset_isMovable", true, true];

        // // // TODO: TBD: of we simply allow for the default save cycle...
        // // // TODO: TBD: especially since build events are separated across client/server boundaries
        // // Must also save the mission when reaching this moment
        // ["fn_build_preInit] spawn KPLIB_fnc_init_save;

    }] call CBA_fnc_addEventHandler;
};

// TODO: TBD: strong candidates to add to CBA settings at some point...
KPLIB_param_build_snapDegrees = 5;
KPLIB_param_build_degreePlaces = 2;

KPLIB_param_build_onBuildStorageClicked_debug                                           = false;

if (hasInterface) then {

    KPLIB_param_build_objectUnderCursor_debug                                           = false;

    KPLIB_param_build_handleKeys_debug                                                  = false;
    KPLIB_param_build_handleKeys_debugSystemChat                                        = false;

    KPLIB_param_build_handleMouse_debug                                                 = false;
    KPLIB_param_build_handleMouse_debugSystemChat                                       = false;

    KPLIB_param_build_handleMouse_onMouseButtonDown_debug                               = false;
    KPLIB_param_build_handleMouse_onMouseButtonUp_debug                                 = false;
    KPLIB_param_build_handleMouse_onMouseButtonClick_debug                              = false;
    KPLIB_param_build_handleMouse_onMouseZChanged_debug                                 = false;
    KPLIB_param_build_handleMouse_onMouseMoving_debug                                   = false;
    KPLIB_param_build_handleMouse_onMouseHolding_debug                                  = false;
    KPLIB_param_build_handleMouse_onMouseZChanged_buildCategoryList_debug               = false;
    KPLIB_param_build_handleMouse_onMouseZChanged_buildList_debug                       = false;

    KPLIB_param_build_handleMouse_onMouseButtonDown_debugSystemChat                     = false;
    KPLIB_param_build_handleMouse_onMouseButtonUp_debugSystemChat                       = false;
    KPLIB_param_build_handleMouse_onMouseButtonClick_debugSystemChat                    = false;
    KPLIB_param_build_handleMouse_onMouseZChanged_debugSystemChat                       = false;
    KPLIB_param_build_handleMouse_onMouseMoving_debugSystemChat                         = false;
    KPLIB_param_build_handleMouse_onMouseHolding_debugSystemChat                        = false;
    KPLIB_param_build_handleMouse_onMouseZChanged_buildCategoryList_debugSystemChat     = false;
    KPLIB_param_build_handleMouse_onMouseZChanged_buildList_debugSystemChat             = false;

    KPLIB_param_build_displayFillList_debug                                             = false;

    ["KPLIB_player_redeploy", { _this call KPLIB_fnc_build_setupPlayerActions; }] call CBA_fnc_addEventHandler;

    // Register build item movement handler
    ["KPLIB_build_item_moved", KPLIB_fnc_build_validatePosition] call CBA_fnc_addEventHandler;

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

    // Respond to STORAGE BUILT locally so that we can reconnect dots with FOB+FACTORY sectors
    ["KPLIB_build_item_built_local", {
        params [
            ["_object", objNull, [objNull]]
            , ["_markerName", "", [""]]
        ];

        private _onRegisterWithFob = {
            params [
                ["_fobBuilding", objNull, [objNull]]
                , ["_markerNames", +KPLIB_sectors_fobs, [[]]]
            ];

            if (_markerName in _markerNames && !isNull _fobBuilding) then {
                {
                    _x append [true];
                    _object setVariable _x
                } forEach [
                    ["KPLIB_fobs_markerName", _markerName]
                    , ["KPLIB_fobs_fobUuid", _fobBuilding getVariable ["KPLIB_fobs_fobUuid", ""]]
                ];
            };
        };

        private _onRegisterWithFactorySector = {
            params [
                ["_player", player, [objNull]]
                , ["_bluforFactorySectors", [] call KPLIB_fnc_sectors_getBluforFactorySectors, [[]]]
            ];

            private _buildMarker = _player getVariable ["KPLIB_build_markerName", ""];

            if (_markerName in _bluforFactorySectors) then {
                _object setVariable ["KPLIB_sectors_markerName", _markerName, true];
            };

            _player setVariable ["KPLIB_build_markerName", nil, true];
        };

        [[_object, KPLIB_param_fobs_range] call KPLIB_fnc_fobs_getNearestBuilding] call _onRegisterWithFob;

        [] call _onRegisterWithFactorySector;

    }] call CBA_fnc_addEventHandler;
};

if (isServer) then {
    ["[fn_build_preInit] Initialized", "PRE] [BUILD", true] call KPLIB_fnc_common_log;
};

true;
