/*
    KPLIB HUD CONFIG

    File: KPLIB_hud.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-25 13:00:39
    Last Update: 2021-03-25 13:00:42
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

    References:
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
        https://community.bistudio.com/wiki/Arma:_GUI_Configuration#Common_Properties
 */

// TODO: TBD: these are really off the cuff...
// TODO: TBD: might be better if we took a little time to lay it out in spreadsheet story board
// TODO: TBD: they do not need to be exactly the same width...
// TODO: TBD: in fact, the sector group should perhaps be wider...

// #define KPLIB_HUD_GRPFOB_W                  ((0.75 * KPX_DEFAULT_SIDEBAR_W) - (2 * KPX_SPACING_W))
// #define KPLIB_HUD_GRPFOB_X                  (KPX_DEFAULT_SIDEBAR_XR + KPX_SPACING_W + (KPX_DEFAULT_SIDEBAR_W - KPLIB_HUD_GRPFOB_W))
// #define KPLIB_HUD_GRPFOB_H                  (KPX_DEFAULT_SIDEBAR_H - (2 * KPX_SPACING_H))
// #define KPLIB_HUD_GRPFOB_Y                  KPX_DEFAULT_SIDEBAR_YB0

// // TODO: TBD: starting with this for height
// #define KPLIB_HUD_GRP_TITLE_H               KPX_BUTTON_L_H

// #define KPLIB_HUD_GRPFOB_LBLPICTURE_X       KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,12,16,KPX_SPACING_W)
// #define KPLIB_HUD_GRPFOB_LBLPICTURE_W       KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,4,16,KPX_SPACING_W)

// // Leaving enough geometry for the PICTURE
// #define KPLIB_HUD_GRPFOB_LBLTEXT_W          KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,11,16,KPX_SPACING_W)

// // Remember, as long as this is in a "group" then the coords are relative
// #define KPLIB_HUD_TEST_W            (0.5 * (KPLIB_HUD_GRPFOB_W - KPX_SPACING_W))
// #define KPLIB_HUD_TEST_X0           ((0.5 * KPLIB_HUD_TEST_W) + KPX_SPACING_W)

// #define KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_W     KPX_GETW_VWGS(KPLIB_HUD_GRPFOB_W,4,16,KPX_SPACING_W)
// #define KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_H     KPX_GETH_VHGS(KPLIB_HUD_GRPFOB_H,4,16,KPX_SPACING_H)
// #define KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_X     (KPLIB_HUD_GRPFOB_X + KPLIB_HUD_GRPFOB_W - KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_W)

// #define KPLIB_HUD_GRPFOB_LBLMARKERTEXT_H        KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_H
// #define KPLIB_HUD_GRPFOB_LBLMARKERTEXT_W        (KPLIB_HUD_GRPFOB_W - KPLIB_HUD_GRPFOB_LBLMARKERPICTURE_W - KPX_SPACING_W)

// #define KPLIB_HUD_GRPSECTOR_W               KPX_DEFAULT_SIDEBAR_W
// #define KPLIB_HUD_GRPSECTOR_X               KPX_DEFAULT_SIDEBAR_XR
// #define KPLIB_HUD_GRPSECTOR_H               KPX_DEFAULT_SIDEBAR_H
// #define KPLIB_HUD_GRPSECTOR_Y               KPX_DEFAULT_SIDEBAR_YB1


/*
    --- FOB CT_CONTROLS_TABLE geometry ---
 */




#define KPLIB_HUD_LNB_FOB_W                 (0.3 * KPX_DEFAULT_SIDEBAR_CTRLAREA_W)
#define KPLIB_HUD_LNB_FOB_X                 (KPX_DEFAULT_SIDEBAR_CTRLAREA_XR + (KPX_DEFAULT_SIDEBAR_CTRLAREA_W - KPLIB_HUD_LNB_FOB_W))
#define KPLIB_HUD_LNB_FOB_Y                 KPX_DEFAULT_SIDEBAR_CTRLAREA_YB
#define KPLIB_HUD_LNB_FOB_H                 (KPX_BUTTON_L_H + (10 * (KPX_SPACING_H + KPX_BUTTON_M_H)))

