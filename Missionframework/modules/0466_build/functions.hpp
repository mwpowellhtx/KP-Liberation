/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-07-01
    Last Update: 2021-05-17 14:18:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class build {
    file = "modules\0466_build\fnc";

    // Returns whether module debug is suggested
    class build_debug {};

    // Adds buildable items
    class build_addBuildables {};

    // Manages selection depending on currently pressed keys
    class build_addToSelection {};

    // PFH that renders bouding boxes for objects in queue
    class build_boundingBoxPFH {};

    // PFH limiting camera flying area
    class build_camAreaLimiter {};

    // Creates the build camera
    class build_camCreate {};

    // Toggle queue mode between moving existing items and placing new
    class build_changeQueueMode {};

    // Responds when the control loads for the first time
    class build_lblUpVector_onLoad {};

    // Toggles between terrain and true up vector modes
    class build_lblUpVector_onButtonClick {};

    // Confirms all items in queue
    class build_confirmAll {};

    // Confirms single item from queue
    class build_confirmSingle {};

    // Display initialization
    class build_displayLoad {};

    // Place object in build queue
    class build_displayPlaceObject {};

    // Set display build mode (tab)
    class build_displayFillList {};

    // Handle build display unload
    class build_displayUnload {};

    // Draws bounding box on single object
    class build_drawBoundingBox {};

    // PFH that draws icons in 3D space
    class build_drawIconsPFH {};

    // Handle object dragging/positon changing
    class build_handleDrag {};

    // Handle display keypresses
    class build_handleKeys {};

    // Mouse movement and click handler
    class build_handleMouse {};

    // Handle object dragging/rotation
    class build_handleRotation {};

    // FOB build sequence confirmation callback
    class build_onConfirmBuildFob {};

    // Handle persistent data loading
    class build_loadData {};

    // Marks given area with circle created out of spheres
    class build_markArea {};

    // Get user interface item color depending on object state
    class build_objectColor {};

    // Return object under cursor
    class build_objectUnderCursor {};

    // Module post initialization
    class build_postInit {
        postInit = 1;
    };

    // Module pre initialization
    class build_preInit {
        preInit = 1;
    };

    // Removes buildable items from category
    class build_removeBuildables {};

    // Handle persistent data saving
    class build_saveData {};

    // Clear build list search
    class build_searchClear {};

    // Add player actions
    class build_setupPlayerActions {};

    // FOB build requested local CBA event handler
    class build_onFobBuildRequested {};

    // Start building logic
    class build_start {};

    // Start building logic for single item build
    class build_start_single {};

    // Stop building logic
    class build_stop {};

    // Returns surface that is directly under cursor
    class build_surfaceUnderCursor {};

    // Checks if object position is valid for building
    class build_validatePosition {};

    // Gets the movable objects currently within range of the FOB zone, and some other key criteria
    class build_getMovableObjects {};

    // Calculates the snapped and truncated degrees given nominal inputs
    class build_getSnappedDirection {};

    // Renders the heading onto the heading control during the build and move modes
    class build_onBuildItemDirectionSnapped {};

    // Returns whether player can build storage at factory sector
    class build_canBuildStorage {};

    // Client side build storage action menu clicked event handler
    class buildClient_onBuildStorageClicked {};

    // Client side build storage container requested callback
    class buildClient_onBuildStorageRequested {};

    // Server side confirm build storage container callback
    class buildServer_onConfirmBuildStorage {};

    // Gets the display name corresponding to the given class name
    class build_getClassDisplayName {};

    // Registers a display name corresponding to the class name
    class build_registerClassDisplayName {};
};
