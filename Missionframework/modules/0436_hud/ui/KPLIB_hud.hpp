/*
    File: KPLIB_hud.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-25 13:00:39
    Last Update: 2021-05-17 15:00:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        There is not really a manager in this instance, but rather a heads up display. We
        also reserved the name "hud" for use as the core KPLIB HUD API, of sorts, so this
        is what we are running with for purposes of defining and supporting the heads up
        display configuration, event handlers, and so on.

    References:
        https://community.bistudio.com/wiki/cutRsc
        https://community.bistudio.com/wiki/Description.ext
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration
        https://community.bistudio.com/wiki/CT_CONTROLS_GROUP
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
        https://community.bistudio.com/wiki/CT_PROGRESS
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Common_Properties
 */

/*
    --- SECTOR CT_CONTROLS_GROUP geometry ---
 */

#define KPX_SPACING_W_SHADOW                (0.75 * KPX_SPACING_W)
#define KPX_SPACING_H_SHADOW                (0.75 * KPX_SPACING_H)

#define KPLIB_HUD_SHADOW_COLOR              {0.2, 0.2, 0.2, 0.9}

#define KPLIB_HUD_SIDEBAR_H_2               (0.5 * KPX_DEFAULT_SIDEBAR_CTRLAREA_H)

// TODO: TBD: kind of experimental at this stage... tinker with the widths etc
#define KPLIB_HUD_GRP_SECTOR_W              (0.75 * KPX_DEFAULT_SIDEBAR_CTRLAREA_W)
#define KPLIB_HUD_GRP_SECTOR_X              (KPX_DEFAULT_SIDEBAR_CTRLAREA_XR + (KPX_DEFAULT_SIDEBAR_CTRLAREA_W - KPLIB_HUD_GRP_SECTOR_W))
#define KPLIB_HUD_GRP_SECTOR_Y              (KPX_DEFAULT_SIDEBAR_CTRLAREA_YB - KPLIB_HUD_SIDEBAR_H_2)

// Y coord is 0 meaning very top-most of the group
#define KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W  KPX_GETW_VWGS(KPLIB_HUD_GRP_SECTOR_W,7,10,KPX_SPACING_W)
#define KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H  KPX_BUTTON_M_H
#define KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_X  (KPLIB_HUD_GRP_SECTOR_W - KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W)

// XY coordinates are both 0, very left-most, top-most of the group
#define KPLIB_HUD_GRP_SECTOR_LBL_TIMER_W    (KPLIB_HUD_GRP_SECTOR_W - (KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W + KPX_SPACING_W))
#define KPLIB_HUD_GRP_SECTOR_LBL_TIMER_H    KPX_BUTTON_S_H

#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_X  KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_X
#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_Y  (KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H + KPX_SPACING_H)
#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_W  KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W
#define KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_H  KPX_BUTTON_S_H

#define KPLIB_HUD_GRP_SECTOR_H              (KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H + KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_H + KPX_SPACING_H)


/*
    --- FOB LISTNBOX geometry ---

    Yes, that's right, we ended up rolling with a "simple" LISTNBOX for purposes
    of containing the FOB HUD elements. Each REPORT ends up being a single ROW in
    the LISTNBOX. For SHADOW effect, we use the same control meta data, and offset
    by a little bit. We introduce a custom 'shadowColor[]' attribute for purposes
    of overriding the COLOR reported in the DISPATCH, which turns out to be a very
    nice effect indeed.
 */

#define KPLIB_HUD_LNB_FOB_W                 (0.5 * KPX_DEFAULT_SIDEBAR_CTRLAREA_W)
#define KPLIB_HUD_LNB_FOB_X                 (KPX_DEFAULT_SIDEBAR_CTRLAREA_XR + (KPX_DEFAULT_SIDEBAR_CTRLAREA_W - KPLIB_HUD_LNB_FOB_W))
#define KPLIB_HUD_LNB_FOB_Y                 KPX_DEFAULT_SIDEBAR_CTRLAREA_YB
#define KPLIB_HUD_LNB_FOB_H                 (KPX_BUTTON_L_H + (10 * (KPX_SPACING_H + KPX_BUTTON_M_H)))

// Offset by just a little bit, plus using a shadow color, gives the impression of a raised, shadow effect
#define KPLIB_HUD_LNB_FOB_X_SHADOW          (KPLIB_HUD_LNB_FOB_X + KPX_SPACING_W_SHADOW)
#define KPLIB_HUD_LNB_FOB_Y_SHADOW          (KPLIB_HUD_LNB_FOB_Y + KPX_SPACING_H_SHADOW)