// Offset by just a little bit, plus using a shadow color, gives the impression of a raised, shadow effect
#define KPLIB_HUD_LNB_FOB_X_SHADOW          (KPLIB_HUD_LNB_FOB_X + (0.75 * KPX_SPACING_W))
#define KPLIB_HUD_LNB_FOB_Y_SHADOW          (KPLIB_HUD_LNB_FOB_Y + (0.75 * KPX_SPACING_H));

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

#define KPLIB_HUD_CT_FOB_ROW_REPORT_W       KPX_GETW_VWGS(KPLIB_HUD_CT_FOB_ROWBG_W,4,5,KPX_SPACING_W)
#define KPLIB_HUD_CT_FOB_ROW_REPORT_X       0
#define KPLIB_HUD_CT_FOB_ROW_PICTURE_W      (KPLIB_HUD_CT_FOB_ROWBG_W - KPLIB_HUD_CT_FOB_ROW_REPORT_W - KPX_SPACING_W)
#define KPLIB_HUD_CT_FOB_ROW_PICTURE_X      (KPLIB_HUD_CT_FOB_ROW_REPORT_W + KPX_SPACING_W)
#define KPLIB_HUD_CT_FOB_ROW_H              KPX_BUTTON_M_H

#define KPLIB_HUD_CT_FOB_HEADER_REPORT_W    KPLIB_HUD_CT_FOB_ROW_REPORT_W
#define KPLIB_HUD_CT_FOB_HEADER_REPORT_X    KPLIB_HUD_CT_FOB_ROW_REPORT_X
#define KPLIB_HUD_CT_FOB_HEADER_PICTURE_W   KPLIB_HUD_CT_FOB_ROW_PICTURE_W
#define KPLIB_HUD_CT_FOB_HEADER_PICTURE_X   KPLIB_HUD_CT_FOB_ROW_PICTURE_X
#define KPLIB_HUD_CT_FOB_HEADER_H           KPX_BUTTON_L_H


// // TODO: TBD: using these as a basis, reference
// KPX_DEFAULT_SIDEBAR_YB0
// KPX_DEFAULT_SIDEBAR_YB1
// KPX_DEFAULT_SIDEBAR_W
// KPX_DEFAULT_SIDEBAR_H

// TODO: TBD: should consider refactoring the RscTitles themselves...
// TODO: TBD: along similar lines as with the functions, statemachine, etc...
// TODO: TBD: which would allow for potentially multiple different layers supported by other modules
class RscTitles {

    // // TODO: TBD: "Intro" cameras were an artifact of the legacy mod...
    // // TODO: TBD: we may pick these back up again in the future, but in the meanwhile, commented out...
    // class Intro1 {
    //     name = "Intro1";
    //     duration = 4;
    //     idd = KPLIB_IDD_UNDEFINED;
    //     movingEnable = false;
    //     controls[]=
    //    {
    //         GenericLabelShadow, GenericLabel2
    //     };

    //     class GenericLabel2 {
    //         idc = KPLIB_IDC_UNDEFINED;
    //         type =  CT_STATIC;
    //         style = ST_CENTER;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.035 * safezoneH;
    //         x = 0.3 * safezoneW + safezoneX;
    //         w = 0.4 * safezoneW;
    //         y = 0.65 * safezoneH + safezoneY;
    //         h = 0.1 * safezoneH;
    //         text = KPLIB_UIMANAGER_LBL_TEXT;
    //         shadow = SH_NO_SHADOW;
    //     };

    //     class GenericLabelShadow : GenericLabel2 {
    //         shadow = SH_STROKE;
    //     };
    // };

