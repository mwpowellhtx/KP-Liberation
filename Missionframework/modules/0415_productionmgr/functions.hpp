/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 09:57:57
    Last Update: 2021-02-06 09:58:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class productionMgr {
    file = "modules\0415_productionMgr\fnc";

    // Module pre initialization
    class productionMgr_onPreInit {
        preInit = 1;
    };

    // Module post initialization
    class productionMgr_onPostInit {
        postInit = 1;
    };

    // Opens the module dialog
    class productionMgr_openDialog {};

    // Setup the player action menu
    class productionMgr_setupPlayerMenu {};

    // Module display onLoad event handler
    class productionMgr_onLoad {};

    // Sectors list box onLoad event handler
    class productionMgr_lnbSectors_onLoad {};

    // Sectors list box onLBSelChanged event handler
    class productionMgr_lnbSectors_onLBSelChanged {};

    // Status list box onLoad event handler
    class productionMgr_lnbStatus_onLoad {};

    // Status list box onLBSelChanged event handler
    class productionMgr_lnbStatus_onLBSelChanged {};

    // Status list box onLBDblClick event handler
    class productionMgr_lnbStatus_onLBDblClick {};

    // ...
    class productionMgr_ctrlBg_title_onLoad {};

    // ...
    class productionMgr_onLoad_debug {};
};
