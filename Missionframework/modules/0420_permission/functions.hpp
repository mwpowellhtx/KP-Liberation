/*
    File: functions.hpp
    Author: KP Liberatin Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-07
    Last Update: 2021-05-22 12:39:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class permission {
    file = "modules\0420_permission\fnc";

    // Gets whether the caller has administrative permission
    class permission_hasAdminPermission {};

    // Adds a new permission to the permission system
    class permission_addPermissionHandler {};

    // Changes the selected permission on the given player
    class permission_changePermission {};

    // Checks the given permission and executes the registered code
    class permission_checkPermission {};

    // Returns whether the REQUESTED permissions have been granted
    class permission_checkPermisisons {};

    // Checks the given vehicle permission and executes the registered code
    class permission_checkVehiclePermission {};

    // Ejects the player and creates a hint
    class permission_ejectPlayer {};

    // Export the permission list to profileNamespace
    class permission_export {};

    // Checks the given permission and returns the result
    class permission_getPermission {};

    // Import the permission list from profileNamespace
    class permission_import {};

    // Initializes the default permissions
    class permission_initDefault {};

    // Loads module specific data from the save
    class permission_loadData {};

    // Open the dialog
    class permission_openDialog {};

    // Module post initialization
    class permission_postInit {
        postInit = 1;
    };

    // Module pre initialization
    class permission_preInit {
        preInit = 1;
    };

    // Checks if the player is already registered to the permission system
    class permission_registerPlayer {};

    // Resets all permissions to default
    class permission_resetToDefault {};

    // Saves module specific data for the save
    class permission_saveData {};

    // CBA Settings initialization for this module
    class permission_settings {};

    // Reads the player permissions and applies them to the dialog controls
    class permission_setupPermissionControls {};

    // Setup of actions available to players
    class permission_setupPlayerActions {};
};
