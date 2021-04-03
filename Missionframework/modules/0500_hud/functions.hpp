/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The module function configuration.

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

class hud {
    file = "modules\0500_hud\fnc";

    // Module initialization phase event handler
    class hud_onPreInit {
        preInit = 1;
    };

    // Module initialization phase event handler
    class hud_onPostInit {
        postInit = 1;
    };

    // Gets whether the caller should debug
    class hud_debug {};

    // Prepares the module settings
    class hud_settings {};

    // Setup player actions
    class hud_setupPlayerActions {};

    // Checks the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
    class hud_checkPlayerStatus {};

    // Conditionally sets a HUD mask the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
    class hud_setPlayerStatus {};

    // Conditionally unsets a HUD mask the PLAYER HUD STATUS; prefers DISPATCH, but may specify either
    class hud_unsetPlayerStatus {};

    // Returns whether the elements are in range of each other; favors FOB elements by default
    class hud_inRange {};

    // Returns whether the SECTOR elements are in range of each other; designed specifically for SECTOR concerns
    class hud_sectorInRange {};

    // Refreshes the specified PLAYER TIMER; prefers DISPATCH, but may specify either
    class hud_onRefreshPlayerTimer {};

    // Returns whether the PLAYER TIMER has elapsed; prefers DISPATCH, but may specify either
    class hud_hasPlayerTimerElapsed {};

    // HUD overlay 'onLoad' event handler
    class hud_onLoad {};

    // FOB CT_LISTNBOX 'onLoad' event handler
    class hud_lnbFob_onLoad {};

    // FOB CT_LISTNBOX 'onRefresh' event handler
    class hud_lnbFob_onRefresh {};

    // Responds to CBA waited callback
    class hud_onShow {};

    // Responds to FOB show CBA waited callbacks
    class hud_onShowFob {};

    // Responds to FOB show CBA waited callbacks
    class hud_onShowSector {};

    // Reconciles OVERLAY HASHMAP with an incoming DISPATCH REPORT
    class hud_onReconcileOverlayMap {};

    // Gets the OVERLAY VALUES corresponding to the known HUDDISPATCHSM view data keys
    class hud_getFobViewData {};

    // SECTOR HUD overlay 'onLoad' event handler
    class hudSector_onLoad {};

    // Gets the VIEW DATA for the caller, very generic, and focused for SECTOR REPORT bits
    class hudSector_getViewData {};

    //
    class hudSector_ctrlsGrpSector_lblProgressBar_onLoad {};

    //
    class hudSector_ctrlsGrpSector_lblProgressBar_onRefresh {};

    //
    class hudSector_ctrlsGrpSector_lblSectorText_onLoad {};

    //
    class hudSector_ctrlsGrpSector_lblSectorText_onRefresh {};

    //
    class hudSector_ctrlsGrpSector_lblTimer_onLoad {};

    //
    class hudSector_ctrlsGrpSector_lblTimer_onRefresh {};

    // SECTOR HUD progressSetPosition API, similar to the primitive
    class hudSector_ctrlsGrpSector_progressSetPosition {};
};
