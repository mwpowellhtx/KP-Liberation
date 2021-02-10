/*
    KP Liberation productionMgr dialog

    File: KPLIB_productionMgr.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 14:19:21
    Last Update: 2021-02-06 14:19:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Opens the module dialog.
*/

#define KPLIB_PRODUCTIONMGR_DIALOG_WC           (0.8 * KPX_DEFAULT_DIALOG_WC)
#define KPLIB_PRODUCTIONMGR_DIALOG_HC           KPX_DEFAULT_DIALOG_HC
#define KPLIB_PRODUCTIONMGR_DIALOG_XC           KPX_GETXC_W(KPLIB_PRODUCTIONMGR_DIALOG_WC)
#define KPLIB_PRODUCTIONMGR_CTRLAREA_WC         (KPLIB_PRODUCTIONMGR_DIALOG_WC - (2 * KPX_SPACING_W))
#define KPLIB_PRODUCTIONMGR_CTRLAREA_HC         (KPLIB_PRODUCTIONMGR_DIALOG_HC - (2 * KPX_SPACING_H))

#define KPLIB_PRODUCTIONMGR_TITLE_WC            KPLIB_PRODUCTIONMGR_DIALOG_WC
#define KPLIB_PRODUCTIONMGR_TITLE_XC            KPLIB_PRODUCTIONMGR_DIALOG_XC
#define KPLIB_PRODUCTIONMGR_CROSS_XC            (KPLIB_PRODUCTIONMGR_TITLE_XC + KPLIB_PRODUCTIONMGR_TITLE_WC - GUI_GRID_W)

#define KPLIB_PRODUCTIONMGR_BTN_H               KPX_BUTTON_M_H

#define KPLIB_PRODUCTIONMGR_CTRLAREA_XC         KPX_GETXL_VXW(KPLIB_PRODUCTIONMGR_DIALOG_XC,KPX_SPACING_W)
#define KPLIB_PRODUCTIONMGR_CTRLAREA_YC         KPX_DEFAULT_CTRLAREA_YC

#define KPLIB_PRODUCTIONMGR_LNBSECTORS_H        (KPLIB_PRODUCTIONMGR_CTRLAREA_HC - (3 * KPLIB_PRODUCTIONMGR_BTN_H) - (5 * KPX_SPACING_H))
#define KPLIB_PRODUCTIONMGR_LNBSECTORS_W        KPX_GETW_VWGS(KPLIB_PRODUCTIONMGR_DIALOG_WC,8,25,KPX_SPACING_W)

// Four rows, three status rows plus one 'header' row
#define KPLIB_PRODUCTIONMGR_LNBSTATUS_H         (5 * KPX_TEXT_M)
#define KPLIB_PRODUCTIONMGR_LNBSTATUS_W         (KPLIB_PRODUCTIONMGR_CTRLAREA_WC - KPLIB_PRODUCTIONMGR_LNBSECTORS_W - KPX_SPACING_W)

#define KPLIB_PRODUCTIONMGR_LNBSTATUS_XC        KPX_GETXL_VXW(KPLIB_PRODUCTIONMGR_CTRLAREA_XC,(KPLIB_PRODUCTIONMGR_LNBSECTORS_W + KPX_SPACING_W))
#define KPLIB_PRODUCTIONMGR_LNBSTATUS_YC        KPLIB_PRODUCTIONMGR_CTRLAREA_YC

#define KPLIB_PRODUCTIONMGR_LNBQUEUE_H          (7 * KPX_TEXT_M)
#define KPLIB_PRODUCTIONMGR_LNBQUEUE_W          KPX_GETW_VWGS(KPLIB_PRODUCTIONMGR_DIALOG_WC,6,25,KPX_SPACING_W)

#define KPLIB_PRODUCTIONMGR_LNBQUEUE_XC         KPLIB_PRODUCTIONMGR_LNBSTATUS_XC
#define KPLIB_PRODUCTIONMGR_LNBQUEUE_YC         KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBSTATUS_YC,(KPX_SPACING_H + KPLIB_PRODUCTIONMGR_LNBSTATUS_H))

#define KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W      KPX_GETW_VWGS(KPLIB_PRODUCTIONMGR_DIALOG_WC,2,25,KPX_SPACING_W)

/*
    Description:
        The queue list box will have several buttons accompanying it for purposes of
        arranging the queue and interacting with it. The buttons will be arranged in
        a grid like manner.

        11111 22222 33333
        44444 55555 66666
 */

// Align the queue buttons with respect to the queue list box from the bottom up
#define KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XL     KPX_GETXL_VXW(KPLIB_PRODUCTIONMGR_LNBQUEUE_XC,(KPLIB_PRODUCTIONMGR_LNBQUEUE_W + KPX_SPACING_W))
#define KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XM     KPX_GETXL_VXW(KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XL,(KPX_SPACING_W + KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W))
#define KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XR     KPX_GETXL_VXW(KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XM,(KPX_SPACING_W + KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W))

