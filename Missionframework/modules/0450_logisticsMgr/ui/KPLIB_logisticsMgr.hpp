/*
    KP Liberation logisticsMgr dialog

    File: KPLIB_logisticsMgr.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-26 18:57:14
    Last Update: 2021-02-26 18:57:17
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Layout for the module dialog.
*/

#define KPLIB_LOGISTICSMGR_DIALOG_WC            KPX_DEFAULT_DIALOG_WC2
#define KPLIB_LOGISTICSMGR_DIALOG_HC            KPX_DEFAULT_DIALOG_HC2

#define KPLIB_LOGISTICSMGR_DIALOG_XC            KPX_GETXC_W2(KPLIB_LOGISTICSMGR_DIALOG_WC)
#define KPLIB_LOGISTICSMGR_DIALOG_YC            KPX_GETYC_H2(KPLIB_LOGISTICSMGR_DIALOG_HC)

#define KPLIB_LOGISTICSMGR_TITLE_X              KPLIB_LOGISTICSMGR_DIALOG_XC
#define KPLIB_LOGISTICSMGR_TITLE_Y              KPLIB_LOGISTICSMGR_DIALOG_YC
#define KPLIB_LOGISTICSMGR_TITLE_W              KPLIB_LOGISTICSMGR_DIALOG_WC
#define KPLIB_LOGISTICSMGR_TITLE_H              KPX_TITLE_M_H

#define KPLIB_LOGISTICSMGR_BG_X                 KPLIB_LOGISTICSMGR_TITLE_X
#define KPLIB_LOGISTICSMGR_BG_Y                 (KPLIB_LOGISTICSMGR_TITLE_Y + KPLIB_LOGISTICSMGR_TITLE_H + KPX_SPACING_H)
#define KPLIB_LOGISTICSMGR_BG_W                 KPLIB_LOGISTICSMGR_TITLE_W
#define KPLIB_LOGISTICSMGR_BG_H                 (KPLIB_LOGISTICSMGR_DIALOG_HC - KPLIB_LOGISTICSMGR_TITLE_H - KPX_SPACING_H)

#define KPLIB_LOGISTICSMGR_CTRLAREA_X           (KPLIB_LOGISTICSMGR_BG_X + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_CTRLAREA_Y           (KPLIB_LOGISTICSMGR_BG_Y + KPX_SPACING_H)
#define KPLIB_LOGISTICSMGR_CTRLAREA_W           (KPLIB_LOGISTICSMGR_BG_W - (2 * KPX_SPACING_W))
#define KPLIB_LOGISTICSMGR_CTRLAREA_H           (KPLIB_LOGISTICSMGR_BG_H - (2 * KPX_SPACING_H))

#define KPLIB_LOGISTICSMGR_CROSS_X              (KPLIB_LOGISTICSMGR_TITLE_X + KPLIB_LOGISTICSMGR_TITLE_W - GUI_GRID_W)
#define KPLIB_LOGISTICSMGR_CROSS_Y              (KPLIB_LOGISTICSMGR_TITLE_Y + KPX_SPACING_H)

#define KPLIB_LOGISTICSMGR_BTN_H                KPX_GETH_VHGS(KPLIB_LOGISTICSMGR_CTRLAREA_H,1,19,KPX_SPACING_H)

// Sectors list box height including buffer for two buttons below it
#define KPLIB_LOGISTICSMGR_LNB_LINES_X          KPLIB_LOGISTICSMGR_CTRLAREA_X
#define KPLIB_LOGISTICSMGR_LNB_LINES_Y          KPLIB_LOGISTICSMGR_CTRLAREA_Y
#define KPLIB_LOGISTICSMGR_LNB_LINES_W          KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_CTRLAREA_W,8,40,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_LNB_LINES_H          KPX_GETH_VHGS(KPLIB_LOGISTICSMGR_CTRLAREA_H,17,19,KPX_SPACING_H)