    // class Intro2 {
    //     name = "Intro2";
    //     duration = 7;
    //     idd = KPLIB_IDD_UNDEFINED;
    //     movingEnable = false;
    //     controls[] =
    //    {
    //         VersionLabelShadow, Splash, VersionLabel
    //     };

    //     class Splash {
    //         idc = KPLIB_IDC_UNDEFINED;
    //         type =  CT_STATIC ;
    //         style = ST_PICTURE;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.1 * safezoneH;
    //         x = 0.325 * safezoneW + safezoneX;
    //         w = 0.35 * safezoneW;
    //         y = 0.2 * safezoneH + safezoneY;
    //         h = 0.6 * safezoneH;
    //         text = "res\splash_libe2.paa";
    //     };

    //     class VersionLabel {
    //         idc = KPLIB_IDC_UNDEFINED;
    //         type =  CT_STATIC;
    //         style = ST_CENTER;
    //         shadow = SH_NO_SHADOW;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.035 * safezoneH;
    //         x = 0.45 * safezoneW + safezoneX;
    //         w = 0.3 * safezoneW;
    //         y = 0.65 * safezoneH + safezoneY;
    //         h = 0.1 * safezoneH;
    //         text = $STR_MISSION_VERSION;
    //     };

    //     class VersionLabelShadow : VersionLabel {
    //         shadow = SH_STROKE;
    //         font = KPX_HUD_FONT_M;
    //     };
    // };

    // // TODO: TBD: the legacy mod also had HALO support which used "FastTravel"...
    // // TODO: TBD: not so this one, at least not for the moment...
    // class FastTravel {
    //     name = "FastTravel";
    //     duration = 4;
    //     idd = -1;
    //     movingEnable = true;
    //     controls[]= {
    //         OuterBackground,GenericLabel111
    //     };

    //     class OuterBackground {
    //         idc = -1;
    //         type =  CT_STATIC ;
    //         style = ST_LEFT;
    //         colorText[] = COLOR_BLACK;
    //         colorBackground[] = COLOR_BLACK;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.023;
    //         x = -3; y = -3;
    //         w = 9;  h = 9;
    //         text = "";
    //     };

    //     class GenericLabel111 {
    //         idc = -1;
    //         type =  CT_STATIC ;
    //         style = ST_CENTER;
    //         colorText[] = COLOR_WHITE;
    //         colorBackground[] = COLOR_NOALPHA;
    //         font = KPX_HUD_FONT_M;
    //         sizeEx = 0.03;
    //         x = 0; y = 0.75;
    //         w = 1.0;  h = 0.1;
    //         text = $STR_DEPLOY_IN_PROGRESS;
    //     };
    // };

    class KPLIB_hud {
        idd = KPLIB_IDD_UNDEFINED;
        // Duration of fade in/out effects when opening/closing in seconds
        fadeIn = 0;
        fadeOut = 0;
        duration = 1e+011; // Must be a good long number, in seconds to expect it to stuck around
        movingEnable = true;
        controls[] = {};
    };

    class KPLIB_hud_blank : KPLIB_hud {
        name = "KPLIB_hud_blank";
        idd = KPLIB_IDD_HUD_OVERLAY;

        // Unfortunately cannot drop this on the base class and pickup a derived attribute
        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hud_blank')]) spawn KPLIB_fnc_hud_onLoad";
        // onUnload = "_this spawn KPLIB_fnc_hud_onUnload";
    };

    // Separate key sitrep bits for use via a layered cutRsc approach
    class KPLIB_hud_overlay : KPLIB_hud {
        name = "KPLIB_hud_overlay";
        idd = KPLIB_IDD_HUD_OVERLAY;

        // Unfortunately cannot drop this on the base class and pickup a derived attribute
        onLoad = "(_this + [(missionConfigFile >> 'RscTitles' >> 'KPLIB_hud_overlay')]) spawn KPLIB_fnc_hud_onLoad";
        // onUnload = "_this spawn KPLIB_fnc_hud_onUnload";

