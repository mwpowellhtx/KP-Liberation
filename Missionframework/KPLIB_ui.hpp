/*
    KP LIBERATION UI FETCHING FILE

    File: KPLIB_ui.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-03-25 12:26:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Includes all ui defines, dialogs and elements from each module.
 */

// Refactored here for convenience
#ifndef KPLIB_IDD_UNDEFINED
#define KPLIB_IDD_UNDEFINED         -1
#endif // KPLIB_IDD_UNDEFINED

#ifndef KPLIB_IDC_UNDEFINED
#define KPLIB_IDC_UNDEFINED         -1
#endif // KPLIB_IDC_UNDEFINED

#include "CBA\defineCommonGrids.hpp"

// TODO: TBD: so... question is, do we want to include the "A3_defines.hpp" here?
// TODO: TBD: we would gain comprehension of definitions such as "CT_LISTNBOX", but there is a lot else defined that we would need to investigate...

#include "KPGUI\defines.hpp"
#include "KPGUI\KPGUI_defines.hpp"
#include "KPGUI\KPGUI_classes.hpp"
#include "modules\0100_init\ui.hpp"
// // TODO: TBD: refactoring "titles", or HUD, aspects to an actual HUD module
//#include "modules\0130_core\ui.hpp"
#include "modules\0150_respawn\ui.hpp"
#include "modules\0200_admin\ui.hpp"
#include "modules\0220_permission\ui.hpp"
#include "modules\0230_arsenal\ui.hpp"
#include "modules\0300_plm\ui.hpp"
#include "modules\0310_virtual\ui.hpp"
#include "modules\0320_build\ui.hpp"
#include "modules\0335_garrisonUI\ui.hpp"
#include "modules\0400_logistic\ui.hpp"
#include "modules\0430_cratefiller\ui.hpp"
// // TODO: TBD: definitely moving away from this level of tight integration...
//#include "modules\0800_mission\ui.hpp"

// TODO: TBD: in the process of reworking a couple of subtle approaches...
// TODO: TBD: dubbing that effort "X" for the time being...
// TODO: TBD: also focused on production, logistics, probably overlay, assets, ironing out the wrinkles...
#include "KPGUI\XGUI_defines.hpp"
#include "KPGUI\XGUI_classes.hpp"
#include "modules\0415_productionMgr\ui.hpp"
#include "modules\0450_logisticsMgr\ui.hpp"
// TODO: TBD: probably could realign the module numbering...
// TODO: TBD: i.e. HUD should probably come well before some other modules...
// TODO: TBD: definitely well before UI includes, managers, dialogs, etc...
// TODO: TBD: but this 'should' work for the time being...
#include "modules\0500_hud\ui.hpp"
#include "modules\0803_missionsMgr\ui.hpp"