#define KPLIB_LOGISTICSMGR_BTN_LINES_GETY(BY)   (KPLIB_LOGISTICSMGR_LNB_LINES_Y + KPLIB_LOGISTICSMGR_LNB_LINES_H + ((BY + 1) * KPX_SPACING_H) + (BY * KPLIB_LOGISTICSMGR_BTN_H))

#define KPLIB_LOGISTICSMGR_BTN_W                KPLIB_LOGISTICSMGR_LNB_LINES_W
#define KPLIB_LOGISTICSMGR_BTN_LINES_W2         (0.5 * (KPLIB_LOGISTICSMGR_BTN_W - KPX_SPACING_W))

#define KPLIB_LOGISTICSMGR_BTN_LINE_ADD_X       KPLIB_LOGISTICSMGR_CTRLAREA_X
#define KPLIB_LOGISTICSMGR_BTN_LINE_REMOVE_X    (KPLIB_LOGISTICSMGR_BTN_LINE_ADD_X + KPLIB_LOGISTICSMGR_BTN_LINES_W2 + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_BTN_REFRESH_X        KPLIB_LOGISTICSMGR_BTN_LINE_ADD_X

#define KPLIB_LOGISTICSMGR_BTN_LINES_Y0         KPLIB_LOGISTICSMGR_BTN_LINES_GETY(0)
#define KPLIB_LOGISTICSMGR_BTN_LINES_Y1         KPLIB_LOGISTICSMGR_BTN_LINES_GETY(1)

// Four rows, three status rows plus one 'header' row
#define KPLIB_LOGISTICSMGR_LNB_TELEMETRY_X      (KPLIB_LOGISTICSMGR_LNB_LINES_X + KPLIB_LOGISTICSMGR_LNB_LINES_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_LNB_TELEMETRY_Y      KPLIB_LOGISTICSMGR_LNB_LINES_Y
#define KPLIB_LOGISTICSMGR_LNB_TELEMETRY_W      KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_CTRLAREA_W,15,40,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_LNB_TELEMETRY_H      KPX_GETH_VHGS(KPLIB_LOGISTICSMGR_CTRLAREA_H,5,19,KPX_SPACING_H)

#define KPLIB_LOGISTICSMGR_LNB_CONVOY_X         KPLIB_LOGISTICSMGR_LNB_TELEMETRY_X
#define KPLIB_LOGISTICSMGR_LNB_CONVOY_Y         (KPLIB_LOGISTICSMGR_LNB_TELEMETRY_Y + KPLIB_LOGISTICSMGR_LNB_TELEMETRY_H + KPX_SPACING_H)
#define KPLIB_LOGISTICSMGR_LNB_CONVOY_W         KPLIB_LOGISTICSMGR_LNB_TELEMETRY_W
#define KPLIB_LOGISTICSMGR_LNB_CONVOY_H         KPX_GETH_VHGS(KPLIB_LOGISTICSMGR_CTRLAREA_H,6,19,KPX_SPACING_H)

#define KPLIB_LOGISTICSMGR_BTN_TRANSPORT_Y      (KPLIB_LOGISTICSMGR_LNB_CONVOY_Y + KPLIB_LOGISTICSMGR_LNB_CONVOY_H + KPX_SPACING_H)
#define KPLIB_LOGISTICSMGR_BTN_TRANSPORT_W      KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_CTRLAREA_W,3,40,KPX_SPACING_W)
// X0 and X1 are "right justified" by the width of the CONVOY LISTNBOX W ... i.e. IOW, X0 is the right most geometry
#define KPLIB_LOGISTICSMGR_BTN_TRANSPORT_X0     (KPLIB_LOGISTICSMGR_LNB_CONVOY_X + KPLIB_LOGISTICSMGR_LNB_CONVOY_W - KPLIB_LOGISTICSMGR_BTN_TRANSPORT_W)
#define KPLIB_LOGISTICSMGR_BTN_TRANSPORT_X1     (KPLIB_LOGISTICSMGR_BTN_TRANSPORT_X0 - KPLIB_LOGISTICSMGR_BTN_TRANSPORT_W - KPX_SPACING_W)

