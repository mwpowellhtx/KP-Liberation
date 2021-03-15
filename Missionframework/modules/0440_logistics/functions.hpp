/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-24 14:51:36
    Last Update: 2021-03-13 17:27:46
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

    // Returns the current set of known ENDPOINTS
    class logistics_getEndpoints {};

    // Returns the current set of abandoned ENDPOINTS
    class logistics_getEndpointsAbandoned {};

    // Returns the ENDPOINT that is not the OTHER one, or itself if one could not be identified
    class logistics_getEndpointOrNearest {};

    // Returns the ALPHA+BRAVO ENDPOINTS swapped, i.e. BRAVO+ALPHA
    class logistics_swapEndpoints {};

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

    // Returns whether either of the ENDPOINTS can be considered ABANDONED
    class logistics_areEndpointsAbandoned {};

    // Returns the next available transport awaiting either loading or unloading
    class logistics_findNextTransportIndex {};

    // Returns the logistics namespace given a predicate
    class logistics_getNamespaceBy {};

    // Returns the logistics namespace aligned with the given UUID
    class logistics_getNamespaceByUuid {};

    // Returns an enumerated status report composed of human readable decoded status bits
    class logistics_getStatusReport {};

    // Whether ALPHA ENDPOINT bill values has remaining bill value
    class logistics_alphaEndpointHasBillValue {};

    // Whether BRAVO ENDPOINT bill values has remaining bill value
    class logistics_bravoEndpointHasBillValue {};

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

    // Checks the 'KPLIB_logistics_status' is as expected using, in part, 'BIS_fnc_bitflagsCheck'
    class logistics_checkStatus {};

    // Conditionally sets the TARGET bitwise logistics STATUS; supports both TUPLE and LOCATION form factors
    class logistics_setStatus {};

    // Conditionally unsets the TARGET bitwise logistics STATUS; supports both TUPLE and LOCATION form factors
    class logistics_unsetStatus {};

    // Returns whether the TARGET logistics timer has elapsed; supports both TUPLE and LOCATION form factors
    class logistics_timerHasElapsed {};

    // ...
    class logistics_getRefreshedTimer {};

    // Calculates the TRANSIT DURATION in seconds between ALPHA and BRAVO
    class logistics_calculateTransitDuration {};

    // Determins the mid TRANSIT safe zones in terms of TIMER times in seconds
    class logistics_calculateTransitWindow {};

    // Translates 'KPLIB_param_fobRange' in terms of 'KPLIB_param_logistics_transportSpeedKph', in meters per second
    class logistics_calculateFobRangeSeconds {};

    // Calculates line estimated position in terms of elapsed time and 'KPLIB_param_logistics_transportSpeedKph'
    class logistics_calculateEstimatedPos {};

    // ...
    class logistics_convoyIsFull {};

    // ...
    class logistics_convoyIsEmpty {};
};