#define KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_GETDELTAH(BY)  (KPLIB_PRODUCTIONMGR_LNBQUEUE_H - ((BY + 1) * KPLIB_PRODUCTIONMGR_BTN_H) - (BY * KPX_SPACING_H))

// Aligned with the buttons...
#define KPLIB_PRODUCTIONMGR_LBLTIMEREM_X        KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XL
#define KPLIB_PRODUCTIONMGR_LBLTIMEREM_W        ((KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XR + KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W) - KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XL)

// Aligning time remaining elements with the queue list box from the top down
#define KPLIB_PRODUCTIONMGR_LBLTIMEREM_GETDELTAH(BY)    ((BY * KPLIB_PRODUCTIONMGR_BTN_H) + (BY * KPX_SPACING_H))

// Math from the bottom of the dialog up, which simplifies the substitution throughout as well.
#define KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(BY)   (KPLIB_PRODUCTIONMGR_CTRLAREA_HC - ((BY + 1) * KPLIB_PRODUCTIONMGR_BTN_H) - ((BY + 1) * KPX_SPACING_H))

#define KPLIB_PRODUCTIONMGR_MAPCTRL_XC          KPLIB_PRODUCTIONMGR_LNBSTATUS_XC
#define KPLIB_PRODUCTIONMGR_MAPCTRL_YC          KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,(KPX_SPACING_H + KPLIB_PRODUCTIONMGR_LNBQUEUE_H))

#define KPLIB_PRODUCTIONMGR_MAPCTRL_W           KPLIB_PRODUCTIONMGR_LNBSTATUS_W
#define KPLIB_PRODUCTIONMGR_MAPCTRL_H           (KPLIB_PRODUCTIONMGR_CTRLAREA_HC - KPLIB_PRODUCTIONMGR_LNBQUEUE_H - KPLIB_PRODUCTIONMGR_LNBSTATUS_H - (2 * KPX_SPACING_H))

class KPLIB_productionMgr {
    idd = KPLIB_IDD_PRODUCTIONMGR;
    movingEnable = 0;

    onLoad = "_this spawn KPLIB_fnc_productionMgr_onLoad";
    onUnload = "_this spawn KPLIB_fnc_productionMgr_onUnload";

    class controlsBackground {

        //// TODO: TBD: starting slowing to prove this thing out...
        //class KPLIB_DialogTitle : KPGUI_PRE_DialogTitleS {
        class KPLIB_DialogTitle : XGUI_PRE_DialogTitleC {
            x = KPLIB_PRODUCTIONMGR_TITLE_XC;
            w = KPLIB_PRODUCTIONMGR_TITLE_WC;
            text = "$STR_KPLIB_DIALOG_PRODUCTIONMGR_TITLE";
            onLoad = "_this spawn KPLIB_fnc_productionMgr_ctrlBg_title_onLoad";
        };

        //class KPLIB_DialogArea : KPGUI_PRE_DialogBackgroundS {
        class KPLIB_DialogArea : XGUI_PRE_DialogBackgroundC {
            x = KPLIB_PRODUCTIONMGR_DIALOG_XC;
            w = KPLIB_PRODUCTIONMGR_DIALOG_WC;
        };
    };

    class controls {

        // https://community.bistudio.com/wiki/CT_LISTNBOX
        // https://community.bistudio.com/wiki/CT_LISTNBOX#columns
        class KPLIB_productionMgr_lnbSectors : XGUI_PRE_ListNBox {
            default = 0;
            idc = KPLIB_IDC_PRODUCTIONMGR_LNBSECTORS;

            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPLIB_PRODUCTIONMGR_CTRLAREA_YC;
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;
            h = KPLIB_PRODUCTIONMGR_LNBSECTORS_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          {_grid, _markerText}
            columns[] = {-0.01,         0.2};

            onLoad = "_this spawn kplib_fnc_productionmgr_lnbsectors_onload";
            onLBSelChanged = "_this spawn KPLIB_fnc_productionMgr_lnbSectors_onLBSelChanged";
        };

        class KPLIB_ctrl_lnbStatus : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_PRODUCTIONMGR_LNBSTATUS;
            x = KPLIB_PRODUCTIONMGR_LNBSTATUS_XC;
            y = KPLIB_PRODUCTIONMGR_LNBSTATUS_YC;
            w = KPLIB_PRODUCTIONMGR_LNBSTATUS_W;
            h = KPLIB_PRODUCTIONMGR_LNBSTATUS_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          { _img, _label, _cap, _prod, _totals, crates}
            columns[] = {-0.01,  0.075,  0.2,  0.35,     0.5,    0.6};

            onLoad = "_this spawn KPLIB_fnc_productionMgr_lnbStatus_onLoad";
            onLBSelChanged = "_this spawn KPLIB_fnc_productionMgr_lnbStatus_onLBSelChanged";
            onLBDblClick = "_this spawn KPLIB_fnc_productionMgr_lnbStatus_onLBDblClick";
        };

        class KPLIB_ctrl_lnbQueue : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_PRODUCTIONMGR_LNBQUEUE;
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_XC;
            y = KPLIB_PRODUCTIONMGR_LNBQUEUE_YC;
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_W;
            h = KPLIB_PRODUCTIONMGR_LNBQUEUE_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          { _img, _label}
            columns[] = {-0.01,    0.3};

