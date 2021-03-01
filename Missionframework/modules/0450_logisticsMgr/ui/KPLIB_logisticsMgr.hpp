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
#define KPLIB_LOGISTICSMGR_EP_GRP_W             ((KPLIB_LOGISTICSMGR_LNB_TELEMETRY_W - KPX_SPACING_W) / 2)

#define KPLIB_LOGISTICSMGR_EP_GRP_ALPHA_X       KPLIB_LOGISTICSMGR_LNB_TELEMETRY_X
#define KPLIB_LOGISTICSMGR_EP_GRP_BRAVO_X       (KPLIB_LOGISTICSMGR_EP_GRP_ALPHA_X + KPLIB_LOGISTICSMGR_EP_GRP_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_GRP_Y             (KPLIB_LOGISTICSMGR_LNB_CONVOY_Y + KPLIB_LOGISTICSMGR_LNB_CONVOY_H + KPLIB_LOGISTICSMGR_BTN_H + (2 * KPX_SPACING_H))

// We know the endpoint group height by process of elimination...
//#define KPLIB_LOGISTICSMGR_EP_GRP_H             (KPLIB_LOGISTICSMGR_CTRLAREA_H - ((4 * KPX_SPACING_H) + KPLIB_LOGISTICSMGR_LNB_TELEMETRY_H + KPLIB_LOGISTICSMGR_LNB_CONVOY_H + (2 * KPLIB_LOGISTICSMGR_BTN_H)))
#define KPLIB_LOGISTICSMGR_EP_GRP_H             ((5 * KPLIB_LOGISTICSMGR_BTN_H) + (4 * KPX_SPACING_H))

// Which W we use to inform the grid for the child controls...

#define KPLIB_LOGISTICSMGR_EP_TITLE_X           0
#define KPLIB_LOGISTICSMGR_EP_TITLE_Y           0
#define KPLIB_LOGISTICSMGR_EP_TITLE_W           KPLIB_LOGISTICSMGR_EP_GRP_W
#define KPLIB_LOGISTICSMGR_EP_TITLE_H           KPLIB_LOGISTICSMGR_BTN_H

#define KPLIB_LOGISTICSMGR_EP_CBO_X             KPLIB_LOGISTICSMGR_EP_TITLE_X
#define KPLIB_LOGISTICSMGR_EP_CBO_Y             (KPLIB_LOGISTICSMGR_EP_TITLE_Y + KPX_SPACING_H + KPLIB_LOGISTICSMGR_EP_TITLE_H)
#define KPLIB_LOGISTICSMGR_EP_CBO_W             KPLIB_LOGISTICSMGR_EP_TITLE_W
#define KPLIB_LOGISTICSMGR_EP_CBO_H             KPLIB_LOGISTICSMGR_BTN_H

#define KPLIB_LOGISTICSMGR_EP_IMG_X             KPLIB_LOGISTICSMGR_EP_TITLE_X
#define KPLIB_LOGISTICSMGR_EP_IMG_W             KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_EP_GRP_W,1,6,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_IMG_H             KPLIB_LOGISTICSMGR_BTN_H

#define KPLIB_LOGISTICSMGR_EP_LBL_X             (KPLIB_LOGISTICSMGR_EP_IMG_X + KPLIB_LOGISTICSMGR_EP_IMG_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_LBL_W             KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_EP_GRP_W,2,6,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_LBL_H             KPLIB_LOGISTICSMGR_BTN_H

#define KPLIB_LOGISTICSMGR_EP_EDT_X             (KPLIB_LOGISTICSMGR_EP_LBL_X + KPLIB_LOGISTICSMGR_EP_LBL_W + KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_EDT_W             KPX_GETW_VWGS(KPLIB_LOGISTICSMGR_EP_GRP_W,3,6,KPX_SPACING_W)
#define KPLIB_LOGISTICSMGR_EP_EDT_H             KPLIB_LOGISTICSMGR_BTN_H

#define KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(RSC)    (KPLIB_LOGISTICSMGR_EP_CBO_Y + KPLIB_LOGISTICSMGR_EP_CBO_H + ((RSC + 1) * KPX_SPACING_H) + (RSC * KPLIB_LOGISTICSMGR_BTN_H))

class KPLIB_logisticsMgr_Button : XGUI_PRE_Button {
    h = KPLIB_LOGISTICSMGR_BTN_H;
};

// TODO: TBD: is there a better place for these sort of base classes (?)
class KPLIB_logisticsMgr_controlsEndpoint : XGUI_PRE_ControlsGroup {
    y = KPLIB_LOGISTICSMGR_EP_GRP_Y;
    w = KPLIB_LOGISTICSMGR_EP_GRP_W;
    h = KPLIB_LOGISTICSMGR_EP_GRP_H;
};

