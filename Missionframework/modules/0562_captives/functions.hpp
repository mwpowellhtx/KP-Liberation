/*
    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-09-10
    Last Update: 2021-06-20 10:22:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines for all functions, which are brought by this module.
 */

// TODO: TBD: we can kind of see why events were connected here how they were...
// TODO: TBD: but when there is some confusion between captor and captee, for instance, or escort and captive...
// TODO: TBD: may reconsider which object(s) are receiving the actions, whether to install/uninstall them, and so forth...
class captive {
    file = "modules\0562_captives\fnc";

    // Arranges for module preset variables
    class captives_presets {};

    // Arranges for module CBA settings
    class captives_settings {};

    // Returns the ESCORTED UNIT attached to the player if possible [ACE]
    class captives_getEscortedUnit {};

    // Returns whether the ESCORT IS ESCORTING [ACE]
    class captives_isEscortEscorting {};

    // Returns whether the UNIT is considered SURRENDERING [ACE]
    class captives_isUnitSurrendering {};

    // Returns whether the UNIT is considered CAPTURED [ACE]
    class captives_isUnitCaptured {};

    // Returns whether the UNIT is considered INTERROGATED
    class captives_isUnitInterrogated {};

    // Initialization phase event handler
    class captives_onPostInit {
        postInit = 1;
    };

    // Initialization phase event handler
    class captives_onPreInit {
        preInit = 1;
    };

    // Event handler responds to 'KPLIB_vehicle_created' CBA events
    class captives_onVehicleCreated {};

    // Adds module actions to a UNIT
    class captives_addCaptiveActions {};

    // Adds module actions to an ESCORT
    class captives_addEscortActions {};

    // Adds module actions to a VEHICLE
    class captives_addVehicleActions {};

    // Responding in kind to ONE VEHICLE being surrendered
    class captives_onSurrenderVehicleOne {};

    // Responding in kind to ONE UNIT being surrendered
    class captives_onSurrenderUnitOne {};

    // Cross module event handler responding to 'KPLIB_sectors_captured' events
    class captives_onSectorCapturedSurrenderVehicles {};

    // Cross module event handler responding to 'KPLIB_sectors_captured' events
    class captives_onSectorCapturedSurrenderUnits {};

    // Cross module event handler responding to 'KPLIB_sectors_captured' events
    class captives_onSectorCapturedSetIntel {};

    // Cross module event handler responding to 'KPLIB_sectors_captured' events
    class captives_onSectorCapturedCaptiveTimers {};

    // Cross module event handler responding to 'KPLIB_sectors_captured' events
    class captives_onSectorCapturedScuttleBluforAssets {};

    // Cross module event handler responding to 'KPLIB_sectors_captured' events
    class captives_onSectorCapturedDeleteBluforUnits {};

    // Returns either a single loaded captured unit or an array the same
    class captives_getLoadedCaptives {};

    // Returns whether a transport vehicle can be loaded with a captured unit
    class captives_canLoadTransport {};

    //
    class captives_canLoadUnit {};

    // Returns the nearest transport vehicle that can load captured units
    class captives_getNearestTransport {};

    // Event handler responding to ACE3 captive module status changed [ACE]
    class captives_onAceCaptiveStatusChanged {};

    // Event handler captures a surrendered unit
    class captives_onUnitCapture {};

    // Toggles escorting a captured unit
    class captives_onUnitToggleEscort {};

    // Event handler responds to UNIT LOAD action
    class captives_onUnitLoad {};

    // Action event handler initiating the UNLOAD CAPTIVES COMMANDING MENU
    class captives_onTransportUnload {};

    // Shows the UNLOAD CAPTIVES COMMANDING MENU
    class captives_showUnloadTransportMenu {};

    // Callback unloads one CAPTIVE UNIT and refers to the UNLOAD CAPTIVES COMMANDING MENU once more
    class captives_onUnitUnloadOne {};

    // Event handler responding to the 'GetInMan' vehicle event
    class captives_onPlayerGetInVehicle {};

    // Event handler responding to the 'GetInMan' vehicle event
    class captives_onUnitGetInVehicle {};

    // Event handler responding to the 'GetOutMan' vehicle event
    class captives_onUnitGetOutVehicle {};

    // Watches for CAPTIVE UNITS either which may INTERROGATED and or garbage collected GC
    class captives_onWatchCaptives {};

    // Responds during conditions when ESCORT may be hosting a ghost
    class captives_onWatchStopEscortingOne {};

    // Responds when a WATCH CAPTIVE UNIT may be INTERROGATED
    class captives_onWatchInterrogateOne {};

    // Responds when a WATCH CAPTIVE UNIT may be garbage collected (GC)
    class captives_onWatchTimerElapsedOneGC {};

    // Plays an appropriate animation depending on whether the module UNIT is SURRENDERED, CAPTURED, INTERROGATED
    class captives_playMove {};
};