// In either HORIZONTAL or VERTICAL directions we assume
#define KPLIB_HUD_LNB_FOB_PADDING           KPX_SPACING_H

#define KPLIB_HUD_CT_FOB_W                  KPX_DEFAULT_SIDEBAR_CTRLAREA_W
#define KPLIB_HUD_CT_FOB_X                  KPX_DEFAULT_SIDEBAR_CTRLAREA_XR
#define KPLIB_HUD_CT_FOB_Y                  KPX_DEFAULT_SIDEBAR_CTRLAREA_YB
                                            // Using forward knowledge of the known FOB REPORT items
#define KPLIB_HUD_CT_FOB_H                  (KPX_BUTTON_L_H + (10 * (KPX_SPACING_H + KPX_BUTTON_M_H)))

#define KPLIB_HUD_CT_FOB_LINE_SPACING       KPX_SPACING_H

#define KPLIB_HUD_CT_FOB_ROWBG_W            KPLIB_HUD_CT_FOB_W
#define KPLIB_HUD_CT_FOB_ROWBG_X            0

#define KPLIB_HUD_CT_FOB_HEADERBG_W         KPLIB_HUD_CT_FOB_ROWBG_W
#define KPLIB_HUD_CT_FOB_HEADERBG_X         KPLIB_HUD_CT_FOB_ROWBG_X

#define KPLIB_HUD_CT_FOB_ROW_REPORT_W       KPX_GETW_VWGS(KPLIB_HUD_CT_FOB_ROWBG_W,9,10,KPX_SPACING_W)
#define KPLIB_HUD_CT_FOB_ROW_REPORT_X       0
#define KPLIB_HUD_CT_FOB_ROW_PICTURE_W      (KPLIB_HUD_CT_FOB_ROWBG_W - KPLIB_HUD_CT_FOB_ROW_REPORT_W - KPX_SPACING_W)
#define KPLIB_HUD_CT_FOB_ROW_PICTURE_X      (KPLIB_HUD_CT_FOB_ROW_REPORT_W + KPX_SPACING_W)
#define KPLIB_HUD_CT_FOB_ROW_H              KPX_BUTTON_M_H

#define KPLIB_HUD_CT_FOB_HEADER_REPORT_W    KPLIB_HUD_CT_FOB_ROW_REPORT_W
#define KPLIB_HUD_CT_FOB_HEADER_REPORT_X    KPLIB_HUD_CT_FOB_ROW_REPORT_X
#define KPLIB_HUD_CT_FOB_HEADER_PICTURE_W   KPLIB_HUD_CT_FOB_ROW_PICTURE_W
#define KPLIB_HUD_CT_FOB_HEADER_PICTURE_X   KPLIB_HUD_CT_FOB_ROW_PICTURE_X
#define KPLIB_HUD_CT_FOB_HEADER_H           KPX_BUTTON_L_H

// TODO: TBD: refactor the HUD UI oriented functions to the same folders...
// TODO: TBD: we should also separate the RscTitles to a root file...
// TODO: TBD: then also separate each HUD class accordingly...
// TODO: TBD: because we have a couple of them that are more or less 'working' albeit need to be retouched a bit...
// TODO: TBD: but we also have two or three more that we will need to identify...

// TODO: TBD: should consider refactoring the RscTitles themselves...
// TODO: TBD: along similar lines as with the functions, statemachine, etc...
// TODO: TBD: which would allow for potentially multiple different layers supported by other modules
class RscTitles {

    class KPLIB_hud {
        idd = KPLIB_IDD_UNDEFINED;
        // Duration of fade in/out effects when opening/closing in seconds
        fadeIn = 0;
        fadeOut = 0;
        duration = 1e+011; // Must be a good long number, in seconds to expect it to stuck around
        movingEnable = true;
        controls[] = {};
    };

    class KPLIB_hudSector_blank : KPLIB_hud {
        name = "KPLIB_hudSector_blank";
        idd = KPLIB_IDD_HUD_SECTOR_OVERLAY;

        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudSector_blank')]) spawn KPLIB_fnc_hudSector_onLoad";
    };

    class KPLIB_hudSector_overlay : KPLIB_hud {
        name = "KPLIB_hudSector_overlay";
        idd = KPLIB_IDD_HUD_SECTOR_OVERLAY;

        controls[] = {
            KPLIB_hudSector_ctrlsGrpSector
        };

