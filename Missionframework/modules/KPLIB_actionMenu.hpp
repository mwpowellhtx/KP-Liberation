/*
    File: KPLIB_actionMenu.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-02 22:46:15
    Last Update: 2021-02-02 22:46:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Provides a consistent way of identifying and enumerating action menu defines.
		For use over such cross cutting concerns as menu item priority.
*/

// See: https://community.bistudio.com/wiki/addAction

/* Treating '.hpp' files as first class citizens in the code base...
 * See: https://flaviocopes.com/vscode-language-specific-settings */

#define KPLIB_ACTION_PRIORITY_REDEPLOY              (-801)
#define KPLIB_ACTION_PRIORITY_ARSENAL               (-801)
#define KPLIB_ACTION_PRIORITY_MISSIONS              (-801)
#define KPLIB_ACTION_PRIORITY_PERMISSIONS           (-802)

#define KPLIB_ACTION_PRIORITY_BUILD                 (-811)
#define KPLIB_ACTION_PRIORITY_BUILD_STORAGE         (-812)
#define KPLIB_ACTION_PRIORITY_BUILD_CAPABILITY      (-813)

#define KPLIB_ACTION_PRIORITY_MANAGE_PRODUCTION     (-821)
// TODO: TBD: anticipating log, eventually, for future use...
#define KPLIB_ACTION_PRIORITY_MANAGE_LOGISTICS      (-822)
#define KPLIB_ACTION_PRIORITY_PLAYER_MANAGEMENT     (-823)
#define KPLIB_ACTION_PRIORITY_GARRISON_MANAGEMENT   (-824)

#define KPLIB_ACTION_PRIORITY_ADMIN                 (-831)

//#define KPLIB_ACTION_PRIORITY                       ()
//#define KPLIB_ACTION_PRIORITY                       ()
