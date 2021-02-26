/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-24 14:51:36
    Last Update: 2021-02-25 14:49:29
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class logistics {
    file = "modules\0440_logistics\fnc";

    // Returns whether caller should conduct debugging
    class logistics_debug {};

    // Module post initialization phase event handler
    class logistics_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logistics_onPreInit {
        preInit = 1;
    };

    //
    class logistics_settings {};

    //
    class logistics_onLoadData {};

    //
    class logistics_onSaveData {};

    // Returns the current set of known endpoints
    class logistics_getEndpoints {};

    // Creates a newly minted logistics tuple (ARRAY)
    class logistics_createArray {};

    //
    class logistics_arrayToNamespace {};

    //
    class logistics_namespaceToArray {};

    // Verifies that the ARRAY is shaped as a valid endpoint tuple
    class logistics_verifyEndpoint {};

    // Verifies that the ARRAY is shaped as a valid logistics tuple
    class logistics_verifyArray {};

    //
    class logistics_verifyNamespace {};

    // Line add event handler
    class logistics_onLineAdd {};

    // Line remove event handler
    class logistics_onLineRemove {};

    // Transport 'build' event handler
    class logistics_onTransportBuild {};

    // Transport 'recycle' event handler
    class logistics_onTransportRecycle {};

    // Returns whether the ALPHA and BRAVO endpoints combination is equal in either direction
    class logistics_areEndpointsEqual {};

    // Returns the next available transport awaiting either loading or unloading
    class logistics_findNextTransportIndex {};

    // Whether the asset has remaining bill at the current ALPHA endpoint
    class logistics_hasCurrentRemainingBill {};

    // Whether the asset bill at both endpoints is completely fulfilled
    class logistics_isTransferComplete {};

    // Returns the calculated, estimated transit distance
    class logistics_getTransitDistance {};

    // Calculates transport position and direction vectors from estimated transit distance, based on nearest road elements, etc
    class logistics_getTransportVectors {};
};