        /* Which is not for shadow purposes in this instance, but rather so that the BG
         * half of the poor man's 'progress bar' is always in the background. BG serves
         * as the back drop color behind the pseudo progress bar, and also informs the
         * total available width of the foreground for percentage and X coordinate reasons. */

        controlsBackground[] = {
            KPLIB_hudSector_ctrlsGrpSectorBackground
        };

        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hudSector_overlay')]) spawn KPLIB_fnc_hudSector_onLoad";

        class KPLIB_hudSector_ctrlsGrpSector_lblProgressBarBase : XGUI_PRE_Label {
            x = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_X;
            y = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_Y;
            w = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_W;
            h = KPLIB_HUD_GRP_SECTOR_PROGRESSBAR_H;
            onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblProgressBar_onLoad";
        };

        class KPLIB_hudSector_ctrlsGrpSectorBase : XGUI_PRE_ControlsGroup {
            x = KPLIB_HUD_GRP_SECTOR_X;
            y = KPLIB_HUD_GRP_SECTOR_Y;
            w = KPLIB_HUD_GRP_SECTOR_W;
            h = KPLIB_HUD_GRP_SECTOR_H;

            // Zero the V+H scrollbars, i.e. no scroll bars
            class VScrollbar: XGUI_PRE_ScrollBar {
                width = 0;
            };

            class HScrollbar: XGUI_PRE_ScrollBar {
                height = 0;
            };
        };

        class KPLIB_hudSector_ctrlsGrpSectorBackground : KPLIB_hudSector_ctrlsGrpSectorBase {
            idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_BG;

            class controls {
                class KPLIB_hudSector_ctrlsGrpSector_lblPbBlufor : KPLIB_hudSector_ctrlsGrpSector_lblProgressBarBase {
                    idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_BLUFOR;
                    colorBackground[] = {0, 0, 0.85, 1};
                    progressBarSide = "blufor";
                };
            };
        };

        class KPLIB_hudSector_ctrlsGrpSector : KPLIB_hudSector_ctrlsGrpSectorBase {
            idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR;

            x = KPLIB_HUD_GRP_SECTOR_X;
            y = KPLIB_HUD_GRP_SECTOR_Y;
            w = KPLIB_HUD_GRP_SECTOR_W;
            h = KPLIB_HUD_GRP_SECTOR_H;

            // Zero the V+H scrollbars, i.e. no scroll bars
            class VScrollbar : XGUI_PRE_ScrollBar {
                width = 0;
            };

            class HScrollbar : XGUI_PRE_ScrollBar {
                height = 0;
            };

            // TODO: TBD: "forward" controls i.e. the PB
            class controls {
                class KPLIB_hudSector_ctrlsGrpSector_lblTimer : XGUI_PRE_Label {
                    idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_TIMER;
                    w = KPLIB_HUD_GRP_SECTOR_LBL_TIMER_W;
                    h = KPLIB_HUD_GRP_SECTOR_LBL_TIMER_H;
                    colorText[] = {0.85, 0.85, 0, 1};
                    sizeEx = KPX_TITLE_XS_H;
                    onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblTimer_onLoad";
                };
                class KPLIB_hudSector_ctrlsGrpSector_lblSectorText : XGUI_PRE_Label {
                    idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_SECTOR_TEXT;
                    x = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_X;
                    w = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_W;
                    h = KPLIB_HUD_GRP_SECTOR_LBL_SECTOR_TEXT_H;
                    sizeEx = KPX_TITLE_M_H;
                    colorText[] = {1, 1, 1, 1};
                    onLoad = "_this spawn KPLIB_fnc_hudSector_ctrlsGrpSector_lblSectorText_onLoad";
                };
                // Whereas progress bar always aligns with side OPFOR the sector
                class KPLIB_hudSector_ctrlsGrpSector_lblPbOpfor : KPLIB_hudSector_ctrlsGrpSector_lblProgressBarBase {
                    idc = KPLIB_IDD_HUD_SECTOR_CTRLS_GRP_SECTOR_LBL_PB_OPFOR;
                    colorBackground[] = {0.85, 0, 0, 1};
                    progressBarSide = "opfor";
                };
            };
        };
    };

    // TODO: TBD: 1) separate SECTOR HUD from FOB HUD
    // TODO: TBD: 2) wake up and capture HUD dispatch report to HASHMAP
    // TODO: TBD: 3) respond by cutting in the appropriate resources
    // TODO: TBD: 4) which these should simply respond by lifting the HASHMAP and populating
    // TODO: TBD: 5) OR, if none is available, or report is at all incomplete, then hide the HUD controls
    class KPLIB_hud_blank : KPLIB_hud {
        name = "KPLIB_hud_blank";
        idd = KPLIB_IDD_HUD_OVERLAY;

