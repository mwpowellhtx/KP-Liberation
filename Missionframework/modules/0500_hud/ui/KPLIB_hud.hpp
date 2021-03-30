/*
    KPLIB HUD CONFIG

    File: KPLIB_hud.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-25 13:00:39
    Last Update: 2021-03-30 17:38:24
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
#define KPLIB_HUD_LNB_FOB_X_SHADOW          (KPLIB_HUD_LNB_FOB_X + (0.75 * KPX_SPACING_W))
#define KPLIB_HUD_LNB_FOB_Y_SHADOW          (KPLIB_HUD_LNB_FOB_Y + (0.75 * KPX_SPACING_H))

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

            colorShadow[] = {0.2, 0.2, 0.2, 0.9};

            onLoad = "_this spawn KPLIB_fnc_hud_lnbFob_onLoad";
        };
    };
};
