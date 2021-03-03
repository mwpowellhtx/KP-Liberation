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

    // Arranges for the module CBA settings
    class logistics_settings {};

    // Arranges to load the module saved data
    class logistics_onLoadData {};

    // Arranges to save the module data
    class logistics_onSaveData {};

    // Returns the current set of known endpoints
    class logistics_getEndpoints {};

    // Creates a newly minted logistics tuple (ARRAY)
    class logistics_createArray {};

    // Converts the given ARRAY to CBA logistics namespace
    class logistics_arrayToNamespace {};

    // Converts the given CBA logistics namespace to ARRAY
    class logistics_namespaceToArray {};

    // Verifies that the ARRAY is shaped as a valid endpoint tuple
    class logistics_verifyEndpoint {};

    // Verifies that the ARRAY is shaped as a valid logistics tuple
    class logistics_verifyArray {};

    // Verifies that the CBA namespace has adequate variable support to be considered a logistics namespace
    class logistics_verifyNamespace {};

    // Returns whether the ALPHA and BRAVO endpoints combination is equal in either direction
    class logistics_areEndpointsEqual {};

    // Returns whether the candidate ENDPOINTS are considered UNIQUE given the set of LINES
    class logistics_areEndpointsUnique {};

    // Returns the next available transport awaiting either loading or unloading
    class logistics_findNextTransportIndex {};

    // Returns the logistics namespace given a predicate
    class logistics_getNamespaceBy {};

    // Returns the logistics namespace aligned with the given UUID
    class logistics_getNamespaceByUuid {};

    // Returns an enumerated status report composed of human readable decoded status bits
    class logistics_getStatusReport {};

    // Whether ALPHA bill values have been fulfilled
    class logistics_hasAlphaBillValues {};

    // Whether the logistics ALPHA and BRAVO bill values have been fulfilled
    class logistics_hasTransferCompleted {};

    // Calculates transport position and direction vectors from estimated transit distance, based on nearest road elements, etc
    class logistics_getTransportVectors {};

    // Calculates an up to date transport speed in meters per second (mps) using 'KPLIB_param_logistics_transportSpeedKph'
    class logistics_calculateTransportSpeedMps {};

    // Calculates the current telemetry for the logistics asset
    class logistics_calculateTelemetry {};

    // Gets a telemetry array corresponding to the CBA logistics namespace
    class logistics_getTelemetryArray {};

    // Sets the telemetry for the given CBA logistics namespace
    class logistics_setTelemetry {};

    // Calibrates the logistics timer given the most up to date in situ sitrep
    class logistics_calibrateTimer {};
};
