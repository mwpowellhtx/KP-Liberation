/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-05 14:14:12
    Last Update: 2021-04-13 22:58:07
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

    //
    class sectors_getActivatingSectors {};

    // Returns the NEAREST SECTOR to the given MARKER NAME and a set of CANDIDATE MARKERS
    class sectors_getNearestSector {};

    //
    class sectors_getOpforSectors {};

    //
    class sectors_onChangeAlignment {};

    // Tries to GC the given CBA SECTOR namespace
    class sectors_tryGC {};

    //
    class sectors_onNotifyCapture {};

    //
    class sectors_onUpdateMarkers {};

    //
    class sectors_refreshSectorSitrep {};
};
