/*
    KP LIBERATION FUNCTION FETCHING FILE

    File: KPLIB_functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2019-09-10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Fetches all functions from the modules.
*/

//class MATH {
//};

//class LINQ {
//};

//class UUID {
//};

class KPLIB {
    // Include functions from each module accordingly to the load order

    #include "modules\0000_logger\functions.hpp"

    // TODO: TBD: the aim here is to slide the appropriate modules in at the appropriate moments during KPLIB warming up
    // TODO: TBD: we will renumber the bits in stages and during a subsequent sprint...
    // TODO: TBD: ...after having settled on a few basic foundational elements, tuples, Edens, some actions, conditions, etc
    #include "modules\xx_config\functions.hpp"

    // TODO: TBD: will want to establish a new ordering and numbering eventually...
    // TODO: TBD: for now we're just trying to get a handle on some odd evaluations...
    #include "modules\xx_math\functions.hpp"
    #include "modules\xx_linq\functions.hpp"
    // TODO: TBD: for now UUID depends upon LINQ and MATH...
    #include "modules\xx_uuid\functions.hpp"

    #include "modules\xx_timers\functions.hpp"

    #include "modules\00_init\functions.hpp"

    // TODO: TBD: more refactoring candidates...
    #include "modules\xx_eden\functions.hpp"

    #include "modules\01_common\functions.hpp"
    #include "modules\02_core\functions.hpp"
    #include "modules\03_persistence\functions.hpp"
    #include "modules\04_respawn\functions.hpp"
    #include "modules\05_admin\functions.hpp"
    #include "modules\10_resources\functions.hpp"
    #include "modules\11_permission\functions.hpp"
    #include "modules\12_arsenal\functions.hpp"
    #include "modules\13_plm\functions.hpp"
    #include "modules\14_virtual\functions.hpp"
    #include "modules\15_build\functions.hpp"
    #include "modules\16_garrison\functions.hpp"
    #include "modules\23_logistic\functions.hpp"
    #include "modules\24_enemy\functions.hpp"
    #include "modules\26_cratefiller\functions.hpp"
    #include "modules\27_mission\functions.hpp"
    #include "modules\28_captive\functions.hpp"
    #include "modules\90_missions\functions.hpp"
};
