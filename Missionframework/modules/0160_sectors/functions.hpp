/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 14:14:12
    Last Update: 2021-04-21 14:35:14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class sectors {
    file = "modules\0160_sectors\fnc";

    // Initialization phase event handler
    class sectors_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class sectors_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class sectors_settings {};

    // Returns a created CBA SECTOR namespace with QMVAR(_markerName) variable
    class sectors_createSector {};

    // Loads module data on mission load
    class sectors_onLoadData {};

    // Periodically invoked to save module data during mission save
    class sectors_onSaveData {};

    // Reconciles deserialized SECTOR NAMESPACES with available sector markers
    class sectors_onReconcileSectors {};

    // Returns the icon image path corresponding to the given SECTOR marker name
    class sectors_getSectorIcon {};

    // Returns the CBA SECTOR namespace corresponding to the target MARKER NAME
    class sectors_getNamespace {};

    // Returns the STATUS decomposed into human readable versions of the flags
    class sectors_getStatusReport {};

    // Returns the ACTIVATING SECTOR NAMESPACES between state machine cycles
    class sectors_getActivatingNamespaces {};

    // Returns the NEAREST SECTOR to the given MARKER NAME and a set of CANDIDATE MARKERS
    class sectors_getNearestSector {};

    // Returns the set of INACTIVE MARKERS
    class sectors_getInactiveSectors {};

    // Returns the set of OPFOR MARKERS
    class sectors_getOpforSectors {};

    // SECTOR ACTIVATED event handler
    class sectors_onSectorActivated {};

    // Returns whether the SECTOR may begin the CAPTURING process
    class sectors_getSectorCapturing {};

    // SECTOR CAPTURED event handler
    class sectors_onSectorCaptured {};

    // Returns whether the SECTOR may begin the DEACTIVATING process
    class sectors_getSectorDeactivating {};

    // // Tries to DEACTICATE the known DEACTIVATED CBA SECTOR namespaces
    // class sectors_tryDeactivate {};

    // //
    // class sectors_onNotifyCapture {};

    //
    class sectors_onUpdateMarkers {};

    //
    class sectors_refreshSectorSitrep {};
};
