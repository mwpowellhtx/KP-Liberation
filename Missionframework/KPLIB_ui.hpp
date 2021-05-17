/*
    File: KPLIB_ui.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-05-17 15:42:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Includes all UI defines, dialogs and elements from each module.
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
#include "modules\0208_init\ui.hpp"
// // TODO: TBD: refactoring "titles", or HUD, aspects to an actual HUD module
//#include "modules\0224_core\ui.hpp"
#include "modules\0316_logistic\ui.hpp"
#include "modules\0320_cratefiller\ui.hpp"
#include "modules\0404_admin\ui.hpp"
#include "modules\0420_permission\ui.hpp"
#include "modules\0428_respawn\ui.hpp"

#include "modules\0454_arsenal\ui.hpp"
#include "modules\0458_plm\ui.hpp"
#include "modules\0462_virtual\ui.hpp"

// // TODO: TBD: definitely moving away from this level of tight integration...
//#include "modules\0800_mission\ui.hpp"

// TODO: TBD: in the process of reworking a couple of subtle approaches...
// TODO: TBD: dubbing that effort "X" for the time being...
// TODO: TBD: also focused on production, logistics, probably overlay, assets, ironing out the wrinkles...
#include "KPGUI\XGUI_defines.hpp"
#include "KPGUI\XGUI_classes.hpp"

// TODO: TBD: probably could realign the module numbering...
// TODO: TBD: i.e. HUD should probably come well before some other modules...
// TODO: TBD: definitely well before UI includes, managers, dialogs, etc...
// TODO: TBD: but this 'should' work for the time being...
#include "modules\0436_hud\ui.hpp"

#include "modules\0466_build\ui.hpp"

#include "modules\0504_production\ui.hpp"
#include "modules\0508_logistics\ui.hpp"
#include "modules\0512_garrison\ui.hpp"

#include "modules\0904_missions\ui.hpp"