        controls[] = {
            // KPLIB_hud_ctSector
            //KPLIB_hud_ctFob
            KPLIB_hud_lnbFob
            , KPLIB_hud_lnbFobShadow
        };

        // class KPLIB_hud_grpCtrlsGroupBase {
        //     idc = KPLIB_IDC_UNDEFINED;
        //     type = CT_CONTROLS_GROUP;
        //     style = ST_MULTI;
        //     x = 0;
        //     y = 0;
        //     w = 0;
        //     h = 0;
        //     colorBackground[] = {0, 0, 0, 0.15};
        //     // TODO: TBD: scroll bars are not really appropriate for this use, but they come with the territory
        //     // TODO: TBD: can they be disabled at all? or hidden?
        //     class VScrollbar : XGUI_PRE_ScrollBar {
        //         // color[] = {1, 1, 1, 1};
        //         // width = 0.021;
        //         // autoScrollEnabled = 1;
        //     };
        //     class HScrollbar : XGUI_PRE_ScrollBar {
        //         // color[] = {1, 1, 1, 1};
        //         // height = 0.028;
        //     };
        //     lineHeight = 0;
        //     controls[] = {};
        //     // // TODO: TBD: what to do with scrollbars... really want to lay it out in such a way as to disable it
        //     //class HScrollbar {};
        //     //class VScrollbar {};
        //     onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
        // };

        class KPLIB_hud_ctFob_lblBase : XGUI_PRE_Label {
            colorBackground[] = COLOR_NOALPHA;
            font = KPX_HUD_FONT_M;
            style = ST_RIGHT + ST_SHADOW;
            sizeEx = KPX_TITLE_M_H;
            shadow = SH_STROKE;
            onLoad = "_this spawn KPLIB_fnc_hud_ctFob_ctrl_onLoad";
        };

        class KPLIB_hud_ctFob_lblCtBackground : KPLIB_hud_ctFob_lblBase {
        };

        class KPLIB_hud_ctFob_lblReportBase : KPLIB_hud_ctFob_lblBase {
        };

        class KPLIB_hud_ctFob_lblHeaderReportBase : KPLIB_hud_ctFob_lblReportBase {
            sizeEx = KPX_TITLE_L_H;
        };

        class KPLIB_hud_ctFob_lblPictureBase : XGUI_PRE_PictureRatio {
            shadow = SH_STROKE;
            onLoad = "_this spawn KPLIB_fnc_hud_ctFob_ctrl_onLoad";
        };

        // class KPLIB_hud_lblTextBase : XGUI_PRE_Label {
        //     h = KPLIB_HUD_TEST_H;
        //     style = ST_RIGHT + ST_SHADOW;
        //     colorBackground[] = COLOR_NOALPHA;
        //     font = KPX_HUD_FONT_M;
        //     sizeEx = KPX_TITLE_L_H;
        //     shadow = SH_STROKE;
        //     onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
        //     // Report which HASHMAP keys are required for the 'text' and 'colorText' attributes
        //     hashMapKey = "";
        //     hashMapColorKey = "";
        // };

        // class KPLIB_hud_lblPictureBase : XGUI_PRE_PictureRatio {
        //     h = KPLIB_HUD_TEST_H;
        //     onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
        //     hashMapKey = "";
        //     hashMapColorKey = "";
        // };

        // // TODO: TBD: have not crossed the SECTOR bridge yet...
        // class KPLIB_hud_grpSector : KPLIB_hud_grpCtrlsGroupBase {
        //     idc = KPLIB_IDC_HUD_GRPSECTOR;
        //     x = KPLIB_HUD_GRPSECTOR_X;
        //     y = KPLIB_HUD_GRPSECTOR_Y;
        //     w = KPLIB_HUD_GRPSECTOR_W;
        //     h = KPLIB_HUD_GRPSECTOR_H;

        //     class controls {