#define KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_W      KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_DIALOG_WC,2,25,KPX_SPACING_W)

/*
    Description:
        The queue list box will have several buttons accompanying it for purposes of
        arranging the queue and interacting with it. The buttons will be arranged in
        a grid like manner.

        11111 22222 33333
        44444 55555 66666
 */

// Align the queue buttons with respect to the queue list box from the bottom up
#define KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XL     KPX_GETXL_VXW(KPLIB_LOGISTICSMGR_LNB_CONVOY_X,(KPLIB_LOGISTICSMGR_LNB_CONVOY_W + KPX_SPACING_W))
#define KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XM     KPX_GETXL_VXW(KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XL,(KPX_SPACING_W + KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_W))
#define KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XR     KPX_GETXL_VXW(KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XM,(KPX_SPACING_W + KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_W))

#define KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_GETDELTAH(BY) (KPLIB_LOGISTICSMGR_LNB_CONVOY_H - ((BY + 1) * KPLIB_LOGISTICSMGR_BTN_H) - (BY * KPX_SPACING_H))

// Aligned with the buttons...
#define KPLIB_LOGISTICSMGR_LBLTIMEREM_X         KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XL
#define KPLIB_LOGISTICSMGR_LBLTIMEREM_W         ((KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XR + KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_W) - KPLIB_LOGISTICSMGR_LNBCONVOY_BTN_XL)

// Aligning time remaining elements with the queue list box from the top down
#define KPLIB_LOGISTICSMGR_LBLTIMEREM_GETDELTAH(BY) ((BY * KPLIB_LOGISTICSMGR_BTN_H) + (BY * KPX_SPACING_H))






/* We will arrange some base classes informing the endpoint control groups. These are arranged
 * in a CT_CONTROL_GROUP for purposes of easier layout. All coordinates are relative to their
 * parent group control, which should allow for easier arrangement of the parent group within
 * the dialog itself.
 *
 * Verbiage:
 *      EP - ENDPOINT
 *      GRP - GROUP
 */

// Which EP GRP W is a function of the parent coordinate grid...
#define KPLIB_LOGISTICSMGR_EP_GRP_W KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_CTRLAREA_W,6,40,KPX_SPACING_W)
// Which W we use to inform the grid for the child controls...

#define KPLIB_LOGISTICSMGR_EP_TITLE_X 0
#define KPLIB_LOGISTICSMGR_EP_TITLE_Y 0
#define KPLIB_LOGISTICSMGR_EP_TITLE_W KPLIB_LOGISTICSMGR_EP_GRP_W
#define KPLIB_LOGISTICSMGR_EP_TITLE_H KPX_TITLE_M_H

#define KPLIB_LOGISTICSMGR_EP_CBO_X KPLIB_LOGISTICSMGR_EP_TITLE_X
#define KPLIB_LOGISTICSMGR_EP_CBO_Y (KPLIB_LOGISTICSMGR_EP_TITLE_Y + KPX_SPACING_H + KPLIB_LOGISTICSMGR_EP_TITLE_H)
#define KPLIB_LOGISTICSMGR_EP_CBO_W KPLIB_LOGISTICSMGR_EP_TITLE_W
#define KPLIB_LOGISTICSMGR_EP_CBO_H KPX_BUTTON_M_H

#define KPLIB_LOGISTICSMGR_EP_IMG_X KPLIB_LOGISTICSMGR_EP_TITLE_X
#define KPLIB_LOGISTICSMGR_EP_IMG_Y (KPLIB_LOGISTICSMGR_EP_CBO_Y + KPX_SPACING_H + KPLIB_LOGISTICSMGR_EP_CBO_H)
#define KPLIB_LOGISTICSMGR_EP_IMG_W KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_EP_GRP_W,1,6,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_IMG_H KPX_BUTTON_M_H

#define KPLIB_LOGISTICSMGR_EP_LBL_X (KPLIB_LOGISTICSMGR_EP_IMG_X + KPLIB_LOGISTICSMGR_EP_IMG_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_LBL_Y KPLIB_LOGISTICSMGR_EP_IMG_Y
#define KPLIB_LOGISTICSMGR_EP_LBL_W KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_EP_GRP_W,2,6,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_LBL_H KPX_BUTTON_M_H