class KPLIB_logisticsMgr_lblEndpoint : XGUI_PRE_Label {
    x = KPLIB_LOGISTICSMGR_EP_TITLE_X;
    y = KPLIB_LOGISTICSMGR_EP_TITLE_Y;
    w = KPLIB_LOGISTICSMGR_EP_TITLE_W;
    h = KPLIB_LOGISTICSMGR_EP_TITLE_H;
    style = ST_CENTER;
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

    onLoad = "_this spawn KPLIB_fnc_logisticsMgr_cboEndpoint_onLoadDummyData";
    onLBSelChanged = "_this spawn KPLIB_fnc_logisticsMgr_cboEndpoint_onLBSelChanged";
};

class KPLIB_logisticsMgr_imgEndpointResource : XGUI_PRE_PictureRatio {
    x = KPLIB_LOGISTICSMGR_EP_IMG_X;
    w = KPLIB_LOGISTICSMGR_EP_IMG_W;
    h = KPLIB_LOGISTICSMGR_EP_IMG_H;
};

class KPLIB_logisticsMgr_imgSupplyResource : KPLIB_logisticsMgr_imgEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(0);
    text = "$STR_KPLIB_LOGISTICSMGR_IMG_SUP";
};

class KPLIB_logisticsMgr_imgAmmoResource : KPLIB_logisticsMgr_imgEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(1);
    text = "$STR_KPLIB_LOGISTICSMGR_IMG_AMM";
};

class KPLIB_logisticsMgr_imgFuelResource : KPLIB_logisticsMgr_imgEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(2);
    text = "$STR_KPLIB_LOGISTICSMGR_IMG_FUE";
};

class KPLIB_logisticsMgr_lblEndpointResource : XGUI_PRE_Label {
    x = KPLIB_LOGISTICSMGR_EP_LBL_X;
    w = KPLIB_LOGISTICSMGR_EP_LBL_W;
    h = KPLIB_LOGISTICSMGR_EP_LBL_H;
    text = "";
};

class KPLIB_logisticsMgr_lblSupplyResource : KPLIB_logisticsMgr_lblEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(0);
    text = "$STR_KPLIB_LOGISTICSMGR_LBL_SUP";
};

class KPLIB_logisticsMgr_lblAmmoResource : KPLIB_logisticsMgr_lblEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(1);
    text = "$STR_KPLIB_LOGISTICSMGR_LBL_AMM";
};

class KPLIB_logisticsMgr_lblFuelResource : KPLIB_logisticsMgr_lblEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(2);
    text = "$STR_KPLIB_LOGISTICSMGR_LBL_FUE";
};

// TODO: TBD: may go with a slider approach, i.e. XGUI_PRE_Slider
// TODO: TBD: along the lines of the A3 game options, CBA settings, i.e. "Label: [< slider >] [editbox]"
// https://community.bistudio.com/wiki/CT_STATIC
// https://community.bistudio.com/wiki/CT_SLIDER
// https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Control_Types
// https://github.com/CBATeam/CBA_A3/tree/master/addons/settings

// TODO: TBD: so the A3 game options numeric slider+editbox does not bother to filter much...
// TODO: TBD: but it does seem to be able to detect changes, so what is the event (?)
class KPLIB_logisticsMgr_edtEndpointResource : XGUI_PRE_EditText {
    x = KPLIB_LOGISTICSMGR_EP_EDT_X;
    w = KPLIB_LOGISTICSMGR_EP_EDT_W;
    h = KPLIB_LOGISTICSMGR_EP_EDT_H;
    text = "0";
    onKeyUp = "_this spawn KPLIB_fnc_logisticsMgr_edtResource_onKeyUp";
    onChar = "_this spawn KPLIB_fnc_logisticsMgr_edtResource_onChar";
    onKillFocus = "_this spawn KPLIB_fnc_logisticsMgr_edtResource_onKillFocus";
};

class KPLIB_logisticsMgr_edtSupplyResource : KPLIB_logisticsMgr_edtEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(0);
};

class KPLIB_logisticsMgr_edtAmmoResource : KPLIB_logisticsMgr_edtEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(1);
};

class KPLIB_logisticsMgr_edtFuelResource : KPLIB_logisticsMgr_edtEndpointResource {
    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(2);
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

            //          {_mil}
            columns[] = {   0};

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

            //          {_telemetry, _value}
            columns[] = {     -0.01,   0.45};

            onLoad = "_this spawn KPLIB_fnc_logisticsMgr_lnbTelemetry_onLoadDummyData";
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

