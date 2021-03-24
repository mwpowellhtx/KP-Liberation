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
        https://community.bistudio.com/wiki/CT_LISTNBOX
        https://community.bistudio.com/wiki/CT_LISTNBOX#columns
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration
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

#define KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_X  (KPLIB_MISSIONSMGR_LNB_MISSIONS_X + KPLIB_MISSIONSMGR_LNB_MISSIONS_W + KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_Y  KPLIB_MISSIONSMGR_LNB_MISSIONS_Y
#define KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_W  (KPLIB_MISSIONSMGR_CTRLAREA_W - KPLIB_MISSIONSMGR_LNB_MISSIONS_W - KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_H  KPX_GETH_VHGS(KPLIB_MISSIONSMGR_CTRLAREA_H,1,19,KPX_SPACING_H)

// Four rows, three status rows plus one 'header' row
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X  KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_X
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y  (KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_Y + KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_W  KPX_GETW_VWGS(KPLIB_MISSIONSMGR_CTRLAREA_W,7,32,KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H  KPX_GETH_VHGS(KPLIB_MISSIONSMGR_CTRLAREA_H,6,19,KPX_SPACING_H)

#define KPLIB_MISSIONSMGR_BRIEFING_IMG_X        (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X + KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_W + KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_IMG_Y        KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y
#define KPLIB_MISSIONSMGR_BRIEFING_IMG_W        (KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_W - KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_W - KPX_SPACING_W)
#define KPLIB_MISSIONSMGR_BRIEFING_IMG_H        KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H

#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_X   KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_Y   (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y + KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_W   KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_W
#define KPLIB_MISSIONSMGR_BRIEFING_LNB_BRIEFING_H   KPLIB_MISSIONSMGR_CTRLAREA_H - (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_H + (2 * KPX_SPACING_H))

#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_X    KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_X
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_Y    (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_Y + KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPX_SPACING_H)
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_W    KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_W
#define KPLIB_MISSIONSMGR_BRIEFING_CT_BRIEFING_H    (KPLIB_MISSIONSMGR_CTRLAREA_H - (KPLIB_MISSIONSMGR_BRIEFING_LNB_TELEMETRY_H + KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_H + (2 * KPX_SPACING_H)))

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

class KPLIB_missionsMgr_ctBriefing_RowLabel : XGUI_PRE_Label {
    colorBackground[] = {0, 0, 0, 0};
    colorText[] = {1, 1, 1, 1};
    colorShadow[] = {0, 0, 0, 0};
    shadow = 0;
    sizeEx = KPX_TEXT_S;
    lineSpacing = 1;
    style = ST_LEFT + ST_MULTI;
};

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

        class KPLIB_missionsMgr_lnbMissions : XGUI_PRE_ListNBox {
            default = 0;
            idc = KPLIB_IDC_MISSIONSMGR_LNB_MISSIONS;

            x = KPLIB_MISSIONSMGR_LNB_MISSIONS_X;
            y = KPLIB_MISSIONSMGR_LNB_MISSIONS_Y;
            w = KPLIB_MISSIONSMGR_LNB_MISSIONS_W;
            h = KPLIB_MISSIONSMGR_LNB_MISSIONS_H;

            sizeEx = KPX_TEXT_S;
            rowHeight = KPX_TITLE_S_H;

            //          {_icon, _title, _gridref, _timer, _statusReport}
            columns[] = {    0,  0.12,      0.42,   0.52,           0.7};

            // onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbMissions_onLoadDummy";
            onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbMissions_onLoad";
            onLBSelChanged = "_this spawn KPLIB_fnc_missionsMgr_lnbMissions_onLBSelChanged";
        };

        class KPLIB_missionsMgr_btnRun : KPLIB_missionsMgr_btnButtonBase {
            idc = KPLIB_IDC_MISSIONSMGR_BTN_RUN;
            x = KPLIB_MISSIONSMGR_MISSIONS_BTN_RUN_X;

            text = "$STR_KPLIB_MISSIONSMGR_BTN_RUN";

            onLoad = "_this spawn KPLIB_fnc_missionsMgr_btnRun_onLoad";
            onButtonClick = "_this spawn KPLIB_fnc_missionsMgr_btnRequest_onButtonClick";
        };

        class KPLIB_missionsMgr_btnAbort : KPLIB_missionsMgr_btnButtonBase {
            idc = KPLIB_IDC_MISSIONSMGR_BTN_ABORT;
            x = KPLIB_MISSIONSMGR_MISSIONS_BTN_ABORT_X;

            text = "$STR_KPLIB_MISSIONSMGR_BTN_ABORT";

            onLoad = "_this spawn KPLIB_fnc_missionsMgr_btnAbort_onLoad";
            onButtonClick = "(_this + [KPLIB_missionsCO_requestAbort]) spawn KPLIB_fnc_missionsMgr_btnRequest_onButtonClick";
        };

        // This works, adding a group would be overkill at this point
        class KPLIB_missionsMgr_lblMissionTitle : XGUI_PRE_Label {
            idc = KPLIB_IDC_MISSIONSMGR_LBL_MISSION_TITLE;
            x = KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_X;
            y = KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_Y;
            w = KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_W;
            h = KPLIB_MISSIONSMGR_BRIEFING_LBL_MISSION_TITLE_H;

            text = "$STR_KPLIB_MISSIONSMGR_LBL_MISSION_TITLE_NA";

            onLoad = "_this call KPLIB_fnc_missionsMgr_lblMissionTitle_onLoad";
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

            // onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbTelemetry_onLoad";
            onLoad = "_this spawn KPLIB_fnc_missionsMgr_lnbTelemetry_onLoad";
            onLBSelChanged = "_this spawn KPLIB_fnc_missionsMgr_lnbTelemetry_onLBSelChanged";
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

            onLoad = "_this spawn KPLIB_fnc_missionsMgr_ctBriefing_onLoad";

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

        class KPLIB_missionsMgr_ctrlCross : XGUI_PRE_DialogCrossC {
            x = KPLIB_MISSIONSMGR_CROSS_X;
            y = KPLIB_MISSIONSMGR_CROSS_Y;
        };
    };
};