        //         // TODO: TBD: not counting sector image geometries, for the moment...
        //         class KPLIB_hud_grpSector_lblMarkerText : KPLIB_hud_lblTextBase {
        //             idc = KPLIB_IDC_HUD_GRPSECTOR_LBLMARKERTEXT;
        //             h = KPLIB_HUD_GRP_TITLE_H;
        //             hashMapKey = "KPLIB_hudDispatchSM_sectorReport_markerText";
        //             onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
        //         };
        //     };
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
            idc = KPLIB_IDC_HUD_LNB_FOB;

            x = KPLIB_HUD_LNB_FOB_X_SHADOW;
            y = KPLIB_HUD_LNB_FOB_X_SHADOW;

            colorShadow[] = {0.2, 0.2, 0.2, 0.9};

            onLoad = "_this spawn KPLIB_fnc_hud_lnbFob_onLoad";
        };

        class KPLIB_hud_ctFob : XGUI_PRE_ControlsTable {
            idc = KPLIB_IDC_HUD_CT_FOB;

            x = KPLIB_HUD_CT_FOB_X;
            y = KPLIB_HUD_CT_FOB_Y;
            w = KPLIB_HUD_CT_FOB_W;
            h = KPLIB_HUD_CT_FOB_H;

            // TODO: TBD: connect the dots, load header/rows on load
            // TODO: TBD: also relay expected report names at that time
            onLoad = "_this spawn KPLIB_fnc_hud_ctFob_onLoad";

            // Between each of the rows
            colorBackground[] = {0.25, 0.25, 0.25, 0.75};
            // TODO: TBD: can this, or maybe the BG header/rows contain a gradient images background (?)

            headerHeight = KPLIB_HUD_CT_FOB_HEADER_H;
            rowHeight = KPLIB_HUD_CT_FOB_ROW_H;
            lineSpacing = KPLIB_HUD_CT_FOB_LINE_SPACING;

            firstIDC = KPLIB_IDC_HUD_CT_FOB_IDC_FIRST;
            lastIDC = KPLIB_IDC_HUD_CT_FOB_IDC_LAST;

            // Template for headers (unlike rows, cannot be selected)
            class HeaderTemplate {
                class HeaderBackground {
                    // TODO: TBD: make it transparent, or transluscent, or with a background image (?)
                    controlBaseClassPath[] = {"KPLIB_hud_ctFob_lblCtBackground"};
                    columnX = KPLIB_HUD_CT_FOB_HEADERBG_X;
                    columnW = KPLIB_HUD_CT_FOB_HEADERBG_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_HUD_CT_FOB_HEADER_H;
                };

                class KPLIB_hud_ctFob_headerTemplate_lblReport {
                    controlBaseClassPath[] = {"KPLIB_hud_ctFob_lblHeaderReportBase"};
                    columnX = KPLIB_HUD_CT_FOB_HEADER_REPORT_X;
                    columnW = KPLIB_HUD_CT_FOB_HEADER_REPORT_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_HUD_CT_FOB_HEADER_H;
                };

                class KPLIB_hud_ctFob_headerTemplate_lblPicture {
                    controlBaseClassPath[] = {"KPLIB_hud_ctFob_lblPictureBase"};
                    columnX = KPLIB_HUD_CT_FOB_HEADER_PICTURE_X;
                    columnW = KPLIB_HUD_CT_FOB_HEADER_PICTURE_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_HUD_CT_FOB_HEADER_H;
                };
            };

            // For the most part, rinse and repeat HEADER TEMPLATE except for a few minor details
            class RowTemplate {
                class RowBackground {
                    // TODO: TBD: make it transparent, or transluscent, or with a background image (?)
                    controlBaseClassPath[] = {"KPLIB_hud_ctFob_lblCtBackground"};
                    columnX = KPLIB_HUD_CT_FOB_ROWBG_X;
                    columnW = KPLIB_HUD_CT_FOB_ROWBG_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_HUD_CT_FOB_ROW_H;
                };