            //          { _i, _img, _sum, _img, _sum, _img, _sum}
            columns[] = {  0,  0.2,  0.3,  0.4,  0.5,  0.6,  0.7};
            // Resources: _i, SUPPLY ^^^, AMMO ^^^^^, FUEL ^^^^^

            onLoad = "_this spawn KPLIB_fnc_logisticsMgr_lnbConvoy_onLoadDummyData";
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

            class controls {

                // TODO: TBD: need a picture class if there is not one already...
                class KPLIB_logisticsMgr_lblAlpha : KPLIB_logisticsMgr_lblEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL;
                    text = "$STR_KPLIB_LOGISTICSMGR_LBL_ALPHA";
                };

                // https://community.bistudio.com/wiki/CT_LISTBOX
                class KPLIB_logisticsMgr_cboAlpha : KPLIB_logisticsMgr_cboEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_CBO;
                    endpoint = "alpha";
                };

                class KPLIB_logisticsMgr_imgAlphaSupply : KPLIB_logisticsMgr_imgSupplyResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_IMG_SUPPLY;
                };

                class KPLIB_logisticsMgr_imgAlphaAmmo : KPLIB_logisticsMgr_imgAmmoResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_IMG_AMMO;
                };

                class KPLIB_logisticsMgr_imgAlphaFuel : KPLIB_logisticsMgr_imgFuelResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_IMG_FUEL;
                };

                class KPLIB_logisticsMgr_lblAlphaSupply : KPLIB_logisticsMgr_lblSupplyResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL_SUPPLY;
                };

                class KPLIB_logisticsMgr_lblAlphaAmmo : KPLIB_logisticsMgr_lblAmmoResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL_AMMO;
                };

                class KPLIB_logisticsMgr_lblAlphaFuel : KPLIB_logisticsMgr_lblFuelResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_LBL_FUEL;
                };

                class KPLIB_logisticsMgr_edtAlphaSupply : KPLIB_logisticsMgr_edtSupplyResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_SUPPLY;
                    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(0);
                };

                class KPLIB_logisticsMgr_edtAlphaAmmo : KPLIB_logisticsMgr_edtAmmoResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_AMMO;
                    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(1);
                };

                class KPLIB_logisticsMgr_edtAlphaFuel : KPLIB_logisticsMgr_edtFuelResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_ALPHA_EDT_FUEL;
                    y = KPLIB_LOGISTICSMGR_EP_RSC_GET_Y(2);
                };
            };
        };

        class KPLIB_logisticsMgr_controlsBravo : KPLIB_logisticsMgr_controlsEndpoint {
            x = KPLIB_LOGISTICSMGR_EP_GRP_BRAVO_X;

            class controls {

                // Rinse and repeat, more or less, for BRAVO versus ALPHA...
                class KPLIB_logisticsMgr_lblBravo : KPLIB_logisticsMgr_lblEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL;
                    text = "$STR_KPLIB_LOGISTICSMGR_LBL_BRAVO";
                };

                class KPLIB_logisticsMgr_cboBravo : KPLIB_logisticsMgr_cboEndpoint {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_CBO;
                    endpoint = "bravo";
                };

                class KPLIB_logisticsMgr_imgBravoSupply : KPLIB_logisticsMgr_imgSupplyResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_IMG_SUPPLY;
                };

                class KPLIB_logisticsMgr_imgBravoAmmo : KPLIB_logisticsMgr_imgAmmoResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_IMG_AMMO;
                };

                class KPLIB_logisticsMgr_imgBravoFuel : KPLIB_logisticsMgr_imgFuelResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_IMG_FUEL;
                };

                class KPLIB_logisticsMgr_lblBravoSupply : KPLIB_logisticsMgr_lblSupplyResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL_SUPPLY;
                };

                class KPLIB_logisticsMgr_lblBravoAmmo : KPLIB_logisticsMgr_lblAmmoResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL_AMMO;
                };

                class KPLIB_logisticsMgr_lblBravoFuel : KPLIB_logisticsMgr_lblFuelResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_LBL_FUEL;
                };

                class KPLIB_logisticsMgr_edtBravoSupply : KPLIB_logisticsMgr_edtSupplyResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_SUPPLY;
                };

                class KPLIB_logisticsMgr_edtBravoAmmo : KPLIB_logisticsMgr_edtAmmoResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_AMMO;
                };

                class KPLIB_logisticsMgr_edtBravoFuel : KPLIB_logisticsMgr_edtFuelResource {
                    idc = KPLIB_IDC_LOGISTICSMGR_BRAVO_EDT_FUEL;
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
