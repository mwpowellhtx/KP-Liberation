/*
    File: KPLIB_actionMenu.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-02 22:46:15
    Last Update: 2021-06-14 17:25:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Provides a consistent way of identifying and enumerating action menu defines.
		For use over such cross cutting concerns as menu item priority.
*/

// See: https://community.bistudio.com/wiki/addAction

/* Treating '.hpp' files as first class citizens in the code base...
 * See: https://flaviocopes.com/vscode-language-specific-settings */

#define KPLIB_ACTION_PRIORITY_GATHER_INTEL          (-601)
#define KPLIB_ACTION_PRIORITY_DISARM_IED            (-602)

#define KPLIB_ACTION_PRIORITY_ASSETMOVE             (-700)
#define KPLIB_ACTION_PRIORITY_TERMINATE_TARGET      (-710)
#define KPLIB_ACTION_PRIORITY_OPFOR_CAPTURE         (-720)
#define KPLIB_ACTION_PRIORITY_CIVILIAN_EVENT        (-730)
#define KPLIB_ACTION_PRIORITY_RESISTANCE_EVENT      (-731)
#define KPLIB_ACTION_PRIORITY_DESTROY_BUILDINGS     (-732)
#define KPLIB_ACTION_PRIORITY_GOD_MODE              (-733)

#define KPLIB_ACTION_PRIORITY_REDEPLOY              (-800)
#define KPLIB_ACTION_PRIORITY_ARSENAL               (-801)
#define KPLIB_ACTION_PRIORITY_MISSIONS              (-802)
#define KPLIB_ACTION_PRIORITY_PERMISSIONS           (-803)

#define KPLIB_ACTION_PRIORITY_FOB_DEPLOY            (-810)
#define KPLIB_ACTION_PRIORITY_FOB_DEPLOY_RANDOM     (-811)
#define KPLIB_ACTION_PRIORITY_FOB_PACK_BOX          (-812)
#define KPLIB_ACTION_PRIORITY_FOB_PACK_TRUCK        (-813)

#define KPLIB_ACTION_PRIORITY_REPORT_RESOURCES      (-820)

#define KPLIB_ACTION_PRIORITY_BUILD                 (-870)
#define KPLIB_ACTION_PRIORITY_BUILD_STORAGE         (-871)
#define KPLIB_ACTION_PRIORITY_BUILD_CAPABILITY      (-872)

#define KPLIB_ACTION_PRIORITY_MANAGE_PRODUCTION     (-880)
// TODO: TBD: anticipating log, eventually, for future use...
#define KPLIB_ACTION_PRIORITY_MANAGE_LOGISTICS      (-881)
#define KPLIB_ACTION_PRIORITY_PLAYER_MANAGEMENT     (-882)
#define KPLIB_ACTION_PRIORITY_GARRISON_MANAGEMENT   (-883)

#define KPLIB_ACTION_PRIORITY_ADMIN                 (-890)
#define KPLIB_ACTION_PRIORITY_FOBBOXMOVE            (-891)
#define KPLIB_ACTION_PRIORITY_TELEPORT              (-892)

//#define KPLIB_ACTION_PRIORITY                       ()
//#define KPLIB_ACTION_PRIORITY                       ()
