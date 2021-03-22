/*
    KP Liberation missions manager dialog

    File: KPLIB_missionsMgr.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 18:57:14
    Last Update: 2021-03-14 18:05:41
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Layout for the module dialog.

    References:
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE

*/

#define KPLIB_MISSIONSMGR_DIALOG_WC             KPX_DEFAULT_DIALOG_WC
#define KPLIB_MISSIONSMGR_DIALOG_HC             KPX_DEFAULT_DIALOG_HC

#define KPLIB_MISSIONSMGR_DIALOG_XC             KPX_GETXC_W2(KPLIB_MISSIONSMGR_DIALOG_WC)
#define KPLIB_MISSIONSMGR_DIALOG_YC             KPX_GETYC_H2(KPLIB_MISSIONSMGR_DIALOG_HC)

#define KPLIB_MISSIONSMGR_TITLE_X               KPLIB_MISSIONSMGR_DIALOG_XC
#define KPLIB_MISSIONSMGR_TITLE_Y               KPLIB_MISSIONSMGR_DIALOG_YC
#define KPLIB_MISSIONSMGR_TITLE_W               KPLIB_MISSIONSMGR_DIALOG_WC
#define KPLIB_MISSIONSMGR_TITLE_H               KPX_TITLE_M_H

#define KPLIB_MISSIONSMGR_BG_X                  KPLIB_MISSIONSMGR_TITLE_X
#define KPLIB_MISSIONSMGR_BG_Y                  (KPLIB_MISSIONSMGR_TITLE_Y + KPLIB_MISSIONSMGR_TITLE_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BG_W                  KPLIB_MISSIONSMGR_TITLE_W
#define KPLIB_MISSIONSMGR_BG_H                  (KPLIB_MISSIONSMGR_DIALOG_HC - KPLIB_MISSIONSMGR_TITLE_H - KPX_SPACING_H)

#define KPLIB_MISSIONSMGR_CTRLAREA_X            (KPLIB_MISSIONSMGR_BG_X + KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_CTRLAREA_Y            (KPLIB_MISSIONSMGR_BG_Y + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_CTRLAREA_W            (KPLIB_MISSIONSMGR_BG_W - (2 * KPX_SPACING_W))
#define KPLIB_MISSIONSMGR_CTRLAREA_H            (KPLIB_MISSIONSMGR_BG_H - (2 * KPX_SPACING_H))

#define KPLIB_MISSIONSMGR_CROSS_X               (KPLIB_MISSIONSMGR_TITLE_X + KPLIB_MISSIONSMGR_TITLE_W - GUI_GRID_W)
#define KPLIB_MISSIONSMGR_CROSS_Y               (KPLIB_MISSIONSMGR_TITLE_Y + KPX_SPACING_H)

#define KPLIB_MISSIONSMGR_BTN_H                 KPX_GETH_VHGS(KPLIB_MISSIONSMGR_CTRLAREA_H,1,19,KPX_SPACING_H)

// Sectors list box height including buffer for two buttons below it
#define KPLIB_MISSIONSMGR_LNB_MISSIONS_X        KPLIB_MISSIONSMGR_CTRLAREA_X
#define KPLIB_MISSIONSMGR_LNB_MISSIONS_Y        KPLIB_MISSIONSMGR_CTRLAREA_Y
#define KPLIB_MISSIONSMGR_LNB_MISSIONS_W        KPX_GETW_VWGS(KPLIB_MISSIONSMGR_CTRLAREA_W,16,32,KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_LNB_MISSIONS_H        KPX_GETH_VHGS(KPLIB_MISSIONSMGR_CTRLAREA_H,18,19,KPX_SPACING_H)

#define KPLIB_MISSIONSMGR_BTN_LINES_GETY(BY)    (KPLIB_MISSIONSMGR_LNB_MISSIONS_Y + KPLIB_MISSIONSMGR_LNB_MISSIONS_H + ((BY + 1) * KPX_SPACING_H) + (BY * KPLIB_MISSIONSMGR_BTN_H))