#define KPLIB_LOGISTICSMGR_EP_TXT_X (KPLIB_LOGISTICSMGR_EP_LBL_X + KPLIB_LOGISTICSMGR_EP_LBL_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_TXT_Y KPLIB_LOGISTICSMGR_EP_IMG_Y
#define KPLIB_LOGISTICSMGR_EP_TXT_W KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_EP_GRP_W,3,6,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_TXT_H KPX_BUTTON_M_H

// TODO: TBD: may need to include additional spacing, but we'll see...
// TODO: TBD: may want to simply leverage the KPX_GETW_VWGS(...) macro after all...
#define KPLIB_LOGISTICSMGR_EP_GRP_H ((4 * KPX_SPACING_H) + KPLIB_LOGISTICSMGR_EP_TITLE_H + KPLIB_LOGISTICSMGR_EP_CBO_H + (3 * KPLIB_LOGISTICSMGR_EP_TXT_H))

#define KPLIB_LOGISTICSMGR_EP_GRP_ALPHA_X (KPLIB_LOGISTICSMGR_LNB_LINES_X + KPLIB_LOGISTICSMGR_LNB_LINES_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_GRP_BRAVO_X (KPLIB_LOGISTICSMGR_EP_GRP_ALPHA_X + KPLIB_LOGISTICSMGR_EP_GRP_W + KPX_SPACING_W)

class KPLIB_logisticsMgr_Button : XGUI_PRE_Button {
    h = KPLIB_LOGISTICSMGR_BTN_H;
};

// TODO: TBD: is there a better place for these sort of base classes (?)
class KPLIB_logisticsMgr_controlsEndpoint : XGUI_PRE_ControlsGroup {
    x = 
    w = KPLIB_LOGISTICSMGR_EP_GRP_W;
    h = KPLIB_LOGISTICSMGR_EP_GRP_H;
};

class KPLIB_logisticsMgr_lblEndpoint : XGUI_PRE_Label {
    x = KPLIB_LOGISTICSMGR_EP_TITLE_X;
    y = KPLIB_LOGISTICSMGR_EP_TITLE_Y;
    w = KPLIB_LOGISTICSMGR_EP_TITLE_W;
    h = KPLIB_LOGISTICSMGR_EP_TITLE_H;
    // w = ? ; // TODO: TBD: pending the other controls...
};

class KPLIB_logisticsMgr_cboEndpoint : XGUI_PRE_Combo {
    x = KPLIB_LOGISTICSMGR_EP_CBO_X;
    y = KPLIB_LOGISTICSMGR_EP_CBO_Y;
    w = KPLIB_LOGISTICSMGR_EP_CBO_W;
    h = KPLIB_LOGISTICSMGR_EP_CBO_H;
    // w = ? ; // TODO: TBD: pending the other controls...

    // TODO: TBD: two columns, at least, for grid ref, marker text, maybe also cap
    //          {_gridref, _markerText}
    columns[] = {       0,        0.25};

    onLoad = "_this spawn KPLIB_fnc_logisticsMgr_cboEndpoint_onLoad";
    onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_cboEndpoint_onLBSelChanged";
};

class KPLIB_logisticsMgr_imgEndpointResource : XGUI_PRE_PictureRatio {
    x = KPLIB_LOGISTICSMGR_EP_IMG_X;
    y = KPLIB_LOGISTICSMGR_EP_IMG_Y;
    w = KPLIB_LOGISTICSMGR_EP_IMG_W;
    h = KPLIB_LOGISTICSMGR_EP_IMG_H;
};

class KPLIB_logisticsMgr_lblEndpointResource : XGUI_PRE_Label {
    x = KPLIB_LOGISTICSMGR_EP_LBL_X;
    y = KPLIB_LOGISTICSMGR_EP_LBL_Y;
    w = KPLIB_LOGISTICSMGR_EP_LBL_W;
    h = KPLIB_LOGISTICSMGR_EP_LBL_H;
    text = "";
};