            onLoad = "_this spawn KPLIB_fnc_productionMgr_lnbQueue_onLoad";
            onLBSelChanged = "_this spawn KPLIB_fnc_productionMgr_lnbQueue_onLBSelChanged";
            onLBDblClick = "_this spawn KPLIB_fnc_productionMgr_lnbQueue_onLBDblClick";
        };

        class KPLIB_ctrl_lblTimeRemaining : XGUI_PRE_Label {
            x = KPLIB_PRODUCTIONMGR_LBLTIMEREM_X;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LBLTIMEREM_GETDELTAH(0));
            w = KPLIB_PRODUCTIONMGR_LBLTIMEREM_W;
            text = "TIME REMAINING:";
        };

        class KPLIB_ctrl_lblTimeRemainingFormatted : XGUI_PRE_Label {
            idc = KPLIB_IDC_PRODUCTIONMGR_LBLTIMEREMAININGFORMATTED;
            x = KPLIB_PRODUCTIONMGR_LBLTIMEREM_X;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LBLTIMEREM_GETDELTAH(1));
            w = KPLIB_PRODUCTIONMGR_LBLTIMEREM_W;

            style = ST_RIGHT;

            // TODO: TBD: may actually refator this to string table...
            text = "#.##:##:##";
            //      d.HH:mm:ss

            onLoad = "_this spawn KPLIB_fnc_productionMgr_lblTimeRemainingFormatted_onLoad";
        };

        class KPLIB_ctrl_btnRemove : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XL;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_GETDELTAH(1));
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W;

            // TODO: TBD: refactor to string table... can unicode be supported (?)
            text = "> DEQ";
            sizeEx = KPX_TEXT_S;

            onLoad = "_this spawn KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnIncreasePriority : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XM;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_GETDELTAH(1));
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W;

            // TODO: TBD: refactor to string table... can unicode be supported (?)
            text = "+ PRI";
            sizeEx = KPX_TEXT_S;

            onLoad = "(_this + [[1]]) call KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnDecreasePriority : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XR;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_GETDELTAH(1));
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W;

            // TODO: TBD: refactor to string table... can unicode be supported (?)
            text = "- PRI";
            sizeEx = KPX_TEXT_S;

            onLoad = "(_this + [[-1]]) call KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnEnqueueSupply : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XL;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_GETDELTAH(0));
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W;

            // TODO: TBD: refactor to string table... can unicode be supported (?)
            text = "< SUP";
            sizeEx = KPX_TEXT_S;

            onLoad = "_this spawn KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnEnqueueAmmo : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XM;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_GETDELTAH(0));
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W;

            // TODO: TBD: refactor to string table... can unicode be supported (?)
            text = "< AMM";
            sizeEx = KPX_TEXT_S;

            onLoad = "_this spawn KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnEnqueueFuel : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_XR;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_LNBQUEUE_YC,KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_GETDELTAH(0));
            w = KPLIB_PRODUCTIONMGR_LNBQUEUE_BTN_W;

            // TODO: TBD: refactor to string table... can unicode be supported (?)
            text = "< FUE";
            sizeEx = KPX_TEXT_S;

            onLoad = "_this spawn KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_map : XGUI_PRE_MapControl {
            x = KPLIB_PRODUCTIONMGR_MAPCTRL_XC;
            y = KPLIB_PRODUCTIONMGR_MAPCTRL_YC;
            w = KPLIB_PRODUCTIONMGR_MAPCTRL_W;
            h = KPLIB_PRODUCTIONMGR_MAPCTRL_H;
        };

        class KPLIB_ctrl_btnRefresh : XGUI_PRE_Button {
            idc = KPLIB_IDC_PRODUCTIONMGR_CTRL_BTNREFRESH;
            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_CTRLAREA_YC,KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(2));
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;

            // TODO: TBD: refactor to string table...
            text = "Refresh";

            onButtonClick = "_this spawn KPLIB_fnc_productionMgr_btnRefresh_onButtonClick";
        };

        class KPLIB_ctrl_btnApply : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_CTRLAREA_YC,KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(1));
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;

            // TODO: TBD: refactor to string table...
            text = "Apply";

            onLoad = "_this spawn KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_ctrl_btnClose : XGUI_PRE_Button {
            x = KPLIB_PRODUCTIONMGR_CTRLAREA_XC;
            y = KPX_GETYT_VYH(KPLIB_PRODUCTIONMGR_CTRLAREA_YC,KPLIB_PRODUCTIONMGR_BTN_GETDELTAH(0));
            w = KPLIB_PRODUCTIONMGR_LNBSECTORS_W;

            // TODO: TBD: refactor to string table...
            text = "Close";

            onLoad = "_this spawn KPLIB_fnc_productionMgr_onLoad_debug";
        };

        class KPLIB_DialogCross : XGUI_PRE_DialogCrossC {
            x = KPLIB_PRODUCTIONMGR_CROSS_XC;
        };
    };
};