#define KPLIB_MISSIONSMGR_BTN_W                 KPLIB_MISSIONSMGR_LNB_MISSIONS_W
#define KPLIB_MISSIONSMGR_BTN_LINES_W2          (0.5 * (KPLIB_MISSIONSMGR_BTN_W - KPX_SPACING_W))

#define KPLIB_MISSIONSMGR_BTN_MISSION_RUN_X     KPLIB_MISSIONSMGR_CTRLAREA_X
#define KPLIB_MISSIONSMGR_BTN_LINE_REMOVE_X     (KPLIB_MISSIONSMGR_BTN_MISSION_RUN_X + KPLIB_MISSIONSMGR_BTN_LINES_W2 + KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BTN_REFRESH_X         KPLIB_MISSIONSMGR_BTN_MISSION_RUN_X

#define KPLIB_MISSIONSMGR_BTN_MISSIONS_Y        (KPLIB_MISSIONSMGR_LNB_MISSIONS_Y + KPLIB_MISSIONSMGR_LNB_MISSIONS_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BTN_MISSIONS_W        (0.5 * (KPLIB_MISSIONSMGR_LNB_MISSIONS_W - KPX_SPACING_W))

#define KPLIB_MISSIONSMGR_MISSIONS_BTN_RUN_X    KPLIB_MISSIONSMGR_LNB_MISSIONS_X
#define KPLIB_MISSIONSMGR_MISSIONS_BTN_ABORT_X  (KPLIB_MISSIONSMGR_MISSIONS_BTN_RUN_X + KPLIB_MISSIONSMGR_BTN_MISSIONS_W + KPX_SPACING_W)

#define KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_X  (KPLIB_MISSIONSMGR_LNB_MISSIONS_X + KPLIB_MISSIONSMGR_LNB_MISSIONS_W + KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_Y  KPLIB_MISSIONSMGR_LNB_MISSIONS_Y
#define KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_W  (KPLIB_MISSIONSMGR_CTRLAREA_W - KPLIB_MISSIONSMGR_LNB_MISSIONS_W - KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_H  KPX_GETH_VHGS(KPLIB_MISSIONSMGR_CTRLAREA_H,1,19,KPX_SPACING_H)