class KPLIB_logisticsMgr_txtEndpointResource : XGUI_PRE_ActiveText {
    x = KPLIB_LOGISTICSMGR_EP_TXT_X;
    y = KPLIB_LOGISTICSMGR_EP_TXT_Y;
    w = KPLIB_LOGISTICSMGR_EP_TXT_W;
    h = KPLIB_LOGISTICSMGR_EP_TXT_H;
    text = "0";
};

#define KPLIB_LOGISTICSMGR_BTN_CONFIRM_X        KPLIB_LOGISTICSMGR_LNB_TELEMETRY_X
#define KPLIB_LOGISTICSMGR_BTN_CONFIRM_Y        (KPLIB_LOGISTICSMGR_CTRLAREA_Y + KPLIB_LOGISTICSMGR_CTRLAREA_H - KPLIB_LOGISTICSMGR_BTN_H)
#define KPLIB_LOGISTICSMGR_BTN_CONFIRM_W        (0.5 * (KPLIB_LOGISTICSMGR_LNB_TELEMETRY_W - KPX_SPACING_W))

#define KPLIB_LOGISTICSMGR_BTN_ABORT_X          (KPLIB_LOGISTICSMGR_BTN_CONFIRM_X + KPLIB_LOGISTICSMGR_BTN_CONFIRM_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_BTN_ABORT_Y          KPLIB_LOGISTICSMGR_BTN_CONFIRM_Y
#define KPLIB_LOGISTICSMGR_BTN_ABORT_W          KPLIB_LOGISTICSMGR_BTN_CONFIRM_W

#define KPLIB_LOGISTICSMGR_MAPCTRL_X            (KPLIB_LOGISTICSMGR_LNB_TELEMETRY_X + KPLIB_LOGISTICSMGR_LNB_TELEMETRY_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_MAPCTRL_Y            KPLIB_LOGISTICSMGR_LNB_TELEMETRY_Y
#define KPLIB_LOGISTICSMGR_MAPCTRL_W            KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_CTRLAREA_W,17,40,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_MAPCTRL_H            KPLIB_LOGISTICSMGR_CTRLAREA_H

class KPLIB_logisticsMgr {
    idd = KPLIB_IDD_LOGISTICSMGR;
    movingEnable = 0;

    onLoad = "_this spawn KPLIB_fnc_logisticsMgr_onLoad";
    onUnload = "_this spawn KPLIB_fnc_logisticsMgr_onUnload";

    class controlsBackground {

        //// TODO: TBD: starting slowing to prove this thing out...
        //class KPLIB_DialogTitle : KPGUI_PRE_DialogTitleS {
        class KPLIB_logisticsMgr_lblTitle : XGUI_PRE_DialogTitleC {
            x = KPLIB_LOGISTICSMGR_TITLE_X;
            y = KPLIB_LOGISTICSMGR_TITLE_Y;
            w = KPLIB_LOGISTICSMGR_TITLE_W;
            h = KPLIB_LOGISTICSMGR_TITLE_H;
            text = "$STR_KPLIB_DIALOG_LOGISTICSMGR_TITLE";
        };

        //class KPLIB_DialogArea : KPGUI_PRE_DialogBackgroundS {
        class KPLIB_logisticsMgr_dialogArea : XGUI_PRE_DialogBackgroundC {
            x = KPLIB_LOGISTICSMGR_BG_X;
            y = KPLIB_LOGISTICSMGR_BG_Y;
            w = KPLIB_LOGISTICSMGR_BG_W;
            h = KPLIB_LOGISTICSMGR_BG_H;
        };
    };

    class controls {

        // https://community.bistudio.com/wiki/CT_LISTNBOX
        // https://community.bistudio.com/wiki/CT_LISTNBOX#columns
        class KPLIB_logisticsMgr_lnbLines : XGUI_PRE_ListNBox {
            default = 0;
            idc = KPLIB_IDC_LOGISTICSMGR_LNB_LINES;

