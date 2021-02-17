/*
    KPLIB_fnc_build_preInit

    File: fn_build_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-18
    Last Update: 2021-02-12 08:23:58
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
     * KPLIB_fob_originalUuid, indicates the UUID of the FOB where the asset was originally
     *      built. The current set of FOBs can change during the course of a campaign, and
     *      UUIDs can come and go. But we need to maintain some record that assets were
     *      actually built, and could therefore be managed consequent to their existence.
     *      In addition, we can use this to differentiate between enemy and civilian assets,
     *      apart from friendly ones.
     *
     * KPLIB_sector_markerName, the current sector of the asset. Storage containers build
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
        , "KPLIB_fob_originalUuid"
        , "KPLIB_sector_markerName"
        , "KPLIB_resources_storageValue"], true] call KPLIB_fnc_persistence_addPersistentVars;

    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_build_loadData}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_build_saveData}] call CBA_fnc_addEventHandler;

    private _onServerBuildItemBuilt = {
        private _debug = [] call KPLIB_fnc_build_debug;

        // _markerName of the FOB at which the object was built
        params [
            ["_object", objNull, [objNull]]
            , ["_markerName", "", [""]]
        ];

        if (_debug) then {
            [format ["[fn_build_preInit::_onServerBuildItemBuilt] [_object, _markerName]: %1"
                , str [_object, _markerName]], "BUILD", true] call KPLIB_fnc_common_log;
        };

        //// TODO: TBD: we think that possibly we could support moving storage containers...
        //// TODO: TBD: conditioned on whether the asset has attached resources
        //// Storage classes are the one possible exception to movable classes
        //if (!((typeOf _object) in KPLIB_resources_storageClasses)) then {
        //};

        // TODO: TBD: at this moment in dev, we are not producing any resources yet, so it is a good time to get a grip on this issue
        // TODO: TBD: will need to figure out the appropriate time to handle the storage container use cases later on...

        /* We must allow players to select, move, rotate even storage container classes. Why
         * is that, because when "building" for the first time, it is unrealisting, even improbable,
         * that the position, alignment, etc, will be correct straight out of the gate. Therefore,
         * we must be able to position, reposition, and align them, just like any other class of
         * object. And, if it means there are stored resources on a particular storage container,
         * so be it, then we must relay that issue as an event on any of the attached objects,
         * set their simulation so they do not cause catastrophic failures, explosions, etc,
         * and re-attach. So be it. */

        _object setVariable ["KPLIB_asset_isMovable", true, true];

        [_object] call {
            params [
                ["_obj", objNull, [objNull]]
                , ["_default", "", [""]]
            ];
            // TODO: TBD: which it "may" be near a FOB if it was just built...
            // TODO: TBD: but then again, it may not, depending on the context of the build...
            // TODO: TBD: i.e. for scenarios involving enemy or civilian assets...
            private _nearestMarkerAndUuid = [_obj, _default] call KPLIB_fnc_common_getNearestMarkerAndUuid;

            if (!(_nearestMarkerAndUuid isEqualTo [_default, _default])) then {

                if (_debug) then {
                    [format ["[fn_build_preInit::_onServerBuildItemBuilt::call] [str _obj, typeOf _obj, _nearestMarkerAndUuid]: %1"
                        , str [str _obj, typeOf _obj, _nearestMarkerAndUuid]], "BUILD", true] call KPLIB_fnc_common_log;
                };

                // TODO: TBD: may make an event out of this part... or at least a first class function that we can invoke...
                _obj setVariable ["KPLIB_sector_markerName", (_nearestMarkerAndUuid#0), true];
                // TODO: TBD: as long as we note a UUID, then we can probably defer the marker name until an FPS event handler picks up the asset...
                _obj setVariable ["KPLIB_fob_originalUuid", (_nearestMarkerAndUuid#1), true];
            };
        };

        // TODO: TBD: this placement is a pretty distant in terms of client/server hops, events handled, etc, from the point of origin, may not be the best placement...
        [_object] call {
            params [
                ["_obj", objNull, [objNull]]
            ];
            private _sectors = KPLIB_sectors_factory select { _x in KPLIB_sectors_blufor; };
            if (_markerName in _sectors) then {
                _obj setVariable ["KPLIB_sector_markerName", _markerName, true];
            };
        };

        // Must also save the mission when reaching this moment
        [] spawn KPLIB_fnc_init_save;
    };

    ["KPLIB_build_item_built", _onServerBuildItemBuilt] call CBA_fnc_addEventHandler;
};

// TODO: TBD: strong candidates to add to CBA settings at some point...
KPLIB_param_build_snapDegrees = 5;
KPLIB_param_build_degreePlaces = 2;

if (hasInterface) then {

    // Register build item movement handler
    ["KPLIB_build_item_moved", KPLIB_fnc_build_validatePosition] call CBA_fnc_addEventHandler;

    // Register Build module as FOB building provider
    ["KPLIB_fob_build_requested", KPLIB_fnc_build_onFobBuildRequested] call CBA_fnc_addEventHandler;

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