// Four rows, three status rows plus one 'header' row
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X  KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_X
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y  (KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_Y + KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_W  KPX_GETW_VWGS(KPLIB_MISSIONSMGR_CTRLAREA_W,7,32,KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H  KPX_GETH_VHGS(KPLIB_MISSIONSMGR_CTRLAREA_H,6,19,KPX_SPACING_H)

#define KPLIB_MISSIONSMGR_BRIEFING_IMG_X        (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X + KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_W + KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_IMG_Y        KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y
#define KPLIB_MISSIONSMGR_BRIEFING_IMG_W        (KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_W - KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_W - KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_IMG_H        KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H

#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_X   KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_Y   (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y + KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_W   KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_W
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_H   KPLIB_MISSIONSMGR_CTRLAREA_H - (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_H + (2 * KPX_SPACING_H))

#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_X    KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_Y    (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y + KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_W    KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_W
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_H    (KPLIB_MISSIONSMGR_CTRLAREA_H - (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_H + (2 * KPX_SPACING_H)))

#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_HEADER_H             KPLIB_MISSIONSMGR_BTN_H
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H                ((KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_H / 3) - KPLIB_MISSIONSMGR_BTN_H)

#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_X             0
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_W             KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_W

#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_TITLE_X          KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_X
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_TITLE_W          KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_W

#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_DESCRIPTION_X    KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_X
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_DESCRIPTION_W    KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_W

class KPLIB_missionsMgr_btnButtonBase : XGUI_PRE_Button {
    h = KPLIB_MISSIONSMGR_BTN_H;
    y = KPLIB_MISSIONSMGR_BTN_MISSIONS_Y;
    w = KPLIB_MISSIONSMGR_BTN_MISSIONS_W;
};

class XGUI_PRE_ControlTable {
    idc = KPLIB_IDC_UNDEFINED;
    x = 0;
    y = 0;
    w = 0;
    h = 0;

    type = CT_CONTROLS_TABLE;
    style = SL_TEXTURES;

    lineSpacing = 0;
    // TODO: TBD: may run with nominal defaults...
    // rowHeight = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H;
    // headerHeight = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H;

    // firstIDC = KPLIB_IDC_MISSIONSMGR_CT_BRIEFING_IDC_FIRST;
    // lastIDC = KPLIB_IDC_MISSIONSMGR_CT_BRIEFING_IDC_LAST;

    // Colors which are used for animation (i.e. change of colour) of the selected line
    selectedRowColorFrom[]  = {0, 0, 0, 0};
    selectedRowColorTo[]    = {0, 0, 0, 0};
    // Length of the animation cycle in seconds
    selectedRowAnimLength = 1;

    class VScrollBar : XGUI_PRE_ScrollBar {
        // width = 0.021;
        // autoScrollEnabled = 0;
        // autoScrollDelay = 1;
        // autoScrollRewind = 1;
        // autoScrollSpeed = 1;
    };

    class HScrollBar : XGUI_PRE_ScrollBar {
        // height = 0.028;
    };
};

class KPLIB_missionsMgr_ctBriefing_RowLabel : XGUI_PRE_Label {
    colorBackground[] = {0, 0, 0, 0};
    colorText[] = {1, 1, 1, 1};
    colorShadow[] = {0, 0, 0, 0};
    shadow = 0;
    sizeEx = KPX_TEXT_S;
    lineSpacing = 1;
    style = ST_LEFT + ST_MULTI;
};


//#define KPLIB_MISSIONSMGR_BTN_LINES_Y0          KPLIB_MISSIONSMGR_BTN_LINES_GETY(0)
//#define KPLIB_MISSIONSMGR_BTN_LINES_Y1          KPLIB_MISSIONSMGR_BTN_LINES_GETY(1)

//#define KPLIB_MISSIONSMGR_LNB_CONVOY_X          KPLIB_MISSIONSMGR_LNB_TELEMETRY_X
//#define KPLIB_MISSIONSMGR_LNB_CONVOY_Y          (KPLIB_MISSIONSMGR_LNB_TELEMETRY_Y + KPLIB_MISSIONSMGR_LNB_TELEMETRY_H + KPX_SPACING_H)
//#define KPLIB_MISSIONSMGR_LNB_CONVOY_W          KPLIB_MISSIONSMGR_LNB_TELEMETRY_W
//#define KPLIB_MISSIONSMGR_LNB_CONVOY_H          KPX_GETH_VHGS(KPLIB_MISSIONSMGR_CTRLAREA_H,6,19,KPX_SPACING_H)

//#define KPLIB_MISSIONSMGR_BTN_TRANSPORT_Y       (KPLIB_MISSIONSMGR_LNB_CONVOY_Y + KPLIB_MISSIONSMGR_LNB_CONVOY_H + KPX_SPACING_H)
//#define KPLIB_MISSIONSMGR_BTN_TRANSPORT_W       KPX_GETW_VWGS(KPLIB_MISSIONSMGR_CTRLAREA_W,3,40,KPX_SPACING_W)
// // X0 and X1 are "right justified" by the width of the CONVOY LISTNBOX W ... i.e. IOW, X0 is the right most geometry
//#define KPLIB_MISSIONSMGR_BTN_TRANSPORT_X0      (KPLIB_MISSIONSMGR_LNB_CONVOY_X + KPLIB_MISSIONSMGR_LNB_CONVOY_W - KPLIB_MISSIONSMGR_BTN_TRANSPORT_W)
//#define KPLIB_MISSIONSMGR_BTN_TRANSPORT_X1      (KPLIB_MISSIONSMGR_BTN_TRANSPORT_X0 - KPLIB_MISSIONSMGR_BTN_TRANSPORT_W - KPX_SPACING_W)

//#define KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_W      KPX_GETW_VWGS(KPLIB_MISSIONSMGR_DIALOG_WC,2,25,KPX_SPACING_W)

// /* We will arrange some base classes informing the endpoint control groups. These are arranged
//  * in a CT_CONTROL_GROUP for purposes of easier layout. All coordinates are relative to their
//  * parent group control, which should allow for easier arrangement of the parent group within
//  * the dialog itself.
//  *
//  * Verbiage:
//  *      EP - ENDPOINT
//  *      GRP - GROUP
//  */

// Which EP GRP W is a function of the parent coordinate grid...
//#define KPLIB_MISSIONSMGR_EP_GRP_W              ((KPLIB_MISSIONSMGR_LNB_TELEMETRY_W - KPX_SPACING_W) / 2)

//#define KPLIB_MISSIONSMGR_EP_GRP_ALPHA_X        KPLIB_MISSIONSMGR_LNB_TELEMETRY_X
//#define KPLIB_MISSIONSMGR_EP_GRP_BRAVO_X        (KPLIB_MISSIONSMGR_EP_GRP_ALPHA_X + KPLIB_MISSIONSMGR_EP_GRP_W + KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_EP_GRP_Y              (KPLIB_MISSIONSMGR_LNB_CONVOY_Y + KPLIB_MISSIONSMGR_LNB_CONVOY_H + KPLIB_MISSIONSMGR_BTN_H + (2 * KPX_SPACING_H))

// We know the endpoint group height by process of elimination...
//#define KPLIB_MISSIONSMGR_EP_GRP_H             (KPLIB_MISSIONSMGR_CTRLAREA_H - ((4 * KPX_SPACING_H) + KPLIB_MISSIONSMGR_LNB_TELEMETRY_H + KPLIB_MISSIONSMGR_LNB_CONVOY_H + (2 * KPLIB_MISSIONSMGR_BTN_H)))
//#define KPLIB_MISSIONSMGR_EP_GRP_H             ((5 * KPLIB_MISSIONSMGR_BTN_H) + (4 * KPX_SPACING_H))

// Which W we use to inform the grid for the child controls...

//#define KPLIB_MISSIONSMGR_EP_TITLE_X            0
//#define KPLIB_MISSIONSMGR_EP_TITLE_Y            0
//#define KPLIB_MISSIONSMGR_EP_TITLE_W            KPLIB_MISSIONSMGR_EP_GRP_W
//#define KPLIB_MISSIONSMGR_EP_TITLE_H            KPLIB_MISSIONSMGR_BTN_H

//#define KPLIB_MISSIONSMGR_EP_CBO_X              KPLIB_MISSIONSMGR_EP_TITLE_X
//#define KPLIB_MISSIONSMGR_EP_CBO_Y              (KPLIB_MISSIONSMGR_EP_TITLE_Y + KPX_SPACING_H + KPLIB_MISSIONSMGR_EP_TITLE_H)
//#define KPLIB_MISSIONSMGR_EP_CBO_W              KPLIB_MISSIONSMGR_EP_TITLE_W
//#define KPLIB_MISSIONSMGR_EP_CBO_H              KPLIB_MISSIONSMGR_BTN_H

//#define KPLIB_MISSIONSMGR_EP_LBL_X              (KPLIB_MISSIONSMGR_EP_IMG_X + KPLIB_MISSIONSMGR_EP_IMG_W + KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_EP_LBL_W              KPX_GETW_VWGS(KPLIB_MISSIONSMGR_EP_GRP_W,2,6,KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_EP_LBL_H              KPLIB_MISSIONSMGR_BTN_H

//#define KPLIB_MISSIONSMGR_EP_EDT_X              (KPLIB_MISSIONSMGR_EP_LBL_X + KPLIB_MISSIONSMGR_EP_LBL_W + KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_EP_EDT_W              KPX_GETW_VWGS(KPLIB_MISSIONSMGR_EP_GRP_W,3,6,KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_EP_EDT_H              KPLIB_MISSIONSMGR_BTN_H

//#define KPLIB_MISSIONSMGR_EP_RSC_GET_Y(RSC)     (KPLIB_MISSIONSMGR_EP_CBO_Y + KPLIB_MISSIONSMGR_EP_CBO_H + ((RSC + 1) * KPX_SPACING_H) + (RSC * KPLIB_MISSIONSMGR_BTN_H))

// // TODO: TBD: we might have a BRIEFING GROUP...
// class KPLIB_missionsMgr_grpBriefing : XGUI_PRE_ControlsGroup {
//     y = KPLIB_MISSIONSMGR_EP_GRP_Y;
//     w = KPLIB_MISSIONSMGR_EP_GRP_W;
//     h = KPLIB_MISSIONSMGR_EP_GRP_H;
//     onLoad = "_this spawn KPLIB_fnc_logisticsMgr_endpointCtrls_onLoad";
// };

//// Arrange layout for 3x buttons CONFIRM | REROUTE | ABORT, evenly spaced
//#define KPLIB_MISSIONSMGR_BTN_CONFIRM_X         KPLIB_MISSIONSMGR_LNB_TELEMETRY_X
//#define KPLIB_MISSIONSMGR_BTN_CONFIRM_Y         (KPLIB_MISSIONSMGR_CTRLAREA_Y + KPLIB_MISSIONSMGR_CTRLAREA_H - KPLIB_MISSIONSMGR_BTN_H)
//#define KPLIB_MISSIONSMGR_BTN_CONFIRM_W         ((1/3) * (KPLIB_MISSIONSMGR_LNB_TELEMETRY_W - (2 * KPX_SPACING_W)))

//#define KPLIB_MISSIONSMGR_BTN_REROUTE_X         (KPLIB_MISSIONSMGR_BTN_CONFIRM_X + KPLIB_MISSIONSMGR_BTN_CONFIRM_W + KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_BTN_REROUTE_Y         KPLIB_MISSIONSMGR_BTN_CONFIRM_Y
//#define KPLIB_MISSIONSMGR_BTN_REROUTE_W         KPLIB_MISSIONSMGR_BTN_CONFIRM_W

//#define KPLIB_MISSIONSMGR_BTN_ABORT_X           (KPLIB_MISSIONSMGR_BTN_REROUTE_X + KPLIB_MISSIONSMGR_BTN_CONFIRM_W + KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_BTN_ABORT_Y           KPLIB_MISSIONSMGR_BTN_CONFIRM_Y
//#define KPLIB_MISSIONSMGR_BTN_ABORT_W           KPLIB_MISSIONSMGR_BTN_CONFIRM_W

//#define KPLIB_MISSIONSMGR_MAPCTRL_X             (KPLIB_MISSIONSMGR_LNB_TELEMETRY_X + KPLIB_MISSIONSMGR_LNB_TELEMETRY_W + KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_MAPCTRL_Y             KPLIB_MISSIONSMGR_LNB_TELEMETRY_Y
//#define KPLIB_MISSIONSMGR_MAPCTRL_W             KPX_GETW_VWGS(KPLIB_MISSIONSMGR_CTRLAREA_W,17,40,KPX_SPACING_W)
//#define KPLIB_MISSIONSMGR_MAPCTRL_H             KPLIB_MISSIONSMGR_CTRLAREA_H

class KPLIB_missionsMgr {
    idd = KPLIB_IDD_MISSIONSMGR;
    movingEnable = 0;

    onLoad = "_this spawn KPLIB_fnc_missionsMgr_onLoad";
    onUnload = "_this spawn KPLIB_fnc_missionsMgr_onUnload";

    class controlsBackground {

        class KPLIB_missionsMgr_lblTitle : XGUI_PRE_DialogTitleC {
            x = KPLIB_MISSIONSMGR_TITLE_X;
            y = KPLIB_MISSIONSMGR_TITLE_Y;
            w = KPLIB_MISSIONSMGR_TITLE_W;
            h = KPLIB_MISSIONSMGR_TITLE_H;
            text = "$STR_KPLIB_DIALOG_MISSIONSMGR_TITLE";
        };

        class KPLIB_missionsMgr_dialogArea : XGUI_PRE_DialogBackgroundC {
            x = KPLIB_MISSIONSMGR_BG_X;
            y = KPLIB_MISSIONSMGR_BG_Y;
            w = KPLIB_MISSIONSMGR_BG_W;
            h = KPLIB_MISSIONSMGR_BG_H;
        };
    };

    class controls {

        // https://community.bistudio.com/wiki/CT_LISTNBOX
        // https://community.bistudio.com/wiki/CT_LISTNBOX#columns
        class KPLIB_missionsMgr_lnbMissions : XGUI_PRE_ListNBox {
            default = 0;
            idc = KPLIB_IDC_MISSIONSMGR_LNB_MISSIONS;

            x = KPLIB_MISSIONSMGR_LNB_MISSIONS_X;
            y = KPLIB_MISSIONSMGR_LNB_MISSIONS_Y;
            w = KPLIB_MISSIONSMGR_LNB_MISSIONS_W;
            h = KPLIB_MISSIONSMGR_LNB_MISSIONS_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          {_icon, _text, _isTemplateViewDatum, _isRunningViewDatum}
            columns[] = {    0,  0.12,                  0.5,                 0.7};

            onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbMissions_onLoadDummy";
            //onLoad = "_this spawn KPLIB_fnc_logisticsMgr_lnbLines_onLoad";
            //onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_lnbLines_onLBSelChanged";
        };

        class KPLIB_missionsMgr_btnRun : KPLIB_missionsMgr_btnButtonBase {
            idc = KPLIB_IDC_MISSIONSMGR_BTN_RUN;
            x = KPLIB_MISSIONSMGR_MISSIONS_BTN_RUN_X;

            text = "$STR_KPLIB_MISSIONSMGR_BTN_RUN";

            //onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnLineAdd_onButtonClick";
        };

        class KPLIB_missionsMgr_btnAbort : KPLIB_missionsMgr_btnButtonBase {
            idc = KPLIB_IDC_MISSIONSMGR_BTN_ABORT;
            x = KPLIB_MISSIONSMGR_MISSIONS_BTN_ABORT_X;

            text = "$STR_KPLIB_MISSIONSMGR_BTN_ABORT";

            //onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnLineRemove_onButtonClick";
        };

        // TODO: TBD: we might introduce a full-on group here, which would alter the geometry somewhat...
        // TODO: TBD: for now we will arrange them as 'first class' controls
        // TODO: TBD: yes we will have a briefing title...
        class KPLIB_missionsMgr_lblBriefingTitle : XGUI_PRE_Label {
            idc = KPLIB_IDC_MISSIONSMGR_LBL_TITLE;
            x = KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_X;
            y = KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_Y;
            w = KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_W;
            h = KPLIB_MISSIONSMGR_BRIEFING_LBL_TITLE_H;
            text = "$STR_KPLIB_MISSIONSMGR_LBL_BRIEFING_TITLE_NA";
        };

        class KPLIB_missionsMgr_lnbTelemetry : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_MISSIONSMGR_LNB_TELEMETRY;
            x = KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X;
            y = KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y;
            w = KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_W;
            h = KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          {_icon, _telemetry, _value}
            columns[] = {    0,       0.12,   0.55};

            onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbTelemetry_onLoadDummy";
            //onLoad = "_this spawn KPLIB_fnc_logisticsMgr_lnbTelemetry_onLoad";
            //onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_lnbTelemetry_onLBSelChanged";
        };

        // TODO: TBD: likewise will have a briefing image
        class KPLIB_missionsMgr_imgBriefingImage : XGUI_PRE_PictureRatio {
            idc = KPLIB_IDC_MISSIONSMGR_IMG_MISSION;
            x = KPLIB_MISSIONSMGR_BRIEFING_IMG_X;
            y = KPLIB_MISSIONSMGR_BRIEFING_IMG_y;
            w = KPLIB_MISSIONSMGR_BRIEFING_IMG_W;
            h = KPLIB_MISSIONSMGR_BRIEFING_IMG_H;
            //text = "img";
        };

        class KPLIB_missionsMgr_ctBriefing : XGUI_PRE_ControlTable {
            idc = KPLIB_IDC_MISSIONSMGR_CT_BRIEFING;

            x = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_X;
            y = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_Y;
            w = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_W;
            h = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_H;

            onLoad = "_this spawn KPLIB_fnc_missionsMgr_ctBriefing_onLoadDummy";

            rowHeight = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H;
            headerHeight = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_HEADER_H;

            firstIDC = KPLIB_IDC_MISSIONSMGR_CT_BRIEFING_IDC_FIRST;
            lastIDC = KPLIB_IDC_MISSIONSMGR_CT_BRIEFING_IDC_LAST;

            // Template for headers (unlike rows, cannot be selected)
            class HeaderTemplate {
                class HeaderBackground {
                    controlBaseClassPath[] = {"KPLIB_missionsMgr_ctBriefing_RowLabel"};
                    columnX = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_X;
                    columnW = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_HEADER_H;
                };

                class KPLIB_missionsMgr_ctBriefing_rowTemplate_lblTitle {
                    controlBaseClassPath[] = {"KPLIB_missionsMgr_ctBriefing_RowLabel"};
                    columnX = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_TITLE_X;
                    columnW = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_TITLE_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_HEADER_H;
                };
            };

            // Template for selectable rows
            class RowTemplate {
                // TODO: TBD: is row background necessary (?)
                // TODO: TBD: could approach row background as a sort of greenbar approach...
                class RowBackground {
                    controlBaseClassPath[] = {"KPLIB_missionsMgr_ctBriefing_RowLabel"};
                    columnX = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_X;
                    columnW = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_BG_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H;
                };

                class KPLIB_missionsMgr_ctBriefing_rowTemplate_lblDescription {
                    controlBaseClassPath[] = {"KPLIB_missionsMgr_ctBriefing_RowLabel"};
                    columnX = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_DESCRIPTION_X;
                    columnW = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_LBL_DESCRIPTION_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_ROW_H;
                };
            };
        };

        // // TODO: TBD: kinda sorta but we need better control of the elements...
        // class KPLIB_missionsMgr_lnbBriefing : XGUI_PRE_ListNBox {
        //     idc = KPLIB_IDC_MISSIONSMGR_LNB_BRIEFING;
        //     x = KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_X;
        //     y = KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_Y;
        //     w = KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_W;
        //     h = KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_H;

        //     sizeEx = KPX_TEXT_S;
        //     rowHeight = KPX_TITLE_S_H;

        //     //          {_briefing, _description}
        //     columns[] = { 0.01,             0.11};

        //     onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbBriefing_onLoadDummy";
        //     //onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbBriefing_onLoad";
        //     //onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_lnbBriefing_onLBSelChanged";
        // };

        // // TODO: TBD: at the moment, no map, but that might be interesting as well
        // class KPLIB_logisticsMgr_map : XGUI_PRE_MapControl {
        //     idc = KPLIB_IDC_LOGISTICSMGR_CTRL_MAP;
        //     x = KPLIB_MISSIONSMGR_MAPCTRL_X;
        //     y = KPLIB_MISSIONSMGR_MAPCTRL_Y;
        //     w = KPLIB_MISSIONSMGR_MAPCTRL_W;
        //     h = KPLIB_MISSIONSMGR_MAPCTRL_H;
        //     // Does not actually support an 'onUnload' per se, but we have an event handler defined for use throughout anyway
        //     onLoad = "_this spawn KPLIB_fnc_logisticsMgr_ctrlMap_onLoad";
        // };

        class KPLIB_missionsMgr_ctrlCross : XGUI_PRE_DialogCrossC {
            x = KPLIB_MISSIONSMGR_CROSS_X;
            y = KPLIB_MISSIONSMGR_CROSS_Y;
        };
    };
};
