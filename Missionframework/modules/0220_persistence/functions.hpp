/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-05-23 14:42:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by persistence module.
 */

// TODO: TBD: PERSISTENCE probably needs to happen even before the CORE module(s)...
class persistence {
    file = "modules\0220_persistence\fnc";

    // Returns whether the module debug mode is enabled
    class persistence_debug {};

    // Configures the persistence settings registered through the CBA dependency
    class persistence_settings {};

    // Adds one or more given variable names to persistence system
    class persistence_addPersistentVars {};

    // Create object from seralized data
    class persistence_deserializeObject {};

    // Create unit from serialized data
    class persistence_deserializeUnit {};

    // Deserialize object variables that were loaded from saved data
    class persistence_deserializeVars {};

    // Get serialized cargo data from object
    class persistence_getCargo {};

    // Check if object/unit is persistent
    class persistence_isPersistent {};

    // Loads module specific data from the save
    class persistence_loadData {};

    // Add object/unit to persistence system
    class persistence_makePersistent {};

    // Module pre initialization event handler
    class persistence_preInit {
        preInit = 1;
    };

    // Module post initialization event handler
    class persistence_postInit {
        postInit = 1;
    };

    // Remove object/unit from persistence system
    class persistence_removeFromPersistence {};

    // Saves module specific data for the save
    class persistence_saveData {};

    // Serialize vehicle into an array
    class persistence_serializeObject {};

    // Serialize unit into an array
    class persistence_serializeUnit {};

    // Serialize object variables that were added to persistence system
    class persistence_serializeVars {};

    // Set cargo from serialized data
    class persistence_setCargo {};

    // Set vehicle turret magazines from serialized data
    class persistence_setTurretMagazines {};

    // Installs a CBA per frame request handler object refreshing asset persistence
    class persistence_createRefreshAssetPersistence {};

    // Returns whether the OBJECT should be persistent
    class persistence_shouldBePersistent {};

    // Returns the OBJECTS to persist given the MARKER NAMES, RANGE, etc
    class persistence_getObjects {};
};
