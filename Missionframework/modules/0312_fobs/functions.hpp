/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-17 20:03:29
    Last Update: 2021-05-25 11:01:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class fobs {
    file = "modules\0312_fobs\fnc";

    // Arranges module presets
    class fobs_presets {};

    // Arranges module settings
    class fobs_settings {};

    // Returns whether the CANDIDATE object is considered a valid FOB BUILDING
    class fobs_isBuildingValid {};

    // Returns a SORTED ARRAY of all FOB BUILDINGS
    class fobs_getBuildings {};

    // Returns the NEAREST FOB BUILDING to the TARGET object
    class fobs_getNearestBuilding {};

    // Verifies the STARTING BOX|TRUCK when necessary
    class fobs_onVerifyStartingBoxOrTruck {};

    // 'KPLIB_doLoad' event handler
    class fobs_onLoadData {};

    // Sets up DEPLOY FOB client side actions
    class fobs_setupDeployActions {};

    // Sets up PLAYER FOB related actions
    class fobs_setupPlayerActions {};

    //
    class fobs_setupRespawnActions {};

    /* Returns whether player may DEPLOY (i.e. BUILD) an FOB. Supports on site
     * requests, as well as the RANDOM site request. */
    class fobs_canDeploy {};

    // Responds when deploying FOB randomly
    class fobs_onDeployRandom {};

    // FOB deploy requests local (client side) event handler
    class fobs_onDeployRequested {};

    // Which should reconfigure things about the FOB location, markers, etc
    class fobs_onBuildingMoved {};

    // REPACKAGE FOB was requested
    class fobs_onRepackageRequested {};

    // FOB BUILDING TEAR DOWN server side callback
    class fobs_onTearDownBuilding {};

    // VEHICLE CREATED event handler
    class fobs_onVehicleCreated {};

    // Responds on the server side to BUILT ITEM BUILT events
    class fobs_onBuildItemBuilt {};

    // Responds on the client side to BUILT ITEM BUILT LOCAL events
    class fobs_onBuildItemBuiltLocal {};

    // Initialization phase event handler
    class fobs_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class fobs_onPostInit {
        postInit = 1;
    };

    //
    class fobs_onObjectDeserialized {};

    // Sets the FOB BUILDING vehicle variable name
    class fobs_setBuildingVarName {};

    // Unsets the FOB BUILDING vehicle variable name
    class fobs_unsetBuildingVarName {};

    //
    class fobs_resequence {};

    // UPDATE MARKERS event handler
    class fobs_onUpdateMarkers {};

    //
    class fobs_onUpdateMarkerOne {};
};
