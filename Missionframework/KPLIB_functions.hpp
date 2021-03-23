/*
    KP LIBERATION FUNCTION FETCHING FILE

    File: KPLIB_functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-03-17 19:10:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Fetches all functions from the modules.
*/

//// TODO: TBD: these markers are in...
//// TODO: TBD: eventually, we may slot these includes in a more appropriate spot.
//class MATH {
//};

//class LINQ {
//};

//class UUID {
//};

class KPLIB {
    // Include functions from each module accordingly to the load order
    #include "modules\0000_logger\functions.hpp"
    #include "modules\0001_notification\functions.hpp"
    #include "modules\0003_debug\functions.hpp"
    #include "modules\0005_config\functions.hpp"

    #include "modules\0010_math\functions.hpp"
    #include "modules\0012_unitsofmeasure\functions.hpp"
    #include "modules\0015_linq\functions.hpp"
    #include "modules\0020_uuid\functions.hpp"
    #include "modules\0025_timers\functions.hpp"

    #include "modules\0100_init\functions.hpp"
    #include "modules\0105_namespace\functions.hpp"
    #include "modules\0110_eden\functions.hpp"
    #include "modules\0120_common\functions.hpp"
    #include "modules\0130_core\functions.hpp"
    #include "modules\0135_changeOrders\functions.hpp"
    #include "modules\0140_persistence\functions.hpp"
    #include "modules\0150_respawn\functions.hpp"

    #include "modules\0200_admin\functions.hpp"
    #include "modules\0210_resources\functions.hpp"
    #include "modules\0220_permission\functions.hpp"
    #include "modules\0230_arsenal\functions.hpp"

    #include "modules\0300_plm\functions.hpp"
    #include "modules\0310_virtual\functions.hpp"
    #include "modules\0320_build\functions.hpp"
    #include "modules\0330_garrison\functions.hpp"
    #include "modules\0340_markers\functions.hpp"

    #include "modules\0400_logistic\functions.hpp"

    #include "modules\0410_production\functions.hpp"
    #include "modules\0412_productionSM\functions.hpp"
    #include "modules\0413_productionCO\functions.hpp"
    #include "modules\0415_productionMgr\functions.hpp"

    #include "modules\0420_enemy\functions.hpp"
    #include "modules\0430_cratefiller\functions.hpp"
    
    #include "modules\0440_logistics\functions.hpp"
    #include "modules\0445_logisticsSM\functions.hpp"
    #include "modules\0450_logisticsMgr\functions.hpp"
    #include "modules\0455_logisticsCO\functions.hpp"

    //#include "modules\0800_mission\functions.hpp"
    #include "modules\0800_missions\functions.hpp"
    #include "modules\0800_missions\missions\999_exampleMission\functions.hpp"
    #include "modules\0801_missionsSM\functions.hpp"
    #include "modules\0802_missionsCO\functions.hpp"
    #include "modules\0803_missionsMgr\functions.hpp"
    #include "modules\0810_captive\functions.hpp"

    //#include "modules\0900_missions\functions.hpp"
};
