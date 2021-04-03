/*
    File: defines.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Defines the dialog, display, and control identifiers for use throughout
        the module.

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onUnload
 */

#define KPLIB_IDD_HUD_OVERLAY                           90000

// As along as SHADOW controls are in the controlsBackground[], Z order is good to go
#define KPLIB_IDC_HUD_LNB_FOB                           90100
#define KPLIB_IDC_HUD_LNB_FOB_SHADOW                    90110

#define KPLIB_IDD_HUD_SECTOR_OVERLAY                    91000

#define KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR                   91100
#define KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_TIMER         91110
#define KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_SECTOR_TEXT   91120
#define KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_OPFOR      91130

#define KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_BG                91200
#define KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_BLUFOR     91210