                class KPLIB_hud_ctFob_rowTemplate_lblReport {
                    controlBaseClassPath[] = {"KPLIB_hud_ctFob_lblReportBase"};
                    columnX = KPLIB_HUD_CT_FOB_ROW_REPORT_X;
                    columnW = KPLIB_HUD_CT_FOB_ROW_REPORT_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_HUD_CT_FOB_ROW_H;
                };

                class KPLIB_hud_ctFob_rowTemplate_lblPicture {
                    controlBaseClassPath[] = {"KPLIB_hud_ctFob_lblPictureBase"};
                    columnX = KPLIB_HUD_CT_FOB_ROW_PICTURE_X;
                    columnW = KPLIB_HUD_CT_FOB_ROW_PICTURE_W;
                    controlOffsetY = 0;
                    controlH = KPLIB_HUD_CT_FOB_ROW_H;
                };
            };
        };

        // // TODO: TBD: draft starting with control group well enough
        // // TODO: TBD: however, there is too much to rinse and repeat do not want to get caut up in this
        // // TODO: TBD: controls table isn't perfect either, but we can iterate some loops in its onLoad event
        // class KPLIB_hud_grpFob : KPLIB_hud_grpCtrlsGroupBase {
        //     idc = KPLIB_IDC_HUD_GRPFOB;
        //     x = KPLIB_HUD_GRPFOB_X;
        //     y = KPLIB_HUD_GRPFOB_Y;
        //     w = KPLIB_HUD_GRPFOB_W;
        //     h = KPLIB_HUD_GRPFOB_H;

        //     class controls {

        //         // TODO: TBD: not counting FOB images, for the moment...
        //         class KPLIB_hud_grpFob_lblMarkerText : KPLIB_hud_lblTextBase {
        //             idc = KPLIB_IDC_HUD_GRPFOB_LBLMARKERTEXT;
        //             w = KPLIB_HUD_GRPFOB_LBLTEXT_W;
        //             h = KPLIB_HUD_GRP_TITLE_H;
        //             hashMapKey = "KPLIB_hudDispatchSM_fobReport_markerText";
        //             hashMapColorKey = "KPLIB_hudDispatchSM_fobReport_markerColor";
        //             //onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
        //         };

        //         // With alignment on the RHS of the label: i.e. [ ---- MARKER TEXT [IMG] ]
        //         class KPLIB_hud_grpFob_lblMarkerPicture : KPLIB_hud_lblPictureBase {
        //             idc = KPLIB_IDC_HUD_GRPFOB_LBLMARKERPICTURE;
        //             x = KPLIB_HUD_GRPFOB_LBLPICTURE_X;
        //             w = KPLIB_HUD_GRPFOB_LBLPICTURE_W;
        //             h = KPLIB_HUD_GRP_TITLE_H;
        //             hashMapKey = "KPLIB_hudDispatchSM_fobReport_markerPath";
        //             hashMapColorKey = "KPLIB_hudDispatchSM_fobReport_markerColor";
        //             //onLoad = "_this spawn KPLIB_fnc_hud_ctrlBase_onLoad";
        //         };
        //     };
        // };
    };

    // class KPLIB_hud_overlay_fobSitrep : KPLIB_hud_overlay_sitrep {
    //     name = "KPLIB_hud_overlay_fobSitrep";
    //     idd = KPLIB_IDD_HUD_OVERLAY;
    //     onLoad = "";
    //     controls[] = {
    //         // TODO: TBD: add control classes here...
    //     };
    // };

    // class KPLIB_hud_overlay_sectorSitrep : KPLIB_hud_overlay_sitrep {
    //     name = "KPLIB_hud_overlay_sectorSitrep";
    //     idd = KPLIB_IDD_HUD_OVERLAY_SITREP_SECTOR;
    //     controls[] = {
    //         // TODO: TBD: add control classes here...
    //     };
    // };

    // // TODO: TBD: possibly for future use, but not right this moment...
    // class KPLIB_hud_overlay_haloSitrep : KPLIB_hud_overlay_sitrep {
    // };
};