        // Unfortunately cannot drop this on the base class and pickup a derived attribute
        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hud_blank')]) spawn KPLIB_fnc_hud_onLoad";
    };

    // Separate key sitrep bits for use via a layered cutRsc approach
    class KPLIB_hud_overlay : KPLIB_hud {
        name = "KPLIB_hud_overlay";
        idd = KPLIB_IDD_HUD_OVERLAY;

        // Unfortunately cannot drop this on the base class and pickup a derived attribute
        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hud_overlay')]) spawn KPLIB_fnc_hud_onLoad";

        controls[] = {
            KPLIB_hud_lnbFob
        };

        // We send the shadow LISTNBOX to background
        controlsBackground[] = {
            KPLIB_hud_lnbFobShadow
        };

        // // https://community.bistudio.com/wiki/CT_PROGRESS
        // class KPLIB_hudSector_ctrlsGrpSector : XGUI_PRE_ControlsGroup {
        //     // 1. marker text
        //     // 2. progress bar
        //     // 3. 'timer'
        // };

// // TODO: TBD: this is how the "progress bar" was done in the legacy...
// class CaptureFrameStandard {
//     idc = -1;
//     type =  CT_STATIC;
//     font = FontM;
//     sizeEx = 0.023;
//     text = "";
// };

// class CaptureFrame : CaptureFrameStandard {
//     idc = KPLIB_IDC_UIMANAGER_SECTOR_PB_FRAME;
//     style = ST_FRAME;
//     colorText[] = COLOR_BLACK;
//     colorBackground[] = COLOR_OPFOR_NOALPHA;
//     x = 0.9125 * safezoneW + safezoneX;
//     w = 0.085 * safezoneW;
//     y = 0.358 * safezoneH + safezoneY;
//     h = 0.012 * safezoneH;
// };

// class CaptureFrame_OPFOR : CaptureFrameStandard {
//     idc = KPLIB_IDC_UIMANAGER_SECTOR_PB_OPFOR;
//     style = ST_TYPE;
//     colorText[] = {0.6, 0, 0, 1};
//     colorBackground[] = {0.6, 0, 0, 1};
//     x = 0.9125 * safezoneW + safezoneX;
//     w = KPLIB_TITLES_CAPTURE_FRAME_W;
//     y = 0.358 * safezoneH + safezoneY;
//     h = KPLIB_TITLES_CAPTURE_FRAME_H;

// };

// class CaptureFrame_BLUFOR : CaptureFrameStandard {
//     idc = KPLIB_IDC_UIMANAGER_SECTOR_PB_BLUFOR;
//     style = ST_TYPE;
//     colorText[] = {0, 0.2, 0.6, 1};
//     colorBackground[] = {0, 0.2, 0.6, 1};
//     x = 0.9125 * safezoneW + safezoneX;
//     w = KPLIB_TITLES_CAPTURE_FRAME_W;
//     y = 0.358 * safezoneH + safezoneY;
//     h = KPLIB_TITLES_CAPTURE_FRAME_H;
// };


        class KPLIB_hud_lnbFob : XGUI_PRE_ListNBox {
            idc = KPLIB_IDC_HUD_LNB_FOB;

            x = KPLIB_HUD_LNB_FOB_X;
            y = KPLIB_HUD_LNB_FOB_Y;
            w = KPLIB_HUD_LNB_FOB_W;
            h = KPLIB_HUD_LNB_FOB_H;

            colorBackground[] = {0.2, 0.2, 0.2, 0.5};

            font = KPX_HUD_FONT_M;
            padding = KPLIB_HUD_LNB_FOB_PADDING;
            text = "res\hud-gradient.paa";

            //          {_report, _picture}
            columns[] = {      0,      0.65};

            onLoad = "_this spawn KPLIB_fnc_hud_lnbFob_onLoad";
        };

        class KPLIB_hud_lnbFobShadow : KPLIB_hud_lnbFob {
            idc = KPLIB_IDC_HUD_LNB_FOB_SHADOW;

            x = KPLIB_HUD_LNB_FOB_X_SHADOW;
            y = KPLIB_HUD_LNB_FOB_Y_SHADOW;

            colorShadow[] = KPLIB_HUD_SHADOW_COLOR;

            onLoad = "_this spawn KPLIB_fnc_hud_lnbFob_onLoad";
        };
    };
};
