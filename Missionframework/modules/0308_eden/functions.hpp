/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 02:38:56
    Last Update: 2021-05-17 13:11:38
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

// Eden is code for Operations Base
class eden {
    file = "modules\0308_eden\fnc";

    // Initialization phase event handler
    class eden_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class eden_onPostInit {
        postInit = 1;
    };

    //
    class eden_settings {};

    // Returns a formatted name corresponding to a given base name and optional index
    class eden_getNameAtIndex {};

    // Creates a new Eden tuple given basic information
    class eden_create {};

    // Creates or updates the marker associated with the known Eden tuples
    class eden_onUpdateMarkers {};

    // Enumerates the Eden instances discovered via the missionNamespace variables
    class eden_enumerate {};

    // Selects the Eden bits matching the predicate
    class eden_select {};

    // Selects those Eden bits 'KPLIB_eden_flightDeckProxy' designation
    class eden_selectWithFlightDeck {};

    // Moves asset from its current location to Eden designated 'KPLIB_eden_flightDeckProxy'
    class eden_assetToFlightDeck {};

    //
    class eden_callback_onWithinRange {};

    // Returns the icon image path corresponding to the given SECTOR marker name
    class eden_getSectorIcon {};

    // Returns the sector type for the marker name
    class eden_getSectorType {};
};
