/*
    File: KPLIB_functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-05-17 15:48:27
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
    #include "modules\0004_debug\functions.hpp"
    #include "modules\0008_logger\functions.hpp"
    #include "modules\0012_notification\functions.hpp"
    #include "modules\0016_config\functions.hpp"

    #include "modules\0104_string\functions.hpp"
    #include "modules\0108_math\functions.hpp"
    #include "modules\0112_uom\functions.hpp"
    #include "modules\0116_linq\functions.hpp"
    #include "modules\0120_uuid\functions.hpp"
    #include "modules\0124_timers\functions.hpp"
    #include "modules\0128_markers\functions.hpp"
    #include "modules\0132_triggers\functions.hpp"
    #include "modules\0136_namespace\functions.hpp"
    #include "modules\0140_changeOrders\functions.hpp"

    #include "modules\0208_init\functions.hpp"
    #include "modules\0216_common\functions.hpp"
    #include "modules\0224_core\functions.hpp"
    #include "modules\0228_resources\functions.hpp"

    #include "modules\0304_persistence\functions.hpp"
    #include "modules\0308_eden\functions.hpp"
    #include "modules\0316_logistic\functions.hpp"
    #include "modules\0320_cratefiller\functions.hpp"

    #include "modules\0404_admin\functions.hpp"
    #include "modules\0412_sectors\functions.hpp"
    #include "modules\0420_permission\functions.hpp"
    #include "modules\0428_respawn\functions.hpp"
    #include "modules\0436_hud\functions.hpp"

    #include "modules\0454_arsenal\functions.hpp"
    #include "modules\0458_plm\functions.hpp"
    #include "modules\0462_virtual\functions.hpp"
    #include "modules\0466_build\functions.hpp"

    #include "modules\0504_production\functions.hpp"
    #include "modules\0508_logistics\functions.hpp"
    #include "modules\0512_garrison\functions.hpp"
    #include "modules\0516_ieds\functions.hpp"

    #include "modules\0554_soldiers\functions.hpp"
    #include "modules\0558_enemies\functions.hpp"
    #include "modules\0562_captive\functions.hpp"

    #include "modules\0904_missions\functions.hpp"
    #include "modules\0912_wounded\functions.hpp"
    #include "modules\0920_firedrill\functions.hpp"
};
