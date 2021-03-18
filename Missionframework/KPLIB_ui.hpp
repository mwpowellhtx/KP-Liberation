/*
    KP LIBERATION UI FETCHING FILE

    File: KPLIB_ui.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-02-26 18:59:09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Includes all ui defines, dialogs and elements from each module.
 */

#include "CBA\defineCommonGrids.hpp"

// TODO: TBD: so... question is, do we want to include the "A3_defines.hpp" here?
// TODO: TBD: we would gain comprehension of definitions such as "CT_LISTNBOX", but there is a lot else defined that we would need to investigate...

#include "KPGUI\defines.hpp"
#include "KPGUI\KPGUI_defines.hpp"
#include "KPGUI\KPGUI_classes.hpp"
#include "modules\0100_init\ui.hpp"
#include "modules\0130_core\ui.hpp"
#include "modules\0150_respawn\ui.hpp"
#include "modules\0200_admin\ui.hpp"
#include "modules\0220_permission\ui.hpp"
#include "modules\0230_arsenal\ui.hpp"
#include "modules\0300_plm\ui.hpp"
#include "modules\0310_virtual\ui.hpp"
#include "modules\0320_build\ui.hpp"
#include "modules\0330_garrison\ui.hpp"
#include "modules\0400_logistic\ui.hpp"
#include "modules\0430_cratefiller\ui.hpp"
#include "modules\0800_mission\ui.hpp"

// TODO: TBD: in the process of reworking a couple of subtle approaches...
// TODO: TBD: dubbing that effort "X" for the time being...
// TODO: TBD: also focused on production, logistics, probably overlay, assets, ironing out the wrinkles...
#include "KPGUI\XGUI_defines.hpp"
#include "KPGUI\XGUI_classes.hpp"
#include "modules\0415_prodMgr\ui.hpp"
//#include "modules\0415_productionMgr\ui.hpp"
#include "modules\0450_logisticsMgr\ui.hpp"