            x = KPLIB_LOGISTICSMGR_LNB_LINES_X;
            y = KPLIB_LOGISTICSMGR_LNB_LINES_Y;
            w = KPLIB_LOGISTICSMGR_LNB_LINES_W;
            h = KPLIB_LOGISTICSMGR_LNB_LINES_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          {_grid, _markerText}
            columns[] = {-0.01,         0.2};

            onLoad = "_this spawn KPLIB_fnc_logisticsMgr_lnbLines_onLoad";
            onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_lnbLines_onLBSelChanged";
        };

        class KPLIB_logisticsMgr_btnLineAdd : KPLIB_logisticsMgr_Button {
            idc = KPLIB_IDC_LOGISTICSMGR_BTN_LINE_ADD;
            x = KPLIB_LOGISTICSMGR_BTN_LINE_ADD_X;
            y = KPLIB_LOGISTICSMGR_BTN_LINES_Y0;
            w = KPLIB_LOGISTICSMGR_BTN_LINES_W2;

            text = "$STR_KPLIB_LOGISTICSMGR_BTN_ADD";

            onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnLineAdd_onButtonClick";
        };

        class KPLIB_logisticsMgr_btnLineRemove : KPLIB_logisticsMgr_Button {
            idc = KPLIB_IDC_LOGISTICSMGR_BTN_LINE_REMOVE;
            x = KPLIB_LOGISTICSMGR_BTN_LINE_REMOVE_X;
            y = KPLIB_LOGISTICSMGR_BTN_LINES_Y0;
            w = KPLIB_LOGISTICSMGR_BTN_LINES_W2;

            text = "$STR_KPLIB_LOGISTICSMGR_BTN_REMOVE";

            onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnLineRemove_onButtonClick";
        };

        class KPLIB_logisticsMgr_btnRefresh : KPLIB_logisticsMgr_Button {
            idc = KPLIB_IDC_LOGISTICSMGR_BTN_REFRESH;
            x = KPLIB_LOGISTICSMGR_BTN_REFRESH_X;
            y = KPLIB_LOGISTICSMGR_BTN_LINES_Y1;
            w = KPLIB_LOGISTICSMGR_BTN_W;

            text = "$STR_KPLIB_LOGISTICSMGR_BTN_REFRESH";

            onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnRefresh_onButtonClick";
        };

        class KPLIB_logisticsMgr_lnbTelemetry : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_LOGISTICSMGR_LNB_TELEMETRY;
            x = KPLIB_LOGISTICSMGR_LNB_TELEMETRY_X;
            y = KPLIB_LOGISTICSMGR_LNB_TELEMETRY_Y;
            w = KPLIB_LOGISTICSMGR_LNB_TELEMETRY_W;
            h = KPLIB_LOGISTICSMGR_LNB_TELEMETRY_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            // // TODO: TBD: ...
            ////          { _img, _label, _cap, _prod, _totals, _crates}
            //columns[] = {-0.01,  0.075,  0.2,  0.35,     0.5,     0.6};

            onLoad = "_this spawn KPLIB_fnc_logisticsMgr_lnbTelemetry_onLoad";
            onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_lnbTelemetry_onLBSelChanged";
        };

        class KPLIB_logisticsMgr_lnbConvoy : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_LOGISTICSMGR_LNB_CONVOY;
            x = KPLIB_LOGISTICSMGR_LNB_CONVOY_X;
            y = KPLIB_LOGISTICSMGR_LNB_CONVOY_Y;
            w = KPLIB_LOGISTICSMGR_LNB_CONVOY_W;
            h = KPLIB_LOGISTICSMGR_LNB_CONVOY_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          { _img, _label}
            columns[] = {-0.01,    0.3};

