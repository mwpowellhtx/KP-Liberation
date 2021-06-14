/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-08-02
    Last Update: 2021-06-14 16:47:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class adm {
    file = "modules\0404_admin\fnc";

    //
    class admin_onManHit {};

    // Initialization phase event handler
    class admin_preInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class admin_postInit {
        postInit = 1;
    };

    // Sets up the player actions for the module
    class admin_setupPlayerActions {};

    // Deletes exported data in the players profile
    class admin_deleteExport {};

    // Exports current save data to the players profile
    class admin_exportSave {};

    // Imports save data from the players profile
    class admin_importSave {};

    // Applies provided save data for import to the server profile
    class admin_importSaveServer {};

    // Opens the admin menu dialog
    class admin_openDialog {};

    // Export current campaign to admins profile and requests server to wipe the saved campaign
    class admin_wipe {};

    // An admin shorthand while vetting, debugging, etc
    class admin_onLiberateSectors {};
};