            onLoad = "_this spawn KPLIB_fnc_logisticsMgr_lnbConvoy_onLoad";
            onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_lnbConvoy_onLBSelChanged";
        };

        class KPLIB_logisticsMgr_btnTransportAdd : KPLIB_logisticsMgr_Button {
            idc = KPLIB_IDC_LOGISTICSMGR_BTN_TRANSPORT_ADD;
            x = KPLIB_LOGISTICSMGR_BTN_TRANSPORT_X1;
            y = KPLIB_LOGISTICSMGR_BTN_TRANSPORT_Y;
            w = KPLIB_LOGISTICSMGR_BTN_TRANSPORT_W;

            text = "$STR_KPLIB_LOGISTICSMGR_BTN_ADD";

            onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnTransportAdd_onButtonClick";
        };

        class KPLIB_logisticsMgr_btnTransportRecycle : KPLIB_logisticsMgr_Button {
            idc = KPLIB_IDC_LOGISTICSMGR_BTN_TRANSPORT_RECYCLE;
            x = KPLIB_LOGISTICSMGR_BTN_TRANSPORT_X0;
            y = KPLIB_LOGISTICSMGR_BTN_TRANSPORT_Y;
            w = KPLIB_LOGISTICSMGR_BTN_TRANSPORT_W;

            text = "$STR_KPLIB_LOGISTICSMGR_BTN_RECYCLE";

            onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnTransportRecycle_onButtonClick";
        };

        class KPLIB_logisticsMgr_controlsAlpha : KPLIB_logisticsMgr_controlsEndpoint {
            x = KPLIB_LOGISTICSMGR_EP_GRP_ALPHA_X;
            y = KPLIB_LOGISTICSMGR_EP_GRP_ALPHA_Y;

            class controls {

                // TODO: TBD: need a picture class if there is not one already...
                class KPLIB_logisticsMgr_lblAlpha : KPLIB_logisticsMgr_lblEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL;
                    text = "$STR_KPLIB_LOGISTICSMGR_LBL_ALPHA";
                };

                // https://community.bistudio.com/wiki/CT_LISTBOX
                class KPLIB_logisticsMgr_cboAlpha : KPLIB_logisticsMgr_cboEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_CBO;
                };

                class KPLIB_logisticsMgr_imgAlphaSupply : KPLIB_logisticsMgr_imgEndpointResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_IMG_SUPPLY;
                    text = "$STR_KPLIB_LOGISTICSMGR_IMG_SUP";
                };

                class KPLIB_logisticsMgr_imgAlphaAmmo : KPLIB_logisticsMgr_imgAlphaSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_IMG_AMMO;
                    text = "$STR_KPLIB_LOGISTICSMGR_IMG_AMM";
                };

                class KPLIB_logisticsMgr_imgAlphaFuel : KPLIB_logisticsMgr_imgAlphaSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_IMG_FUEL;
                    text = "$STR_KPLIB_LOGISTICSMGR_IMG_FUE";
                };

                class KPLIB_logisticsMgr_lblAlphaSupply : KPLIB_logisticsMgr_lblEndpointResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL_SUPPLY;
                    text = "$STR_KPLIB_LOGISTICSMGR_LBL_SUP";
                };

                class KPLIB_logisticsMgr_lblAlphaAmmo : KPLIB_logisticsMgr_lblAlphaSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL_AMMO;
                    text = "$STR_KPLIB_LOGISTICSMGR_LBL_AMM";
                };

                class KPLIB_logisticsMgr_lblAlphaFuel : KPLIB_logisticsMgr_lblAlphaSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL_FUEL;
                    text = "$STR_KPLIB_LOGISTICSMGR_LBL_FUE";
                };

                class KPLIB_logisticsMgr_txtAlphaSupply : KPLIB_logisticsMgr_txtEndpointResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_TXT_SUPPLY;
                };

                class KPLIB_logisticsMgr_txtAlphaAmmo : KPLIB_logisticsMgr_txtAlphaSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_TXT_AMMO;
                };

                class KPLIB_logisticsMgr_txtAlphaFuel : KPLIB_logisticsMgr_txtAlphaSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_TXT_FUEL;
                };
            };
        };

        class KPLIB_logisticsMgr_controlsBravo : KPLIB_logisticsMgr_controlsEndpoint {

            class controls {

                // Rinse and repeat, more or less, for BRAVO versus ALPHA...
                class KPLIB_logisticsMgr_lblBravo : KPLIB_logisticsMgr_lblEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL;
                    text = "$STR_KPLIB_LOGISTICSMGR_LBL_BRAVO";
                };

                class KPLIB_logisticsMgr_cboBravo : KPLIB_logisticsMgr_cboEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_CBO;
                };

                class KPLIB_logisticsMgr_imgBravoSupply : KPLIB_logisticsMgr_imgEndpointResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_IMG_SUPPLY;
                };

                class KPLIB_logisticsMgr_imgBravoAmmo : KPLIB_logisticsMgr_imgBravoSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_IMG_AMMO;
                };

                class KPLIB_logisticsMgr_imgBravoFuel : KPLIB_logisticsMgr_imgBravoSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_IMG_FUEL;
                };

                class KPLIB_logisticsMgr_lblBravoSupply : KPLIB_logisticsMgr_lblEndpointResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL_SUPPLY;
                };

                class KPLIB_logisticsMgr_lblBravoAmmo : KPLIB_logisticsMgr_lblBravoSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL_AMMO;
                };

                class KPLIB_logisticsMgr_lblBravoFuel : KPLIB_logisticsMgr_lblBravoSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL_FUEL;
                };

                class KPLIB_logisticsMgr_txtBravoSupply : KPLIB_logisticsMgr_txtEndpointResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_TXT_SUPPLY;
                };

                class KPLIB_logisticsMgr_txtBravoAmmo : KPLIB_logisticsMgr_txtBravoSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_TXT_AMMO;
                };

                class KPLIB_logisticsMgr_txtBravoFuel : KPLIB_logisticsMgr_txtBravoSupply {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_TXT_FUEL;
                };
            };
        };

        class KPLIB_logisticsMgr_btnConfirm : KPLIB_logisticsMgr_Button {
            idc = KPLIB_IDC_LOGISTICSMGR_BTN_MISSION_CONFIRM;
            x = KPLIB_LOGISTICSMGR_BTN_CONFIRM_X;
            y = KPLIB_LOGISTICSMGR_BTN_CONFIRM_Y;
            w = KPLIB_LOGISTICSMGR_BTN_CONFIRM_W;

            text = "$STR_KPLIB_LOGISTICSMGR_BTN_MISSION_CONFIRM";

            onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnConfirm_onButtonClick";
        };

        class KPLIB_logisticsMgr_btnAbort : KPLIB_logisticsMgr_Button {
            idc = KPLIB_IDC_LOGISTICSMGR_BTN_MISSION_ABORT;
            x = KPLIB_LOGISTICSMGR_BTN_ABORT_X;
            y = KPLIB_LOGISTICSMGR_BTN_ABORT_Y;
            w = KPLIB_LOGISTICSMGR_BTN_ABORT_W;

            text = "$STR_KPLIB_LOGISTICSMGR_BTN_MISSION_ABORT";

            onButtonClick = "_this spawn KPLIB_fnc_logisticsMgr_btnAbort_onButtonClick";
        };

        class KPLIB_logisticsMgr_map : XGUI_PRE_MapControl {
            idc = KPLIB_IDC_LOGISTICSMGR_CTRL_MAP;
            x = KPLIB_LOGISTICSMGR_MAPCTRL_X;
            y = KPLIB_LOGISTICSMGR_MAPCTRL_Y;
            w = KPLIB_LOGISTICSMGR_MAPCTRL_W;
            h = KPLIB_LOGISTICSMGR_MAPCTRL_H;
            // Does not actually support an 'onUnload' per se, but we have an event handler defined for use throughout anyway
        };

        class KPLIB_logisticsMgr_ctrlCross : XGUI_PRE_DialogCrossC {
            x = KPLIB_LOGISTICSMGR_CROSS_X;
            y = KPLIB_LOGISTICSMGR_CROSS_Y;
        };
    };
};
